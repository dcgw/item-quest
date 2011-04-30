package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.ld20.Main;

    public class OldMan extends Entity {
        [Embed(source="OldMan.png")]
        private static const OldManImage:Class;

        private static const WIDTH:Number = 24;
        private static const HEIGHT:Number = 24;

        public function OldMan () {
            graphic = new Image(OldManImage);
            graphic.x = -Math.ceil(WIDTH/2);
            graphic.y = -HEIGHT;

            x = WIDTH - IntroWorld.SCROLL_BACK;
            y = Math.ceil(Main.HEIGHT / 2);
        }
    }
}
