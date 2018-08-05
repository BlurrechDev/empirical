part of lunaris;

class TargetTribal extends SuperTribal {
  
  TargetTribal(int banner) : super(banner, 'cleaver_drone.gif');
  
  attack(List<Drone> drones) {
    super.attack(drones);
    if (shieldCharged) {
      moveTowards(closestTarget(drones.where((Drone drone) {
        return drone is! TribeDrone || drone is TribeDrone && canAttack(drone);
      }).toList()));
    } else {
      super.move();
    }
  }
  
  move() { }
  
  moveTowards(LivingEntity target) {
    if (target == null) return;
    if (inProximity(target, radius - 3)) {
      super.move();
    } else {
      num distToX = (target.x - x).abs();
      num distToY = (target.y - y).abs();
    
      if (distToX > distToY) {
        if (target.x < x) {
          moveX(-speed);
        } else {
          moveX(speed);
        }
      } else {
        if (target.y < y) {
          moveY(-speed);
        } else {
          moveY(speed);
        }
      }
    }
  }
  
}
