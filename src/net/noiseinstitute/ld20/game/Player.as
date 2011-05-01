package net.noiseinstitute.ld20.game {
    import net.noiseinstitute.ld20.Main;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.masks.Hitbox;
    import net.flashpunk.utils.Input;

    public class Player extends StackThing {
        [Embed(source="Player.png")]
        private static const PlayerSpritemap:Class;

        private static const ACCELERATION:Number = 720 / Main.FPS / Main.FPS;
        private static const DECELERATION:Number = 1080 / Main.FPS / Main.FPS;
        private static const MAX_SPEED:Number = 360 / Main.FPS;

        public static const WIDTH:int = 15;
        private static const HEIGHT:int = 25;

        private static const FRAME_RATE:Number = 15 / Main.FPS;
        private static const BOB_INCREMENT:Number = FRAME_RATE/4 * (Math.PI*2);

        private var _spritemap:Spritemap;

        private var _frame:uint = 0;

        private var _alive:Boolean = true;

        public function Player () {
            width = WIDTH;
            height = HEIGHT;

            _spritemap = new Spritemap(PlayerSpritemap, WIDTH, HEIGHT);
            _spritemap.add("walk-right", [0, 1, 2, 3], FRAME_RATE);

            _spritemap.x = -Math.ceil(WIDTH/2);
            _spritemap.y = -HEIGHT;

            _spritemap.play("walk-right");

            graphic = _spritemap;

            mask = new Hitbox(WIDTH, HEIGHT-1, -Math.ceil(WIDTH/2), -HEIGHT);

            x = GameWorld.WIDTH/2;
            y = Main.HEIGHT - 31;

            _bobPosition = Math.PI + Math.PI;
        }

        public override function update():void {
            if (collide(Fire.TYPE, x, y)) {
                die();
                return;
            }

            var movingLeft:Boolean = Input.check(Input.keys("left"));
            var movingRight:Boolean = Input.check(Input.keys("right"));
            if (movingRight && !movingLeft) {
                _vx += ACCELERATION;
            } else if (movingLeft && !movingRight) {
                _vx -= ACCELERATION;
            } else if (_vx > 0) {
                _vx -= DECELERATION;
                if (_vx < 0) {
                     _vx = 0;
                }
            } else if (_vx < 0) {
                _vx += DECELERATION;
                if (_vx > 0) {
                    _vx = 0;
                }
            }

            if (_vx > MAX_SPEED) {
                _vx = MAX_SPEED;
            } else if (_vx < -MAX_SPEED) {
                _vx = -MAX_SPEED;
            }

            ++_frame;
            _bobPosition = Math.PI + Math.PI + _frame * BOB_INCREMENT;

            super.update();

            if (left < 0) {
                x = x - left;
                if (_vx < 0) {
                    _vx = -_vx;
                }
            }

            if (right > GameWorld.WIDTH) {
                x = GameWorld.WIDTH - (right - x);
                if (_vx > 0) {
                    _vx = -_vx;
                }
            }
        }

        public override function get resting():Boolean {
            return _alive;
        }

        private function die ():void {
            _alive = false;
            world.remove(this);
        }
    }
}
