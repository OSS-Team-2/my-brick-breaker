import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class Ball extends SpriteComponent with HasGameRef {
  Vector2 velocity = Vector2(200, 200);

  Ball() : super(size: Vector2.all(20));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ball.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    position += velocity * dt;

    // 화면 경계에 충돌 처리
    if (position.x <= 0 || position.x + size.x >= gameRef.size.x) {
      velocity.x = -velocity.x;
    }
    if (position.y <= 0 || position.y + size.y >= gameRef.size.y) {
      velocity.y = -velocity.y;
    }
  }
}
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class Paddle extends SpriteComponent with HasGameRef {
  Paddle() : super(size: Vector2(100, 20));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('paddle.png');
    position = Vector2((gameRef.size.x - size.x) / 2, gameRef.size.y - size.y - 10);
  }

  @override
  void update(double dt) {
    // 패들 이동 로직 추가
  }
}
