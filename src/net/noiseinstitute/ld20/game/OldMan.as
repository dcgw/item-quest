package net.noiseinstitute.ld20.game {
    import net.noiseinstitute.ld20.Main;
    import net.flashpunk.Entity;

    public class OldMan extends Entity {
        private static const BUILDUP:int = 60;

        private static const VARIANCE_INCREMENT:Number = 3/Main.FPS;
        private static const MAX_VARIANCE:Number = GameWorld.WIDTH/2 - Thing.WIDTH;

        private static const INTERVAL_CHANGE_COEFFICIENT:Number = 0.97;
        private static const MIN_INTERVAL:Number = 1/60 * Main.FPS;

        private var _variance:Number = 60;
        private var _interval:Number = 2 * Main.FPS;

        private var _ticks:uint = 0;

        private var _particles:Particles;
        private var _score:Score;

        public function OldMan(particles:Particles, score:Score) {
            _particles = particles;
            _score = score;
        }

        override public function update():void {
            ++_ticks;

            while (_ticks >= _interval) {
                _ticks -= _interval;
                var x:Number = Math.random()*_variance + (GameWorld.WIDTH-_variance)/2;
                var y:int = -BUILDUP;
                world.add(new Thing(x, y, _particles, _score));

                _interval *= INTERVAL_CHANGE_COEFFICIENT;
                if (_interval < MIN_INTERVAL) {
                    _interval = MIN_INTERVAL;
                }
            }

            _variance += VARIANCE_INCREMENT;
            if (_variance > MAX_VARIANCE) {
                _variance = MAX_VARIANCE;
            }
        }
    }
}
