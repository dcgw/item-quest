package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.ld20.Main;

    public class ArrowOverlay extends Entity {
        [Embed(source="ArrowOverlay.png")]
        private static const ArrowOverlayImage:Class;

        private static const WIDTH:int = 527;

        private static const VX:Number = 600/Main.FPS;

        public function ArrowOverlay () {
            graphic = new Image(ArrowOverlayImage);
            graphic.scrollX = 0;
            x = Main.WIDTH - WIDTH;
        }

        public override function update():void {
            if (x < 0) {
                x += VX;
                if (x > 0) {
                    x = 0;
                }
            }

            super.update();
        }
    }
}
