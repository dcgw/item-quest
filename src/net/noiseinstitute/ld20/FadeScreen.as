package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class FadeScreen extends Entity {
        private var _fadeFunction:Function;

        public function fadeOut(colour:int, time:int, callback:Function=null):void {
            var image:Image = Image.createRect(Main.WIDTH, Main.HEIGHT, colour);
            image.alpha = 0;
            image.scrollX = 0;
            image.scrollY = 0;
            graphic = image;

            var tick:int = 0;
            _fadeFunction = function():void {
                image.alpha = tick/time;
                if (tick >= time) {
                    _fadeFunction = null;
                    if (callback != null) {
                        callback();
                    }
                }
                ++tick;
            }
        }

        public function fadeIn(colour:int, time:int, callback:Function=null):void {
            var image:Image = Image.createRect(Main.WIDTH, Main.HEIGHT, colour);
            image.alpha = 1;
            image.scrollX = 0;
            image.scrollY = 0;
            graphic = image;

            var tick:int = 0;
            _fadeFunction = function():void {
                image.alpha = 1 - tick/time;
                if (tick >= time) {
                    graphic = null;
                    _fadeFunction = null;
                    if (callback != null) {
                        callback();
                    }
                }
                ++tick;
            }
        }

        public override function update():void {
            if (_fadeFunction != null) {
                _fadeFunction();
            }

            super.update();
        }
    }
}
