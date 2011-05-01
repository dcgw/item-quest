package net.noiseinstitute.ld20.game {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Backdrop;
    import net.noiseinstitute.ld20.Main;

    public class Ground extends Entity {
        [Embed(source="Ground.png")]
        private static const GroundImage:Class;

        public static const TOP:Number = Main.HEIGHT - HEIGHT;
        public static const HEIGHT:Number = 32;

        public function Ground () {
            graphic = new Backdrop(GroundImage, true, false);

            x = 0;
            y = TOP;
        }
    }
}
