package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;

    public class OldMan extends Entity {
        private var tick:uint = 0;
        override public function update():void {
            ++tick;

            if (tick%120 == 0) {
                world.add(new Thing(Math.random()*80 + 120, -60));
            }
        }
    }
}
