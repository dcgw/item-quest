package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;

    public class Player extends Entity {
        [Embed(source="Player.png")]
        private static const PlayerImage :Class;

        private var _spritemap:Spritemap = new Spritemap(PlayerImage, 15, 25);

        public function Player () {
            _spritemap.add("stand-right", [0]);
            _spritemap.add("walk-right", [0, 1, 2, 3], 0.25);

            _spritemap.x = -8;
            _spritemap.y = -25;

            _spritemap.play("walk-right");

            this.graphic = _spritemap;

            x = 160;
            y = 240 - 31;
        }

        public override function update():void {
            if (Input.check(Input.keys("left"))) {
                x--;
            }
            if (Input.check(Input.keys("right"))) {
                x++;
            }
            super.update();
        }
    }
}
