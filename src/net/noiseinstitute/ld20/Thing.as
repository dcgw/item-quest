package net.noiseinstitute.ld20 {
    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;

    public class Thing extends Collidable {
        private static const GRAVITY:Number = 0.05;
        private static const MAX_SPEED:Number = 5;

        private static const WIDTH:int = 15;
        private static const HEIGHT:int = 15;

        private static const ALLOWANCE:Number = 4;

        private static const KICK_UP_IN_THE_AIR_AMOUNT:Number = 4;

        private var _thingUponWhichIRest:Collidable;

        public function Thing (targetX:Number, targetY:Number) {
            x = targetX;
            y = targetY;
            width = WIDTH;
            height = HEIGHT;

            graphic = Image.createRect(WIDTH, HEIGHT, 0x000000);
            graphic.x = -Math.ceil(WIDTH/2);
            graphic.y = -HEIGHT;

            mask = new Hitbox(WIDTH, HEIGHT, -Math.ceil(WIDTH/2), -HEIGHT);
        }

        public override function update():void {
            if (_thingUponWhichIRest == null) {
                _vy += GRAVITY;
                if (_vy > MAX_SPEED) {
                    _vy = MAX_SPEED;
                }

                var collider:Collidable = collide(Collidable.TYPE, x, y) as Collidable;
                if (collider != null) {
                    if (bottom < collider.top + ALLOWANCE) {
                        _thingUponWhichIRest = collider;
                        y = collider.y - collider.height;
                        _vy = 0;
                    } else {
                        _vy -= KICK_UP_IN_THE_AIR_AMOUNT;
                        if (x < collider.x) {
                            x = collider.left - (right - x);
                            if (collider.vx < 0) {
                                _vx += collider.vx;
                            }
                        } else if (x > collider.x) {
                            x = collider.right + (x - left);
                            if (collider.vx > 0) {
                                _vx += collider.vx;
                            }
                        }
                    }
                }
            }

            super.update();
        }
    }
}
