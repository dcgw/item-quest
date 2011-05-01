package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;

    public class Dialogue extends Entity {
        [Embed(source="celtic-bit-thin.ttf", embedAsCFF="false", fontFamily="CelticBitThin")]
        private static const CelticBitThin:Class;

        private var _text:Text;

        private var _lines:Vector.<String>;

        public function Dialogue () {
            _lines = Vector.<String>([
                "Old Man: " +
                        SelectWord(Vector.<String>(["Wait", "Hark", "Give heed"])) +
                        " . . . !",
                "Old Man: Before " +
                        SelectWord(Vector.<String>(["embarking on", "commencing", "you set off on", "you set sail on",
                                "departing on", "leaving on", "entering upon"])) +
                        " your " +
                        SelectWord(Vector.<String>(["noble", "dangerous", "introspective", "exciting", "irrelevant",
                                "gentle", "benificent", "magnanimous", "lofty", "imperial", "meritorious",
                                "grand", "prudent", "honourable", "great", "stupid", "pretentious", "august",
                                "little", "splendid", "boring", "stately", "tedious", "humble", "deadly", "fatal",
                                "perilous", "final", "expedient", "illegal"])) +
                        " " +
                        SelectWord(Vector.<String>(["quest", "picnic", "excursion", "mission", "trip", "journey",
                                "outing", "crusade", "adventure", "undertaking", "expedition", "voyage"])) +
                        ", " +
                        SelectWord(Vector.<String>(["accept", "receive", "have", "grasp"])) +
                        " these " +
                        SelectWord(Vector.<String>(["enchanted", "magical", "expensive", "useful", "useless",
                                "disposable", "unnecessary", "ingestible", "mystical", "stolen", "decorative",
                                "heavy", "bewitched", "powerful", "ancient", "imaginary", "otherworldly",
                                "radioactive", "interesting", "parapsychological", "'interesting'",
                                "ensorcelled", "expedient", "spellbound", "thaumaturgic", "extraordinary",
                                "preposterous", "wonderful", "Tesco Value", "advantageous", "commodious",
                                "delicious", "imitation", "pragmatic", "practical", "salubrious", "practicable",
                                "utile", "propitious", "three-dimensional"])) +
                        " " +
                        SelectWord(Vector.<String>(["items", "things", "objects", "gadgets", "commodities",
                                "bits and bobs", "contrivances", "goods", "artifacts", "relics"])) +
                        " I have " +
                        SelectWord(Vector.<String>(["procured", "stolen", "purchased", "acquired", "obtained",
                                "collected", "appropriated", "found", "constructed", "secured", "gathered"])) +
                        " to " +
                        SelectWord(Vector.<String>(["assist", "help", "aid", "abet", "support", "enrich",
                                "embiggen", "empower"]))
            ]);

            _text = new Text(_lines[1]);
            _text.font = "CelticBitThin";
            _text.size = 8;
            _text.color = 0xffffff;
            _text.scrollX = 0;
            _text.scrollY = 0;

            graphic = _text;
        }

        private function SelectWord (words:Vector.<String>):String {
            return words[Math.floor(Math.random() * words.length)];
        }
    }
}
