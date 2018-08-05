part of empirical_galaxy;

class Galaxy {
  var created = false;
  var width = 50, height = 50, maxSystems = 10, minSystems = 2;
  var tileWidth, tileHeight;
  var random = new Random();
  List<List<int>> systems;
  
  Galaxy() {
    resize();
    systems = new List<List<int>>();
  }
  
  resize() {
    tileWidth = canvas.width / width;
    tileHeight = canvas.height / height;
  }
  
  createSystem() {
    var targetX = 5 + random.nextInt(width - 11);
    var targetY = 5 + random.nextInt(height - 11);
    List<int> system = new List<int>();
    system.addAll([targetX, targetY]);
    for (int x = 0; x < random.nextInt(10) + 1; x++) {
      var jaggedX = targetX + random.nextInt(6) - random.nextInt(5);
      var jaggedY = targetX + random.nextInt(6) - random.nextInt(5);
      system.addAll([jaggedX, jaggedY]);
    }
    systems.add(system);
  }
  
  createGalaxy() {
    systems.clear();
    for (int x = 0; x < random.nextInt(maxSystems) + minSystems; x++) {
      createSystem();
    }
    created = true;
  }
  
  draw() {
    context.lineWidth = 3;
    context.lineJoin = 'round';
    context.strokeStyle = 'white';
    context.beginPath();
    for (List<int> system in systems) {
      for (int x = 0; x < system.length; x += 2) {
        int locX = system[x];
        int locY = system[x + 1];
        if (x == 0) {
          context.moveTo(locX * tileWidth, locY * tileHeight);
        } else {
          context.lineTo(locX * tileWidth, locY * tileHeight);
        }
      }
      context.stroke();
    }
  }
  
}