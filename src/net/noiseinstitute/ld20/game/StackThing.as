package net.noiseinstitute.ld20.game {
    import net.flashpunk.Entity;

    public class StackThing extends Entity {
        public static const TYPE:String = "StackThing";

        protected var _vx:Number = 0;
        protected var _vy:Number = 0;
        protected var _stackLayer:int = 0;
        protected var _bobPosition:Number = 0;

        public function StackThing() {
            type = TYPE;
        }

        public function get vx():Number {
            return _vx;
        }

        public function get vy():Number {
            return _vy;
        }

        public function get stackLayer():int {
            return _stackLayer;
        }

        public function get bobPosition():Number {
            return _bobPosition;
        }

        public function get resting():Boolean {
            return true;
        }

        public override function update():void {
            x += _vx;
            y += _vy;

            super.update();
        }
    }
}
