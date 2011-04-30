package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;

    public class Collidable extends net.flashpunk.Entity {
        public static const TYPE:String = "collidable";

        protected var _vx:Number = 0;
        protected var _vy:Number = 0;

        public function Collidable() {
            type = TYPE;
        }

        public function get vx():Number {
            return _vx;
        }

        public function get vy():Number {
            return _vy;
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
