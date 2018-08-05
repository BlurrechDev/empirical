library empirical;

import 'dart:html';

part 'style_interface.dart';
part 'menu_interface.dart';

abstract class Empirical {
  var started = false, paused = false;
  var keys = new List<bool>.filled(250, false);

  Empirical() {
    loadInterface();
    loadEvents();
    window.requestAnimationFrame(_tick);
  }
  
  loadInterface() {
    styleInterface();
    createAllMenus();
    _resize();
    showMenu(getMenu(MAIN));
  }

  loadEvents() {
    final startButton = querySelector('#startbutton');
    final pauseButtons = querySelectorAll('#pausebutton');
    final optionsButtons = querySelectorAll('#optionsbutton');
    final exitButtons = querySelectorAll('#exitbutton');
    final mobileToggle = querySelector('#mobiletoggle');
    final fullscreenToggle = querySelector('#fullscreentoggle');
    
    if (startButton != null) startButton.onClick.listen((event) => _start());
    if (pauseButtons != null) pauseButtons.forEach((element) => element.onClick.listen((event) => _pause()));
    if (optionsButtons != null) optionsButtons.forEach((element) => element.onClick.listen((event) => showMenu(OPTIONS)));
    if (exitButtons != null) exitButtons.forEach((element) => element.onClick.listen((event) => exitMenu()));
    
    if (mobileToggle != null && fullscreenToggle != null) { 
      mobileToggle.onClick.listen((event) {
          (fullscreenToggle as InputElement).disabled = !(fullscreenToggle as InputElement).disabled;
          toggleCanvasMobile();
          _resize();
      });
      fullscreenToggle.onClick.listen((event) {
        (mobileToggle as InputElement).disabled = !(mobileToggle as InputElement).disabled;
        toggleCanvasMaximization();
        _resize();
      });
    }
    window.onKeyUp.listen((event) {
      if (!started) return;
      keys[event.keyCode] = false;
      _keyInput();
    });
    window.onKeyDown.listen((event) {
      if (!started) return;
      keys[event.keyCode] = true;
      _keyInput();
    });
    canvas.onClick.listen((event) {
      if (!paused && started) {
        var coords = relMouseCoords(event);
        click(coords.x, coords.y);
      }
    });
    window.onResize.listen((event) => _resize());
  }
  
  exitMenu() {
    switch (currentMenu.runtimeType) {
      case MainMenu:
        window.history.back();
        return;
      case PauseMenu:
        _end();
        showMenu(getMenu(MAIN));
        return;
      case OptionsMenu:
      default:
        showMenu(getMenu(MAIN));
        return;
    }
  }
  
  void _keyInput() {
    if (keys[80]) {
      _pause();
    } else if (keys[82] && !paused) {
      restart();
    }
  }

  Point relMouseCoords(MouseEvent event) => new Point(event.page.x - (canvas.offsetLeft - canvas.scrollLeft), event.page.y - (canvas.offsetTop - canvas.scrollTop));

  _tick(num time) {
    if (!paused && started) {
      _draw();
      tick();
    }
    window.requestAnimationFrame(_tick);
  }
  
  _draw() {
    context.fillStyle = 'black';
    context.fillRect(0, 0, canvas.width, canvas.height);
    draw();
  }
  
  _start() {
    showMenu(getMenu(GAME));
    paused = false;
    started = true;
    start();
  }
  
  _end() {
    started = false;
    end();
  }
  
  _pause() {
    paused = !paused;
    if (paused && started) {
      showMenu(getMenu(PAUSE));
    } else {
      showMenu(getMenu(GAME));
    }
    pause();
  }
  
  _resize() {
    resizeCanvas();
    resize();
    _draw(); ///Experiment, requires there to be no logic on the draw function.
  }
  
  restart() {
    end();
    start();
  }
  
  draw() {
    
  }
  start();
  end();
  pause();
  resize();
  tick();
  click(num x, num y);
}