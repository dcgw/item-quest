package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Tilemap;

    public class Background extends Entity {
        [Embed(source="Ground.png")]
        private static const GroundTilemap:Class;

        public function Background () {
            var tilemap:Tilemap = new Tilemap(GroundTilemap, 320, 32, 64, 32);
            tilemap.setRect(0, 0, 5, 1, 0);
            graphic = tilemap;

            x = 0;
            y = 240 - 32;
        }
    }
}
