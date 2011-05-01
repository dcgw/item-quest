package net.noiseinstitute.ld20.game {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Emitter;
    import net.noiseinstitute.ld20.Main;

    public class Particles extends Entity {
        [Embed(source="Particles.png")]
        private static const ParticlesImage:Class;

        private static const WIDTH:int = 9;
        private static const HEIGHT:int = 9;

        private static const STAR_TYPES:Vector.<String> = Vector.<String>([
                "star1", "star2", "star3", "star4", "star5", "star6",
                "star7", "star8", "star9"
        ]);

        private var _emitter:Emitter;

        public function Particles () {
            _emitter = new Emitter(ParticlesImage, WIDTH, HEIGHT);

            _emitter.x = Math.ceil(-WIDTH/2);
            _emitter.y = Math.ceil(-HEIGHT/2);

            for(var i:int=0; i<STAR_TYPES.length; ++i) {
                _emitter.newType(STAR_TYPES[i], [2 + 3*i]);
                _emitter.setMotion(STAR_TYPES[i], 30, 64, 1/3*Main.FPS, 120);
                _emitter.setAlpha(STAR_TYPES[i], 1, 0, function(a:Number) { return a*a; });
            }

            graphic = _emitter;
        }

        public function stars(x:Number, y:Number):void {
            for (var i=0; i<20; ++i) {
                _emitter.emit(STAR_TYPES[Math.floor(Math.random()*STAR_TYPES.length)], x, y);
            }
        }
    }
}
