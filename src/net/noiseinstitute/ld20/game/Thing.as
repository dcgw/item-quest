package net.noiseinstitute.ld20.game {
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.masks.Hitbox;
    import net.noiseinstitute.ld20.Main;

    public class Thing extends StackThing {
        [Embed(source="Thing.png")]
        private static const ThingSpritemap:Class;

        private static const GRAVITY:Number = 180 / Main.FPS / Main.FPS;
        private static const MAX_SPEED:Number = 300 / Main.FPS;

        public static const WIDTH:int = 15;
        private static const HEIGHT:int = 15;

        private static const ANIMATIONS:Vector.<String> = Vector.<String>([
                "grail", "dentures", "torch", "heart", "banana", "book",
                "gauntlets", "diamond", "feline", "tin", "sword", "stone"
        ]);

        private static const SCORE_PER_FRAME_PER_LAYER:Number = 100/Main.FPS;

        private static const COLLISION_ALLOWANCE:Number = 360 / Main.FPS;
        private static const KICK_UP_IN_THE_AIR_COEFFICIENT:Number = 0.8;

        private static const SAFE_SPEED:Number = 75 / Main.FPS;
        private static const FRACTION_ABOVE_SAFE_SPEED:Number = 0.7;
        private static const SAFE_SPEED_REDUCTION_COEFFICIENT_PER_LAYER:Number = 0.1;
        private static const FRACTION_ABOVE_SAFE_SPEED_REDUCTION_COEFFICIENT_PER_LAYER:Number = 0.1;

        private static const BOB_POSITION_OFFSET:Number = Math.PI/4;

        private static const HITBOX_WIDTH:int = WIDTH - 2;

        private const FIRE_PIECES:int = 8;

        private var _particles:Particles;

        private var _score:Score;

        private var _thingUponWhichIRest:StackThing;

        public override function get resting():Boolean {
            return _thingUponWhichIRest != null;
        }

        public function Thing (targetX:Number, targetY:Number, particles:Particles, score:Score) {
            _particles = particles;
            _score = score;

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
            if (y > Ground.TOP) {
                asplode();
                return;
            }

            var safeSpeed:Number = SAFE_SPEED - (_stackLayer-1)*SAFE_SPEED_REDUCTION_COEFFICIENT_PER_LAYER*SAFE_SPEED;
            var fractionAboveSafeSpeed:Number = FRACTION_ABOVE_SAFE_SPEED -
                    (_stackLayer-1)*FRACTION_ABOVE_SAFE_SPEED_REDUCTION_COEFFICIENT_PER_LAYER*FRACTION_ABOVE_SAFE_SPEED;

            if (fractionAboveSafeSpeed < 0) {
                fractionAboveSafeSpeed = 0;
            }

            if (_thingUponWhichIRest != null) {
                if (!_thingUponWhichIRest.resting) {
                    _thingUponWhichIRest = null;
                    _stackLayer = 0;
                } else if (right < _thingUponWhichIRest.left) {
                    if (_thingUponWhichIRest.vx < 0) {
                        _vx += _thingUponWhichIRest.vx;
                    }
                    _thingUponWhichIRest = null;
                    _stackLayer = 0;
                } else if (left > _thingUponWhichIRest.right) {
                    if (_thingUponWhichIRest.vx > 0) {
                        _vx += _thingUponWhichIRest.vx;
                    }
                    _thingUponWhichIRest = null;
                    _stackLayer = 0;
                } else if (Math.abs(_thingUponWhichIRest.vx) <= safeSpeed) {
                    if (Math.abs(_vx) <= safeSpeed) {
                        _vx = _thingUponWhichIRest.vx;
                    } else {
                        _vx = _thingUponWhichIRest.vx * fractionAboveSafeSpeed + _vx * (1-fractionAboveSafeSpeed);
                    }
                } else {
                    var dir:Number = _thingUponWhichIRest.vx / Math.abs(_thingUponWhichIRest.vx);
                    _vx = dir * safeSpeed + fractionAboveSafeSpeed * (_thingUponWhichIRest.vx - (dir * safeSpeed));
                }
            }

            if (_thingUponWhichIRest != null) {
                _bobPosition = _thingUponWhichIRest.bobPosition + BOB_POSITION_OFFSET;
                graphic.y = -HEIGHT + Math.sin(_bobPosition) * 1.2;

                var xDelta:Number = _thingUponWhichIRest.x - x;
                var xDeltaFraction:Number = xDelta/(WIDTH/2);
                if (xDeltaFraction < 0) {
                    xDeltaFraction = 0;
                }

                _score.addPoints(SCORE_PER_FRAME_PER_LAYER * _stackLayer * (1-xDeltaFraction));
            } else {
                graphic.y = -HEIGHT;
            }

            if (_thingUponWhichIRest == null) {
                _vy += GRAVITY;
                if (_vy > MAX_SPEED) {
                    _vy = MAX_SPEED;
                }

                var colliders:Array = [];
                collideInto(StackThing.TYPE, x, y, colliders);
                for each (var collider:StackThing in colliders) {
                    if (collider != null && collider.resting) {
                        if (bottom < collider.top + COLLISION_ALLOWANCE) {
                            _thingUponWhichIRest = collider;
                            _stackLayer = collider.stackLayer + 1;
                            y = collider.y - collider.height;
                            _vy = 0;
                            _particles.stars(x, y);
                            break;
                        } else {
                            if (x < collider.x) {
                                x = collider.left - (right - x);
                                if (collider.vx < 0) {
                                    _vx += collider.vx;
                                    if (collider is Player) {
                                        _vy -= Math.abs(collider.vx) * KICK_UP_IN_THE_AIR_COEFFICIENT;
                                    }
                                }
                            } else if (x > collider.x) {
                                x = collider.right + (x - left);
                                if (collider.vx > 0) {
                                    _vx += collider.vx;
                                    if (collider is Player) {
                                        _vy -= Math.abs(collider.vx) * KICK_UP_IN_THE_AIR_COEFFICIENT;
                                    }
                                }
                            }
                        }
                    }
                }

                _particles.sparkle(x, y, WIDTH);
            }

            super.update();
        }

        private function asplode ():void {
            for (var i:int=0; i<FIRE_PIECES; ++i) {
                var angle:Number = (30 + Math.random()*120) * Math.PI/180;
                var vx:Number = Math.cos(angle);
                var vy:Number = -Math.sin(angle);
                world.add(new Fire(x, vx, vy));
            }

            world.remove(this);
        }
    }
}
