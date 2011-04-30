package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;

    public class Player extends Entity {
        [Embed(source="Player.png")]
        private static const PlayerImage:Class;

        private static const ACCELERATION:Number = 0.2;
        private static const DECELERATION:Number = 0.3;
        private static const MAX_SPEED:Number = 6;

        private static const WIDTH:int = 15;
        private static const HEIGHT:int = 25;
        private var _spritemap:Spritemap = new Spritemap(PlayerImage, WIDTH, HEIGHT);

        private var _velocity:Number = 0;

        public function Player () {
            _spritemap.add("stand-right", [0]);
            _spritemap.add("walk-right", [0, 1, 2, 3], 0.25);

            _spritemap.x = -8;
            _spritemap.y = -25;

            _spritemap.play("walk-right");

            this.graphic = _spritemap;

            x = Main.WIDTH/2;
            y = Main.HEIGHT - 31;
        }

        public override function update():void {
            var left:Boolean = Input.check(Input.keys("left"));
            var right:Boolean = Input.check(Input.keys("right"));
            if (right && !left) {
                _velocity += ACCELERATION;
            } else if (left && !right) {
                _velocity -= ACCELERATION;
            } else if (_velocity > 0) {
                _velocity -= DECELERATION;
                if (_velocity < 0) {
                     _velocity = 0;
                }
            } else if (_velocity < 0) {
                _velocity += DECELERATION;
                if (_velocity > 0) {
                    _velocity = 0;
                }
            }

            if (_velocity > MAX_SPEED) {
                _velocity = MAX_SPEED;
            } else if (_velocity < -MAX_SPEED) {
                _velocity = -MAX_SPEED;
            }

            x += _velocity;

            super.update();
        }
    }
}
