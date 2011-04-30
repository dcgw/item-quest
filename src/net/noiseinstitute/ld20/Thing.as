package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class Thing extends Entity {
        private static const GRAVITY:Number = 0.05;
        private static const MAX_SPEED:Number = 5;

        private var _vx:Number = 0;
        private var _vy:Number = 0;

        public function Thing (targetX:Number, targetY:Number) {
            x = targetX;
            y = targetY;

            graphic = Image.createRect(15, 15, 0x000000);
            graphic.x = -8;
            graphic.y = -15;
        }

        public override function update():void {
            x += _vx;
            y += _vy;

            _vy += GRAVITY;
            if (_vy > MAX_SPEED) {
                _vy = MAX_SPEED;
            }

            super.update();
        }
    }
}
