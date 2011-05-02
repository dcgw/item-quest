package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.ld20.Main;

    public class Player extends Entity {
        [Embed(source="../game/Player.png")]
        private static const PlayerSpritemap:Class;

        private static const WIDTH:int = 15;
        private static const HEIGHT:int = 25;

        private static const SPEED:Number = 360/Main.FPS;
        private static const DECELERATION:Number = 1080 / Main.FPS / Main.FPS;
        private static const STOP_X:Number = Main.WIDTH - WIDTH - 64 + IntroWorld.SCROLL_FORWARD;

        private var _vx:Number;

        public function Player () {
            var spritemap:Spritemap = new Spritemap(PlayerSpritemap, WIDTH, HEIGHT);
            spritemap.add("walk-right", [0, 1, 2, 3], 15 / Main.FPS);

            spritemap.x = -Math.ceil(WIDTH/2);
            spritemap.y = -HEIGHT;

            spritemap.play("walk-right");

            graphic = spritemap;

            x = -WIDTH;
            y = Math.ceil(Main.HEIGHT / 2);

            _vx = SPEED;
        }

        public override function update():void {
            x += _vx;

            if (x >= STOP_X) {
                _vx -= DECELERATION;
                if (_vx < 0) {
                    _vx = 0;
                }
            }

            super.update();
        }
    }
}
