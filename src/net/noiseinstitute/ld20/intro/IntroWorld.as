package net.noiseinstitute.ld20.intro {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.ld20.Main;
    import net.noiseinstitute.ld20.game.GameWorld;

    public class IntroWorld extends World {
        public static const SCROLL_FORWARD:Number = 320;
        public static const SCROLL_COEFFICIENT:Number = 2.1/Main.FPS;

        private var _action:uint = 0;

        public function IntroWorld () {
            FP.screen.color = 0xc62ee1;

            add(new Ground);
            add(new Player);
            add(new OldMan);
            add(new ArrowOverlay);
            add(new Dialogue(endIntro));
        }

        public override function update():void {
            if (Input.pressed("action")) {
                endIntro();
            }

            if (FP.camera.x < SCROLL_FORWARD) {
                FP.camera.x += (SCROLL_FORWARD - FP.camera.x) * SCROLL_COEFFICIENT;
            }

            super.update();
        }

        private function endIntro():void {
            FP.world = new GameWorld;
        }
    }
}
