import 'package:flame/components.dart';

class Brick extends SpriteComponent {
  Brick(Vector2 position) : super(size: Vector2(50, 20), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('brick.png');
  }
}
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'ball.dart';
import 'paddle.dart';
import 'brick.dart';

void main() {
  runApp(GameWidget(game: BrickBreakerGame()));
}

class BrickBreakerGame extends FlameGame {
  late Ball _ball;
  late Paddle _paddle;
  final List<Brick> _bricks = [];

  @override
  Future<void> onLoad() async {
    _ball = Ball();
    _paddle = Paddle();
    add(_ball);
    add(_paddle);

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        Brick brick = Brick(Vector2(60 + i * 60, 100 + j * 30));
        _bricks.add(brick);
        add(brick);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 충돌 처리 로직 추가
  }
}
