library entity;

import 'dart:html' show ImageElement;
import '../../empirical.dart';

part 'living_entity.dart';
part 'living.dart';
part 'moving.dart';
part 'drawable.dart';

const int DEFAULT_WIDTH = 20;
const int DEFAULT_HEIGHT = 20;

class Entity implements Drawable {
  ImageElement sprite;
  num x = 10, y = 10;
  num width = DEFAULT_WIDTH, height = DEFAULT_HEIGHT;
  bool dead = false;
  
  Entity(String spriteSrc) : sprite = new ImageElement(src: 'sprite\\${spriteSrc}');
  
  stretch(num scaleWidth, num scaleHeight) {
    x *= scaleWidth;
    y *= scaleHeight;
    width *= scaleWidth;
    height *= scaleHeight;
  }
  
  shrink(num prevWidth, num prevHeight) {
    x /= prevWidth;
    y /= prevHeight;
    width /= prevWidth;
    height /= prevHeight;
  }
  
  resize(num prevWidth, num prevHeight, num scaleWidth, num scaleHeight) {
    shrink(prevWidth, prevHeight);
    stretch(scaleWidth, scaleHeight);
  }
  
  moveX(num distance, {bool canExitBounds: false}) {
    x += distance;
    if (!canExitBounds && xOutOfBounds()) x -= distance;
  }
  
  moveY(num distance, {bool canExitBounds: false}) {
    y += distance;
    if (!canExitBounds && yOutOfBounds()) y -= distance;
  }
  
  bool outOfBounds() => xOutOfBounds() || yOutOfBounds();
  bool xOutOfBounds() => x < 0 || x > canvas.width;
  bool yOutOfBounds() => y < 0 || y > canvas.height;
  
  bool inProximity(Entity target, num radius) => (!identical(this, target) && (target.x - x).abs() < radius && (target.y - y).abs() < radius);
  
  Entity closestTarget(List<Entity> entities) {
    if (entities.length <= 0) return null;
    Entity currentClosest = entities.first;
    num totalDistance = totalDistanceTo(entities.first);
    for (Entity entity in entities.skip(1)) {
      if (identical(this, entity)) continue;
      final num entityDistance = totalDistanceTo(entity);
      if (entityDistance < totalDistance) {
        totalDistance = entityDistance;
        currentClosest = entity;
      }
    }
    return currentClosest;
  }
  
  num totalDistanceTo(Entity entity) => (entity.x - x).abs() + (entity.y - y).abs();
  
  void draw() {
    context.drawImageScaled(sprite, x, y, width, height);
  }

}