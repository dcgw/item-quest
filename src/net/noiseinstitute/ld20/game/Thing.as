package net.noiseinstitute.ld20.game {
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.masks.Hitbox;
    import net.noiseinstitute.ld20.Main;

    public class Thing extends Collidable {
        [Embed(source="Thing.png")]
        private static const ThingSpritemap:Class;

        private static const GRAVITY:Number = 180 / Main.FPS / Main.FPS;
        private static const MAX_SPEED:Number = 300 / Main.FPS;

        private static const WIDTH:int = 15;
        private static const HEIGHT:int = 15;

        private static const ANIMATIONS:Vector.<String> = Vector.<String>([
                "grail", "dentures", "torch", "heart", "banana", "book",
                "gauntlets", "diamond", "feline", "tin", "sword", "stone"
        ]);

        private static const COLLISION_ALLOWANCE:Number = 360 / Main.FPS;
        private static const KICK_UP_IN_THE_AIR_COEFFICIENT:Number = 0.8;

        private static const SAFE_SPEED:Number = 75 / Main.FPS;
        private static const FRACTION_ABOVE_SAFE_SPEED:Number = 0.7;

        private static const BOB_POSITION_OFFSET:Number = Math.PI/4;

        private static const HITBOX_WIDTH:int = WIDTH - 2;

        private var _thingUponWhichIRest:Collidable;

        public override function get resting():Boolean {
            return _thingUponWhichIRest != null;
        }

        public function Thing (targetX:Number, targetY:Number) {
            var spritemap:Spritemap = new Spritemap(ThingSpritemap, WIDTH, HEIGHT);

            for (var i:uint=0; i<ANIMATIONS.length; ++i) {
                spritemap.add(ANIMATIONS[i], [i], 0, false);
            }

            spritemap.play(ANIMATIONS[Math.floor(Math.random() * ANIMATIONS.length)]);

            spritemap.x = -Math.ceil(WIDTH/2);
            spritemap.y = -HEIGHT;

            graphic = spritemap;

            x = targetX;
            y = targetY;
            width = WIDTH;
            height = HEIGHT;

            mask = new Hitbox(HITBOX_WIDTH, HEIGHT, -Math.ceil(HITBOX_WIDTH/2), -HEIGHT);
        }

        public override function update():void {
            if (_thingUponWhichIRest != null) {
                if (!_thingUponWhichIRest.resting) {
                    _thingUponWhichIRest = null;
                } else if (right < _thingUponWhichIRest.left) {
                    if (_thingUponWhichIRest.vx < 0) {
                        _vx += _thingUponWhichIRest.vx;
                    }
                    _thingUponWhichIRest = null
                } else if (left > _thingUponWhichIRest.right) {
                    if (_thingUponWhichIRest.vx > 0) {
                        _vx += _thingUponWhichIRest.vx;
                    }
                    _thingUponWhichIRest = null;
                } else if (Math.abs(_thingUponWhichIRest.vx) <= SAFE_SPEED) {
                    if (Math.abs(_vx) <= SAFE_SPEED) {
                        _vx = _thingUponWhichIRest.vx;
                    } else {
                        _vx = _thingUponWhichIRest.vx * FRACTION_ABOVE_SAFE_SPEED + _vx * (1-FRACTION_ABOVE_SAFE_SPEED);
                    }
                } else {
                    var dir:Number = _thingUponWhichIRest.vx / Math.abs(_thingUponWhichIRest.vx);
                    _vx = dir * SAFE_SPEED + FRACTION_ABOVE_SAFE_SPEED * (_thingUponWhichIRest.vx - (dir * SAFE_SPEED));
                }
            }

            if (_thingUponWhichIRest != null) {
                _bobPosition = _thingUponWhichIRest.bobPosition + BOB_POSITION_OFFSET;
                graphic.y = -HEIGHT + Math.sin(_bobPosition) * 1.2;
            } else {
                graphic.y = -HEIGHT;
            }

            if (_thingUponWhichIRest == null) {
                _vy += GRAVITY;
                if (_vy > MAX_SPEED) {
                    _vy = MAX_SPEED;
                }

                var colliders:Array = [];
                collideInto(Collidable.TYPE, x, y, colliders);
                for each (var collider:Collidable in colliders) {
                    if (collider != null && collider.resting) {
                        if (bottom < collider.top + COLLISION_ALLOWANCE) {
                            _thingUponWhichIRest = collider;
                            y = collider.y - collider.height;
                            _vy = 0;
                            break;
                        } else {
                            if (x < collider.x) {
                                x = collider.left - (right - x);
                                if (collider.vx < 0) {
                                    _vx += collider.vx;
                                    if (collider instanceof Player) {
                                        _vy -= Math.abs(collider.vx) * KICK_UP_IN_THE_AIR_COEFFICIENT;
                                    }
                                }
                            } else if (x > collider.x) {
                                x = collider.right + (x - left);
                                if (collider.vx > 0) {
                                    _vx += collider.vx;
                                    if (collider instanceof Player) {
                                        _vy -= Math.abs(collider.vx) * KICK_UP_IN_THE_AIR_COEFFICIENT;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            super.update();
        }
    }
}
