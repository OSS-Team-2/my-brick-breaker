flutter create brick_breaker
cd brick_breaker
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.0.0
flutter pub get
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: BrickBreakerGame()));
}

class BrickBreakerGame extends Game {
  // 게임 초기화 및 루프 관리
  @override
  void render(Canvas canvas) {
    // 화면 그리기
  }

  @override
  void update(double t) {
    // 게임 상태 업데이트
  }
}
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
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class Ball extends SpriteComponent with HasGameRef, Hitbox, Collidable {
  Vector2 velocity = Vector2(200, 200);

  Ball() : super(size: Vector2.all(20));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ball.png');
    position = gameRef.size / 2;
    addHitbox(HitboxRectangle());
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Paddle || other is Brick) {
      velocity.y = -velocity.y;
      if (other is Brick) {
        other.removeFromParent();
      }
    }
  }
}
flutter run
