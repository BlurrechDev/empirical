part of lunaris;

class TribeSpawner extends DroneSpawner {
  int banner;
  
  TribeSpawner(num x, num y, this.banner) : super(x, y);
  
  Drone getSuperDrone() {
    switch (random.nextInt(4)) {
      case 0:
        return new GravityTribal(banner);
      case 1:
        return new TargetTribal(banner);
      case 2:
        return new VampireTribal(banner);
      case 3:
        return new RegenTribal(banner);
    }
  }
  
  Drone getBasicDrone() {
    switch (random.nextInt(1)) {
      case 0:
        return new TribeDrone(banner);
    }
  }
  
  Drone getDroneToSpawn() {
    if (random.nextInt(30) == 0) {
      return getSuperDrone();
    } else {
      return getBasicDrone();
    }
  }
  
}