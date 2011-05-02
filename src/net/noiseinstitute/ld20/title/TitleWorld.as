package net.noiseinstitute.ld20.title {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.ld20.FadeScreen;
    import net.noiseinstitute.ld20.Main;
    import net.noiseinstitute.ld20.intro.IntroWorld;

    public class TitleWorld extends World {
        private var _clickPressText:Text;

        private var _listening:Boolean = false;
        private var _leaving:Boolean = false;
        private var _fader:FadeScreen;

        public function TitleWorld (lastScore:int=-1) {
            FP.screen.color = 0x000000;

            var entity:Entity = new Entity();
            var text:Text = new Text("Item Quest");
            text.font = Main.CELTIC_BIT_THIN;
            text.color = 0xffffff;
            text.size = 8;
            entity.x = 16;
            entity.y = 48;
            entity.graphic = text;
            add(entity);

            entity = new Entity();
            text = new Text("by Daniel Cassidy");
            text.font = Main.CELTIC_BIT_THIN;
            text.color = 0xffffff;
            text.size = 8;
            entity.x = 16;
            entity.y = 96;
            entity.graphic = text;
            add(entity);

            entity = new Entity();
            text = new Text("for Ludum Dare 20");
            text.font = Main.CELTIC_BIT_THIN;
            text.color = 0xffffff;
            text.size = 8;
            entity.x = 16;
            entity.y = 112;
            entity.graphic = text;
            add(entity);

            entity = new Entity();
            text = _clickPressText = new Text("Click here to play");
            text.font = Main.CELTIC_BIT_THIN;
            text.color = 0xffffff;
            text.size = 8;
            entity.x = 16;
            entity.y = 176;
            entity.graphic = text;
            add(entity);

            if (lastScore >= 0) {
                entity = new Entity();
                text = new Text("Last score: " + lastScore);
                text.font = Main.CELTIC_BIT_THIN;
                text.color = 0xffffff;
                text.size = 8;
                entity.x = 16;
                entity.y = 296;
                entity.graphic = text;
                add(entity);

                onFocus(null);
            }

            _fader = new FadeScreen();
            add(_fader);
        }

        public override function update():void {
            if (Input.pressed("action") && !_leaving) {
                if (_listening) {
                    FP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onFocus);
                    FP.stage.removeEventListener(Event.ACTIVATE, onFocus);
                    FP.stage.removeEventListener(Event.DEACTIVATE, onBlur);
                }

                _leaving = true;
                _fader.fadeOut(0x000000, 1/4 * Main.FPS, function():void {
                    FP.world = new IntroWorld();
                });
            }

            if (!_listening && !_leaving) {
                FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onFocus);
                FP.stage.addEventListener(Event.ACTIVATE, onFocus);
                FP.stage.addEventListener(Event.DEACTIVATE, onBlur);
                _listening = true;
            }

            super.update();
        }

        private function onBlur(event:Event):void {
            _clickPressText.text = "Click here to play";
        }

        private function onFocus(event:Event):void {
            _clickPressText.text = "Press space to play";
        }
    }
}
