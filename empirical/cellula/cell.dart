part of cellula;

class Cell extends LivingEntity {
  
  Cell.transformTo(String spriteSrc) : super(spriteSrc) {
    randomize();
  }
  
  Cell() : super('cell.gif') {
    randomize();
  }
  
  void randomize() {
    x = random.nextInt(canvas.width);
    y = random.nextInt(canvas.height);
  }
  
  move() {
    if (xOutOfBounds()) {
      
    }
    if (yOutOfBounds()) {
      
    }
  }
  
}