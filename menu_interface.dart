part of empirical;

const MAIN = const MainMenu('''<h1>Placeholder Game</h1>
    <a id="startbutton">Start</a>
    <a id="optionsbutton">Options</a>
    <a id="exitbutton">Exit</a>''');
const PAUSE = const PauseMenu('''<h1>Paused</h1>
    <a id="pausebutton">Resume</a>
    <a id="optionsbutton">Options</a>
    <a id="exitbutton">Exit</a>''');
const CANVAS_OPTIONS = '''
    <form>
    <p id="label"> Mobile Canvas: </p> <input type="checkbox" name="mobiletoggle" id="mobiletoggle" value="On">
    <p id="label"> Fullscreen Canvas: </p> <input type="checkbox" name="fullscreentoggle" id="fullscreentoggle" value="On">
    </form>
''';
const OPTIONS = const OptionsMenu('''<h1>Options</h1>
    ${CANVAS_OPTIONS}
    <a id="exitbutton">Back</a>''');
const GAME = const GameMenu();

final ALL_MENUS = [MAIN, PAUSE, OPTIONS, GAME];

Menu currentMenu = MAIN;

class Menu {
  final String id; ///Element id
  final String content;
  
  const Menu(this.id, this.content);
  
  create() => document.body.appendHtml('<div id="$id" class="$INTERFACE_CLASS"> $content </div>');
  hide() => querySelector('#${id}').style.display = 'none';
  show() => querySelector('#${id}').style.display = 'block';
}

class MainMenu extends Menu {
  const MainMenu(String content) : super('mainmenu', content);
}

class PauseMenu extends Menu { 
  const PauseMenu(String content) : super('pausemenu', content);
}

class OptionsMenu extends Menu { 
  const OptionsMenu(String content) : super('optionsmenu', content);
}

class GameMenu extends Menu {
  const GameMenu() : super('gamemenu', '');
  create() { }
  hide() { } ///The game menu should never change state to appear,
  show() { } ///so it is prevented from changing by overriding these methods.
}

hideAllMenus() {
  for (var menu in ALL_MENUS) menu.hide();
}

createAllMenus() {
  for (var menu in ALL_MENUS) menu.create();
}

Menu getMenu(Menu menu) {
  if (menu is MainMenu) {
    return ALL_MENUS.firstWhere((element) => element is MainMenu);
  } else if (menu is PauseMenu) {
    return ALL_MENUS.firstWhere((element) => element is PauseMenu);
  } else if (menu is OptionsMenu) {
    return ALL_MENUS.firstWhere((element) => element is OptionsMenu);
  } else if (menu is GameMenu) {
    return ALL_MENUS.firstWhere((element) => element is GameMenu);
  } else {
    return null;
  }
}

loadMenu(Menu newMenu) {
  Menu oldMenu = getMenu(newMenu);
  if (oldMenu != null) ALL_MENUS.remove(oldMenu);
  ALL_MENUS.add(newMenu);
}

showMenu(Menu newMenu) {
  currentMenu.hide();
  currentMenu = newMenu;
  currentMenu.show();
}