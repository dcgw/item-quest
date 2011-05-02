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

        private const SPARKLE_TYPES:Vector.<String> = Vector.<String>([
            "sparkle1", "sparkle2"
        ]);

        private const SPARKLE_PROBABILITY:Number = 16/Main.FPS;

        private var _emitter:Emitter;

        public function Particles () {
            _emitter = new Emitter(ParticlesImage, WIDTH, HEIGHT);

            _emitter.x = -Math.ceil(WIDTH/2);
            _emitter.y = -Math.ceil(HEIGHT/2);

            var i:int;
            for(i=0; i<STAR_TYPES.length; ++i) {
                _emitter.newType(STAR_TYPES[i], [2 + 3*i]);
                _emitter.setMotion(STAR_TYPES[i], 30, 64, 1/3*Main.FPS, 120);
                _emitter.setAlpha(STAR_TYPES[i], 1, 0, function(a:Number):Number { return a*a; });
            }

            for (i=0; i<SPARKLE_TYPES.length; ++i) {
                _emitter.newType(SPARKLE_TYPES[i], [i, i+3, i+6, i+9, i+12, i+15, i+18, i+21, i+24]);
                _emitter.setMotion(SPARKLE_TYPES[i], 30, 16, 1/3*Main.FPS, 120);
            }

            graphic = _emitter;
        }

        public function stars(x:Number, y:Number):void {
            for (var i:int=0; i<20; ++i) {
                _emitter.emit(STAR_TYPES[Math.floor(Math.random()*STAR_TYPES.length)], x, y);
            }
        }

        public function sparkle(x:Number, y:Number, variance:Number):void {
            if (Math.random() < SPARKLE_PROBABILITY) {
                _emitter.emit(SPARKLE_TYPES[Math.floor(Math.random()*SPARKLE_TYPES.length)],
                        x + variance * (Math.random() - 0.5),
                        y + variance * (Math.random() - 0.5));
            }
        }
    }
}
