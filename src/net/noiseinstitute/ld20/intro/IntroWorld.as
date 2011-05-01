package net.noiseinstitute.ld20.intro {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.noiseinstitute.ld20.Main;
    import net.noiseinstitute.ld20.game.GameWorld;

    public class IntroWorld extends World {
        public static const SCROLL_BACK:Number = 48;
        public static const SCROLL_BACK_COEFFICIENT:Number = 1.4/Main.FPS;

        public function IntroWorld () {
            FP.screen.color = 0xc62ee1;

            add(new Ground);
            add(new Player);
            add(new OldMan);
            add(new Dialogue(onDialogueComplete));
        }

        public override function update():void {
            if (FP.camera.x > -SCROLL_BACK) {
                FP.camera.x -= (FP.camera.x + SCROLL_BACK) * SCROLL_BACK_COEFFICIENT;
            }

            super.update();
        }

        private function onDialogueComplete():void {
            FP.world = new GameWorld;
        }
    }
}
