package net.noiseinstitute.ld20.game {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.noiseinstitute.ld20.Main;

    public class GameWorld extends World {
        public static const WIDTH:Number = 960;

        private var _player:Player;

        public function GameWorld () {
            FP.screen.color = 0xc62ee1;

            var particles = new Particles;
            add(particles);

            add(new Ground);

            _player = new Player;
            add(_player);

            add(new OldMan(particles));
        }

        public override function update():void {
            if (_player) {
                FP.camera.x = (WIDTH - Main.WIDTH) * _player.left/(WIDTH - Player.WIDTH);
            }

            super.update();
        }
    }
}
