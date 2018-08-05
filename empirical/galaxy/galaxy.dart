library empirical_galaxy;

import 'dart:math';
import '../../empirical.dart';

part 'dust_galaxy.dart';

main() {
  new EmpiricalGalaxy();
}

class EmpiricalGalaxy extends Empirical {
  final galaxy = new Galaxy();
  
  start() {
    galaxy.createGalaxy();
  }
  
  end() {
    galaxy.created = false;
  }
  
  pause() {
    
  }
  
  resize() {
    galaxy.resize();
  }
  
  draw() {
    if(galaxy.created) galaxy.draw();
  }
  
  tick() {
    
  }
  
  click(num x, num y) {
    
  }
  
}