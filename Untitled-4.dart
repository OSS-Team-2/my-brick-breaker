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
