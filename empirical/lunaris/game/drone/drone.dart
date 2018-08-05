part of lunaris;

class Drone extends LivingEntity {
  bool shieldCharged = false;
  String healthColor = 'green';
  int damage = 1;

  Drone.player() : super('player.gif');

  Drone({String sprite: 'round_drone.gif'}) : super(sprite) {
    randomCoordinates();
  }
  
  num get radius => width * 1.5;
  
  bool canAttack(LivingEntity entity) => true;
  
  tick(List<Drone> drones) {
    move();
    shieldAttack(drones);
  }
  
  shieldAttack(List<Drone> drones) {
    if (!shieldCharged) return;
    for (Drone targetDrone in drones.toList()) {
      if (!canAttack(targetDrone)) continue;
      if (this is PlayerDrone && targetDrone is PlayerDrone) continue;
      if (inProximity(targetDrone, radius)) targetDrone.hurt(damage, this);
    }
  }
  
  @override
  death({LivingEntity murderr}) {
    super.death(murderr: murderr);
    if (murderer is Drone) (murderer as Drone).engorge(this, murderer);
  }
  
  randomCoordinates() {
    x = random.nextInt(canvas.width.toInt());
    y = random.nextInt(canvas.height.toInt());
  }
  
  engorge(LivingEntity defeated, Drone murderer) {
    vitalize(20);
    healBy(20);
    if (murderer.width > 60) return;
    murderer.width += defeated.width / 15;
    murderer.height += defeated.height / 15;
    murderer.speed += defeated.speed / 7;
  }
  
  draw() {
    super.draw();
    if (DRAW_HEALTH_BARS) drawHealthBar();
    if (DRAW_SHIELDS) drawShield();
  }
  
  drawHealthBar() {
    context.fillStyle = 'red';
    context.fillRect(x, (y - 20), width, HEALTH_BAR_HEIGHT);
    context.fillStyle = healthColor;
    context.fillRect(x, (y - 20), (health/maxHealth) * width, HEALTH_BAR_HEIGHT);
  }
  
  drawShield() {
    if (shieldCharged) {
      context.strokeStyle = 'white';
      context.beginPath();
      context.arc(x + width / 2, y + height / 2, radius, 0, 2 * pi);
      context.stroke();
    }
  }
  
  move() {
    switch(random.nextInt(5)) {
      case 0:
        moveY(-speed);
        break;
      case 1:
        moveX(-speed);
        break;
      case 2:
        moveY(speed);
        break;
      case 3:
        moveX(speed);
        break;
      case 4:
        shieldCharge();
        break;
    }
  }
  
  shieldCharge() {
    if (random.nextInt(100) == 0) shieldCharged = !shieldCharged;
  }
}
