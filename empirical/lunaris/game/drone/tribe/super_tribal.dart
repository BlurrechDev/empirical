part of lunaris;

class SuperTribal extends TribeDrone {
  num health = 200;
  num maxHealth = 200;
  
  num get radius => width * 1.8;
  
  SuperTribal(int banner, String sprite) : super(banner, sprite: sprite) {
    width *= 1.4;
    height *= 1.4;
  }
  
  @override
  tick(List<Drone> drones) {
    super.tick(drones);
    attack(drones);
  }
  
  attack(List<Drone> drones) {
    shieldCharge();
  }
  
  @override
  vitalize(num vitality) {
    return; ///Don't allow max health increase.
  }
  
}