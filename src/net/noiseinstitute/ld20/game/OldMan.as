package net.noiseinstitute.ld20.game {
    import net.noiseinstitute.ld20.Main;
    import net.flashpunk.Entity;

    public class OldMan extends Entity {
        private static const VARIANCE:int = 60;
        private static const BUILDUP:int = 60;
        private static const INTERVAL:int = 2 * Main.FPS;

        private var _tick:uint = 0;

        private var _particles:Particles;

        public function OldMan(particles:Particles) {
            _particles = particles;
        }

        override public function update():void {
            ++_tick;

            if (_tick%INTERVAL == 0) {
                world.add(new Thing(Math.random()*VARIANCE + (Main.WIDTH-VARIANCE)/2, -BUILDUP, _particles));
            }
        }
    }
}
