package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Backdrop;
    import net.noiseinstitute.ld20.Main;

    public class Ground extends Entity {
        [Embed(source="../game/Ground.png")]
        private static const GroundImage:Class;

        private static const HEIGHT:Number = 32;

        public function Ground () {
            graphic = new Backdrop(GroundImage, true, false);

            x = IntroWorld.SCROLL_BACK;
            y = Math.ceil(Main.HEIGHT / 2) - 1;
        }
    }
}
