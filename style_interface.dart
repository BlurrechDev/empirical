part of empirical;

const STYLE_ID = 'gamestyle';
const CANVAS_ID = 'gamecanvas';
const TITLE_ID = 'gametitle';
const INTERFACE_CLASS = 'popup';

const MOBILE_WIDTH = 440; //480
const MOBILE_HEIGHT = 660; //800

const NORMAL_WIDTH = 680;
const NORMAL_HEIGHT = 480;

bool FULLSCREEN_MODE = false;
bool MOBILE_MODE = false;

final style = new StyleElement();
final canvas = new CanvasElement();
final title = new HeadingElement.h1();
final CanvasRenderingContext2D context = canvas.getContext('2d');

num dynX(num percentage) => percentage * canvas.width; 
num dynY(num percentage) => percentage * canvas.height; 

int popupWidth = 420; //int popupWidth = (canvas.width * 0.70).toInt(); //60% of the canvas width

styleInterface() {
  canvas.id = CANVAS_ID;
  style.id = STYLE_ID;
  title
  ..id = TITLE_ID
  ..text = 'Empirical';
  document.body.children.addAll([style, title, canvas]);
  resizeCanvas();
  style.appendText('''
body {
  ${bodyStyle()}
}
form {
  padding: 10px;
}
input, select {
  margin: 3px -240px 3px 4px;
}
select {
  width: 100px;
}
#label {
  margin-left: -40%;
  margin-bottom: -25px;
}
.$INTERFACE_CLASS {
  ${interfaceStyle()}
}
.$INTERFACE_CLASS h1 {
  ${interfaceH1Style()}
}
.$INTERFACE_CLASS a {
  ${interfaceLinkStyle()}
}
.$INTERFACE_CLASS a:hover {
  ${interfaceLinkHoverStyle()}
}
#$CANVAS_ID {
  ${canvasStyle()}
}
#$TITLE_ID {
  ${titleStyle()}
}
''');
}

String bodyStyle() {
  return '''
  font-family: 'Open Sans', sans-serif;
  line-height: 1.2em;
  margin: 0px;
  overflow: hidden;
  -moz-user-select: none;
  -webkit-user-select: none;
  -user-select: none;
''';
}

String titleStyle() {
  return '''
  text-align: center;
  font-family: Impact;
  letter-spacing: 2px;
  font-size: 36px;
''';
}

String canvasStyle() {
  return '''
  padding-left: 0;
  padding-right: 0;
  margin-left: auto;
  margin-right: auto;
  display: block;
''';
}

String interfaceStyle() {
  return '''
  top: 75px; 
  display: none;
  position: absolute;
  text-align: center;
  color: white;
  border: 7px solid rgb(221,212,193);
  margin: 40px;
  background-color: rgb(66, 56, 56);
  width: ${popupWidth}px;
  padding-bottom: 20px;
  left: 50%;
  margin-left: -${(popupWidth / 2) + 8}px;
''';
}

String interfaceH1Style() {
  return '''
  font-family: Roboto;
  padding-top: 10px;
''';
}

String interfaceLinkStyle() {
  return '''
  float: left;
  padding: 10px 80px 10px 80px;
  border: grey solid 1px;
  background-color: #E0E0E0;
  margin-top: 20px;
  margin-bottom: 20px;
  width: 10%;
  color: black;
  clear: both;
  margin-left: ${popupWidth * 0.26}px;
''';
}

String interfaceLinkHoverStyle() {
  return '''
  background-color: #D8D8D8;
  color: grey;
  cursor: pointer;
''';
}

toggleCanvasMaximization() {
  FULLSCREEN_MODE = !FULLSCREEN_MODE;
}

toggleCanvasMobile() {
  MOBILE_MODE = !MOBILE_MODE;
}

hideTitleBar() {
  querySelector('#${TITLE_ID}').style.display = 'none';
}

showTitleBar() {
  querySelector('#${TITLE_ID}').style.display = 'block';
}

resizeCanvas() {
  if (FULLSCREEN_MODE) {
    hideTitleBar();
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  } else if (MOBILE_MODE) {
    hideTitleBar();
    canvas.width = MOBILE_WIDTH;
    canvas.height = MOBILE_HEIGHT;
  } else {
    showTitleBar();
    canvas.width = NORMAL_WIDTH;
    canvas.height = NORMAL_HEIGHT;
  }
}