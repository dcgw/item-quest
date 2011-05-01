package net.noiseinstitute.ld20.game {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.ld20.Main;

    public class Fire extends Entity {
        [Embed(source="Fire.png")]
        private static const FireSpritemap:Class;

        public static const TYPE:String = "Fire";

        private static const WIDTH:int = 9;
        private static const HEIGHT:int = 9;

        private static const FRAME_RATE:Number = 15 / Main.FPS;

        private static const GRAVITY:Number =  180 / Main.FPS / Main.FPS;
        
        private var _vx:Number;
        private var _vy:Number;

        public function Fire (x:Number, vx:Number, vy:Number) {
            this.x = x;
            y = Ground.TOP;

            _vx = vx;
            _vy = vy;

            var spritemap:Spritemap = new Spritemap(FireSpritemap, WIDTH, HEIGHT, onAnimationComplete);

            spritemap.add("fire", [0,1,2,3,4,5,6,7], FRAME_RATE, false);

            spritemap.x = -Math.ceil(WIDTH/2);
            spritemap.y = -HEIGHT;

            graphic = spritemap;

            type = TYPE;
            setHitbox(1, 1, spritemap.x, spritemap.y);

            spritemap.play("fire");
        }

        public override function update():void {
            _vy += GRAVITY;
            x += _vx;
            y += _vy;

            super.update();
        }

        private function onAnimationComplete():void {
            world.remove(this);
        }
    }
}
