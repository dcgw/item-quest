package net.noiseinstitute.ld20.intro {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.ld20.Main;

    public class Dialogue extends Entity {
        [Embed(source="celtic-bit-thin.ttf", embedAsCFF="false", fontFamily="CelticBitThin")]
        private static const CelticBitThin:Class;

        private static const Y:Number = Ground.START_BOTTOM + MARGIN;
        private static const MARGIN:Number = 8;
        private static const WIDTH:Number = Main.WIDTH - MARGIN - MARGIN;
        private static const HEIGHT:Number = Main.HEIGHT;

        private static const START_FRAME:int = 1 * Main.FPS;

        private static const APPEND_INTERVAL:Number = 1/30 * Main.FPS;
        private static const REMAIN_TIME_PER_LETTER:Number = 1/20 * Main.FPS;

        private var _callback:Function;

        private var _text:Text;

        private var _lines:Vector.<String>;
        private var _frame:int = 0;
        private var _lastAppendFrame:int = START_FRAME;

        private var _completeLineFrame:int = 0;

        private var _lastBreakPoint:int = 0;
        private var _line:int = 0;
        private var _letter:int = 0;

        public function Dialogue (callback:Function) {
            _callback = callback;

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
                                "utile", "propitious", "three-dimensional", "assorted"])) +
                        " " +
                        SelectWord(Vector.<String>(["items", "things", "objects", "gadgets", "commodities",
                                "bits and bobs", "contrivances", "goods", "artifacts", "relics", "doodads",
                                "cadigans", "widgets", "whatsits", "utensils", "thingums", "contraptions"])) +
                        " that I have " +
                        SelectWord(Vector.<String>(["procured", "stolen", "purchased", "acquired", "obtained",
                                "collected", "appropriated", "found", "constructed", "secured", "gathered"])) +
                        " to " +
                        SelectWord(Vector.<String>(["assist", "help", "aid", "abet", "support", "enrich",
                                "embiggen", "empower"])) +
                        " you."
            ]);

            x = MARGIN;
            y = Y;

            _text = new Text("", 0, 0, WIDTH, HEIGHT);
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

        public override function update():void {
            ++_frame;
            if (_line < _lines.length) {
                var line:String = _lines[_line];
                while (_frame - APPEND_INTERVAL > _lastAppendFrame) {
                    if (_letter < line.length) {
                        var ch:String = line.charAt(_letter);
                        _text.text += ch;
                        if (_text.width > WIDTH) {
                            _text.text = _text.text.substr(0, _lastBreakPoint) + "\n" +
                                    _text.text.substr(_lastBreakPoint + 1);
                        }
                        if (ch == " " || ch == "-") {
                            _lastBreakPoint = _letter;
                        }
                        if (++_letter == line.length) {
                            _completeLineFrame = _frame;
                        }
                    }
                    _lastAppendFrame += APPEND_INTERVAL;
                }

                if (_letter >= line.length) {
                    if (_frame - REMAIN_TIME_PER_LETTER * line.length > _completeLineFrame) {
                        _text.text = "";
                        _letter = 0;
                        _lastBreakPoint = 0;
                        if (++_line == _lines.length && _callback != null) {
                            _callback();
                        }
                    }
                }
            }

            super.update();
        }
    }
}
