part of lunaris;

class PlayerDrone extends Drone with Controllable {
  PlayerDrone() : super.player() {
    damage = 1;
  }
  
  drawHealthBar() { } ///Override to nothing
  
  move() {
    if (random.nextInt(10) == 0) shieldCharge();
  }
  
}
