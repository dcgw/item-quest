package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;

    public class Thing extends Entity {
        private static const GRAVITY:Number = 0.05;
        private static const MAX_SPEED:Number = 5;

        private static const WIDTH:int = 15;
        private static const HEIGHT:int = 15;

        private static const TYPE:String = "thing";

        private var _vy:Number = 0;

        private var _thingUponWhichIRest:Entity;

        public function Thing (targetX:Number, targetY:Number) {
            x = targetX;
            y = targetY;
            width = WIDTH;
            height = HEIGHT;

            graphic = Image.createRect(WIDTH, HEIGHT, 0x000000);
            graphic.x = -Math.ceil(WIDTH/2);
            graphic.y = -HEIGHT;

            type = TYPE;
            mask = new Hitbox(WIDTH, HEIGHT, -Math.ceil(WIDTH/2), -HEIGHT);
        }

        public override function update():void {
            if (_thingUponWhichIRest == null) {
                y += _vy;

                _vy += GRAVITY;
                if (_vy > MAX_SPEED) {
                    _vy = MAX_SPEED;
                }
            }

            var collider:Entity;
            if ((collider = collide("thing", x, y)) || (collider = collide("player", x, y))) {
                _thingUponWhichIRest = collider;
                y = collider.y - collider.height;
                _vy = 0;
            }

            super.update();
        }
    }
}
