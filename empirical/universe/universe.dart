library empirical_universe;

import 'dart:html';
import 'dart:math';
import '../../empirical.dart';

part 'parallel_universe.dart';

main() {
  new EmpiricalUniverse();
}

const CUSTOM_MAIN = const MainMenu('''<h1>Universe - Dev: 1.3</h1>
    <a id="startbutton">Start</a>
    <a id="optionsbutton">Options</a>
    <a id="exitbutton">Exit</a>''');

const CUSTOM_PAUSE = const PauseMenu('''<h1>Universe Paused</h1>
    <a id="pausebutton">Resume</a>
    <a id="exitbutton">Exit</a>''');

const CUSTOM_OPTIONS = const OptionsMenu('''<h1>Options</h1>
    ${CANVAS_OPTIONS}
    <form>
    <p id="label"> Disease Spread Ticks: </p><select id="ticksdisease" name="ticksdisease">
    <option value="5">5</option>
    <option value="10" selected>10</option>
    <option value="20">20</option>
    <option value="30">30</option>
    </select>

    <p id="label"> Infection Rate: </p><select id="infectionrate" name="infectionrate">
    <option value="annoying" selected>Annoying</option>
    <option value="parasitic">Parasitic</option>
    <option value="demonic">Demonic</option>
    </select>

    <p id="label"> Mutation Rate: </p><select id="mutationrate" name="mutationrate">
    <option value="annoying" selected>Annoying</option>
    <option value="parasitic">Parasitic</option>
    <option value="demonic">Demonic</option>
    </select>
    </form>
    <a id="exitbutton">Back</a>''');

class EmpiricalUniverse extends Empirical {
  final universe = new Universe();
  var ticks = 0;
  var ticksDisease = 20;
  
  loadInterface() {
    loadMenu(CUSTOM_MAIN);
    loadMenu(CUSTOM_PAUSE);
    loadMenu(CUSTOM_OPTIONS);
    super.loadInterface();
  }

  draw() {
    universe.draw();
  }

  start() {
    SelectElement dropDown = querySelector('#ticksdisease');
    ticksDisease = int.parse(dropDown.options[dropDown.selectedIndex].value);
    
    SelectElement infectionDropDown = querySelector('#infectionrate');
    var infection = infectionDropDown.options[infectionDropDown.selectedIndex].value;

    SelectElement mutationDropDown = querySelector('#mutationrate');
    var mutation = mutationDropDown.options[mutationDropDown.selectedIndex].value;
    
    universe.generateUniverse(infectionRate: infection, mutationRate: mutation);
  }
  
  end() {
    universe.destroyUniverse();
    ticks = 0;
  }
  
  pause() {
    
  }
  
  resize() {
    universe.resize();
  }
  
  tick() {
    ticks += 1;
    if (ticks == ticksDisease) {
      universe.generateUniverse();
      ticks = 0;
    }
  }
  
  click(num x, num y) {
    int locX = (x / universe.tileWidth).floor();
    int locY = (y / universe.tileHeight).floor();
    int index = (locY * width) + locX;
    universe.click(index);
  }
  
}