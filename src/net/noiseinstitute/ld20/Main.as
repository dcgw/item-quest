package net.noiseinstitute.ld20 {
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.noiseinstitute.ld20.intro.IntroWorld;

    [SWF(width="480", height="640", backgroundColor="#000000", frameRate="60")]
    public class Main extends Engine {
        public static const WIDTH:uint = 240;
        public static const HEIGHT:uint = 320;
        public static const FPS:uint = 120;

        public static const CELTIC_BIT_THIN:String = "CelticBitThin";

        //noinspection JSUnusedLocalSymbols
        [Embed(source="celtic-bit-thin.ttf", embedAsCFF="false", fontFamily="CelticBitThin")]
        private static const CelticBitThin:Class;

        public function Main () {
            super(WIDTH, HEIGHT, FPS, true);

            Input.define("left", Key.LEFT);
            Input.define("right", Key.RIGHT);
            Input.define("action", Key.SPACE, Key.Z, Key.X, Key.C, Key.ENTER, Key.SHIFT, Key.CONTROL);

            FP.screen.scale = 2;
            FP.world = new IntroWorld();
        }
    }
}