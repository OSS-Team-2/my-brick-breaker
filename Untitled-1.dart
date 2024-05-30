import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'ball.dart';
import 'paddle.dart';

void main() {
  runApp(GameWidget(game: BrickBreakerGame()));
}

class BrickBreakerGame extends FlameGame {
  late Ball _ball;
  late Paddle _paddle;

  @override
  Future<void> onLoad() async {
    _ball = Ball();
    _paddle = Paddle();
    add(_ball);
    add(_paddle);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
