package net.noiseinstitute.ld20 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Tilemap;

    public class Background extends Entity {
        [Embed(source="Ground.png")]
        private static const GroundTilemap:Class;

        private static const TILE_WIDTH:int = 64;
        private static const TILE_HEIGHT:int = 32;

        public function Background () {
            var tilemap:Tilemap = new Tilemap(GroundTilemap,
                    Main.WIDTH + TILE_WIDTH, TILE_HEIGHT,
                    TILE_WIDTH, TILE_HEIGHT);
            tilemap.setRect(0, 0, 5, 1, 0);
            graphic = tilemap;

            x = 0;
            y = Main.HEIGHT - TILE_HEIGHT;
        }
    }
}
