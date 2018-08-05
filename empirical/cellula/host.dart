part of cellula;

class Host {
  bool created = false;
  final List<Cell> cells = new List<Cell>();
  
  start() {
    spawnCells(5);
    created = true;
  }
  
  spawnCells(num quantity) {
    for (int x = 0; x < quantity; x++) cells.add(new Cell());
  }
  
  end() {
    created = true;
  }
  
  draw() {
    for (Cell cell in cells) cell.draw();
  }
  
  resize() {
    
  }
  
  keyInput(keys) {
    
  }
  
  tick() {
    
  }
  
}