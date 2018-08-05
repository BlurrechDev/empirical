part of lunaris;

class DroneSpawner extends Entity {
  num startX, startY;

  DroneSpawner(num zX, num zY) : super('spawner.gif') {
    x = zX;
    y = zY;
    startX = x;
    startY = y;
  }
  
  draw() {
    if (SPAWNERS_VISIBLE) super.draw();
  }
  
  Drone spawnHere(List<Drone> drones) {
    return spawn(drones, x, y);
  }
  
  Drone spawn(List<Drone> drones, num zX, num zY) {
    drones.add(getDroneToSpawn()
        ..x = zX
        ..y = zY);
    return drones.last;
  }
  
  Drone getDroneToSpawn() {
    return new Drone();
  }

}