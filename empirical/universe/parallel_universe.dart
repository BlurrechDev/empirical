part of empirical_universe;

const DEMONIC = 1;
const PARASITIC = 2;
const ANNOYING = 3;

const width = 100, height = 100;
const dimensions = width * height;
class Universe {
  var created = false;
  var random = new Random();
  
  final dimension = new List<int>(dimensions);
  
  var infection = DEMONIC;
  var mutation = ANNOYING;
  var tainted = ANNOYING;
  
  var tileWidth, tileHeight;
  
  Universe() {
    resize();
  }
  
  int parseSeverity(String input) {
    if (input == 'demonic') {
      return DEMONIC;
    } else if (input == 'parasitic') {
      return PARASITIC;
    } else if (input == 'annoying') {
      return ANNOYING;
    }
  }
  
  generateUniverse({infectionRate, mutationRate}) {
    if (infectionRate != null) {
      infection = parseSeverity(infectionRate.toLowerCase());
    }
    if (mutationRate != null) {
      mutation = parseSeverity(mutationRate.toLowerCase());
    }
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (dimension[(y * width) + x] != 5 && dimension[(y * width) + x] != 6) {
          dimension[(y * width) + x] = random.nextInt(5); ///Only colorspam tiles that aren't diseased.
        }
      }
    }
    explodeCompactions();
    created = true;
  }
  
  click(int index) {
    spread(index, 5);
  }
  
  explodeCompactions() {
    for (int x = 0; x < width; x++) {
      if (x == 0 || x == width -1) continue;
      for (int y = 0; y < height; y++) {
        if (y == 0 || y == height - 1) continue;
        
        int index = (y * width) + x;
        
        int above = dimension[index - width]; //((y - 1) * width) + x
        int below = dimension[index + width]; //((y + 1) * width) + x
        int left = dimension[index - 1];
        int right = dimension[index + 1];
        
        /*int diag_right = -1;
        int diag_left = -1;
        int diagz_left = -1;
        int diagz_right = -1;
        if (index - width + 1 > 0) {
          diag_left = dimension[index - width + 1];
        }
        if (index - width - 1 > 0) {
          diagz_left = dimension[index - width - 1];
        }
        if (index + width + 1 < dimensions) {
          diagz_right = dimension[index + width + 1];
        }
        if (index + width - 1 < dimensions) {
          diag_right = dimension[index + width - 1];
        }*/
        
        int current = dimension[index];
        
        mutate(index, current, above, below, right, left);
        if (current != 6) {
          infect(index, 5, above, below, right, left);
        } else {
        }
        if (current == 5) {
          //infect(index, 6, diag_left, diag_right, diagz_right, diagz_left);
        }
        taint(index, current, above, below, right, left);
      }
    }
  }
  
  mutate(index, current, above, below, right, left) {
    switch(mutation) {
      case DEMONIC:
        if (equivalent(current, [above, below]) || equivalent(current, [above, left])
            || equivalent(current, [left, right]) || equivalent(current, [right, below])) {
          ///print('Mutation');
          spread(index, 5);
        }
        break;
      case PARASITIC:
        if (equivalent(current, [right, left]) || equivalent(current, [above, below])) {
          ///print('Mutation');
          spread(index, 5);
        }
        break;
      case ANNOYING:
        if (equivalent(current, [above, below, right, left])) {
          ///print('Mutation');
          spread(index, 5);
        }
        break;
    }
  }
  
  infect(index, id, above, below, right, left) {
    switch(infection) {
      case DEMONIC:
        if (equivalent(id, [above, below]) || equivalent(id, [above, left])
            || equivalent(id, [left, right]) || equivalent(id, [left, below]) 
            || equivalent(id, [right, above]) || equivalent(id, [right, below])) {
          ///print('Infection');
          spread(index, id);
        }
        break;
      case PARASITIC:
        if (equivalent(id, [above, below]) || equivalent(id, [above, left])
            || equivalent(id, [left, right]) || equivalent(id, [right, below])) {
          ///print('Infection');
          spread(index, id);
        }
        break;
      case ANNOYING:
        if (equivalent(id, [above, below]) || equivalent(id, [left, right])) {
          ///print('Infection');
          spread(index, id);
        }
        break;
    }
  }
  
  spread(int index, int id) {
    dimension[index] = id;
  }
  
  taint(index, current, above, below, right, left) {
    switch(tainted) {
      case DEMONIC:
      case PARASITIC:
      case ANNOYING:
        if (equivalent(5, [current, left, right, above, below])) {
          ///print('Tainted');
          spread(index, 6);
        }
        break;
    }
  }
  
  /**
   * Only returns true if the target number [target]
   * is == to every number in the comparison list
   * [comparison], otherwise returns false.
   */
  bool equivalent(int target, List<int> comparison) {
    for (int base in comparison) {
      if (base != target) return false;
    }
    return true;
  }
  
  destroyUniverse() {
    created = false;
    for (var x = 0; x < dimension.length; x++) {
      dimension[x] = 0;
    }
  }
  
  resize() {
    tileWidth = canvas.width / width;
    tileHeight = canvas.height / height;
  }
  
  draw() {
    if (created) {
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          int tileId = dimension[(y * height) + x];
          if (x == 0 || x == width - 1 || y == 0 || y == height - 1) {
            context.fillStyle = 'black';
          } else {
            setRandomColor(tileId);
          }
          context.fillRect(x * tileWidth, y * tileHeight, tileWidth, tileHeight);
        }
      }
    }
  }
  
  setRandomColor(tileId) {
    switch(tileId) {
      case 5:
        //context.fillStyle = 'pink';
        context.fillStyle = '#00CC33';
        break;
      case 6:
        //context.fillStyle = 'purple';
        context.fillStyle = '#99FF00';
        break;
      default:
        //context.fillStyle = 'white';
        //context.fillStyle = '#E8E8E8';
        context.fillStyle = 'black';
        break;
    }
  }
}