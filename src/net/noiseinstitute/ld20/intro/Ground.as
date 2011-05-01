package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Backdrop;
    import net.noiseinstitute.ld20.Main;

    public class Ground extends Entity {
        [Embed(source="../game/Ground.png")]
        private static const GroundImage:Class;

        public static const HEIGHT:Number = 32;
        public static const START_BOTTOM:Number = Math.ceil(Main.HEIGHT/2) - 1 + HEIGHT;

        public function Ground () {
            graphic = new Backdrop(GroundImage, true, false);

            x = IntroWorld.SCROLL_BACK;
            y = START_BOTTOM - HEIGHT;
        }
    }
}
