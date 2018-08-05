part of lunaris;

class VampireTribal extends SuperTribal {
  
  VampireTribal(int banner) : super(banner, 'vampire_drone.gif');

  @override
  drawShield() {
    context.strokeStyle = 'orange';
    context.beginPath();
    context.arc(x + width / 2, y + height / 2, radius * 1.02, 0, 2 * pi);
    context.stroke();

    context.strokeStyle = 'white';
    context.beginPath();
    context.arc(x + width / 2, y + height / 2, radius, 0, 2 * pi);
    context.stroke();
  }

  @override
  shieldAttack(List<Drone> drones) {
    if (shieldCharged) {
      for (Drone targetDrone in drones.toList()) {
        if (canAttack(targetDrone) && inProximity(targetDrone, radius)) {
          targetDrone.hurt(1, this);
          healBy(1);
//          width *= 1.02;
//          height *= 1.02;
//          speed *= 1.02;
        } else if (health <= 60 && inProximity(targetDrone, radius)) {
          targetDrone.hurt(1, this);
          healBy(1);
//          width *= 1.02;
//          height = 1.02;
//          speed *= 1.02;
        }
      }
    } else {
      hurt(0.1);
      if (width > DEFAULT_WIDTH) {
//        width *= 0.98;
//        height *= 0.98;
//        speed *= 0.98;
      }
    }
  }
  
  @override
  vitalize(num vitality) {
    healBy(vitality / 2);
  }
  
}