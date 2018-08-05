library cellula;

import 'dart:math' show Random, PI;
import '../../empirical.dart';

import '../entity/entity.dart';

part 'host.dart';
part 'cell.dart';

void main() {
  new Cellula();
}

const CUSTOM_MAIN = const MainMenu('''
<h1> Cellula </h1>
<a id="startbutton"> Start </a>
<a id="optionsbutton"> Options </a>
<a id="exitbutton"> Exit </a>
''');

const UP = 38;
const LEFT = 37;
const DOWN = 40;
const RIGHT = 39;
const SPACE = 32;

const W = 87;
const A = 65;
const S = 83;
const D = 68;

final Random random = new Random();

class Cellula extends Empirical {
  final host = new Host();
  
  @override
  loadInterface() {
    loadMenu(CUSTOM_MAIN);
    super.loadInterface();
  }
  
  @override
  start() {
    host.start();
  }
  
  @override
  pause() {
    
  }
  
  @override
  end() {
    host.end();
  }
  
  @override
  tick() {
    host.keyInput(keys);
    host.tick();
  }
  
  @override
  draw() {
    host.draw();
  }
  
  @override
  resize() {
    host.resize();
  }
  
  @override
  click(num x, num y) {
    
  }
  
}
