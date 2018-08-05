part of lunaris;

class PatrolSpawner extends DroneSpawner {
  static const int TOP = 28;
  static const int RIGHT = 29;
  static const int BOTTOM = 30;
  static const int LEFT = 31;
  static const int CONFUSED = 32;
  int currentPatrolSection = TOP;
  
  num moveFraction = 200;
  num xPatrolDist, yPatrolDist;
  num xPatrol = 0, yPatrol = 0;
  
  PatrolSpawner(num zX, num zY, {this.xPatrolDist, this.yPatrolDist}) : super(zX, zY);
  
  Drone spawnHere(List<Drone> drones) {
    return super.spawnHere(drones);
  }
  
  moveX(num distance, {bool canExitBounds: false}) {
    super.moveX(distance, canExitBounds: canExitBounds);
    currentPatrolSection = CONFUSED;
  }
  
  moveY(num distance, {bool canExitBounds: false}) {
    super.moveY(distance, canExitBounds: canExitBounds);
    currentPatrolSection = CONFUSED;
  }
  
  move() {
    num xPatrolFract = xPatrolDist / moveFraction;
    num yPatrolFract = yPatrolDist / moveFraction;
    
    switch (currentPatrolSection) {
      case TOP:
        if (xPatrol < xPatrolDist) {
          x += xPatrolFract;
          xPatrol += xPatrolFract;
        } else {
          currentPatrolSection = RIGHT;
          xPatrol = 0;
        }
        break;
      case RIGHT:
        if (yPatrol < yPatrolDist) {
          y += yPatrolFract;
          yPatrol += yPatrolFract;
        } else {
          currentPatrolSection = BOTTOM;
          yPatrol = 0;
        }
        break;
      case BOTTOM:
        if (xPatrol < xPatrolDist) {
          x -= xPatrolFract;
          xPatrol += xPatrolFract;
        } else {
          currentPatrolSection = LEFT;
          xPatrol = 0;
        }
        break;
      case LEFT:
        if (yPatrol < yPatrolDist) {
          y -= yPatrolFract;
          yPatrol += yPatrolFract;
        } else {
          currentPatrolSection = TOP;
          yPatrol = 0;
        }
        break;
      case CONFUSED:
        moveToStart();
        if ((x - startX).abs() < 3 && (y - startY).abs() < 3) {
          currentPatrolSection = TOP;
          xPatrol = 0;
          yPatrol = 0;
        }
        break;
    }
  }
  
  moveToStart() {
    num distToX = (startX - x).abs();
    num distToY = (startY - y).abs();
    
    if (distToX > distToY) {
      num speed = xPatrolDist / moveFraction; //x speed
      if (startX < x) {
        moveX(-speed);
      } else {
        moveX(speed);
      }
    } else {
      num speed = yPatrolDist / moveFraction; //y speed
      if (startY < y) {
        moveY(-speed);
      } else {
        moveY(speed);
      }
    }
  }
  
}