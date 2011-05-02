package net.noiseinstitute.ld20.game {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.tweens.sound.Fader;
    import net.noiseinstitute.ld20.FadeScreen;
    import net.noiseinstitute.ld20.Main;

    public class GameWorld extends World {
        public static const WIDTH:Number = 960;

        private var _player:Player;
        private var _fader:FadeScreen;

        public function GameWorld () {
            FP.screen.color = 0xc62ee1;

            _fader = new FadeScreen;
            _fader.layer = -2;
            add(_fader);

            _fader.fadeIn(0xffffff, Main.FPS);

            var score:Score = new Score;
            score.layer = -1;
            add(score);

            var particles:Particles = new Particles;
            add(particles);

            add(new Ground);

            _player = new Player;
            add(_player);

            add(new OldMan(particles, score));
        }

        public override function update():void {
            if (_player) {
                FP.camera.x = (WIDTH - Main.WIDTH) * _player.left/(WIDTH - Player.WIDTH);
            }

            super.update();
        }
    }
}
