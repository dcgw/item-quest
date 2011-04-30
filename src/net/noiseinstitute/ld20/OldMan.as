package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;

    public class OldMan extends Entity {
        private static const VARIANCE:int = 60;
        private static const BUILDUP:int = 60;
        private static const INTERVAL:int = 2 * Main.FPS;

        private var tick:uint = 0;

        override public function update():void {
            ++tick;

            if (tick%INTERVAL == 0) {
                world.add(new Thing(Math.random()*VARIANCE + (Main.WIDTH-VARIANCE)/2, -BUILDUP));
            }
        }
    }
}
