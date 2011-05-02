package net.noiseinstitute.ld20.game {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.ld20.Main;

    public class Score extends Entity {

        private static const MARGIN:int = 4;

        private var _text:Text;

        private var _score:Number = 0;

        public function get score():int {
            return Math.floor(_score);
        }

        public function Score () {
            _text = new Text("", MARGIN, MARGIN, Main.WIDTH, Main.HEIGHT);
            _text.font = Main.CELTIC_BIT_THIN;
            _text.size = 8;
            _text.color = 0x000000;
            _text.scrollX = 0;
            _text.scrollY = 0;

            graphic = _text;
        }

        public function addPoints(points:Number):void {
            if (points >= 0) {
                _score += points;
            }
        }

        public override function update():void {
            _text.text = score.toString();
            super.update();
        }
    }
}
