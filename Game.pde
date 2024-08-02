ArrayList<Button> buttons = new ArrayList<Button>();
Button play, restart, menu, next;
int level;
boolean shifted = false;
boolean spaceHeld = false;
int FINAL_LEVEL = 9;

enum Mode {
  MENU,
    LEVELS,
    PLAY,BUILD,PAUSE,WIN,
    BEAT_GAME
}
Mode mode;

void setup() {
  size(1600, 900);
  //textSize(64);
  //world = lvlInit2();
  mode = Mode.MENU;
  
  play = new Button(1200,700,200,60);
  play.text = "Play";
  
  restart = new Button(600,800,50,50);restart.text = "restart"; 
  menu = new Button(700,800,50,50); menu.text = "menu";
  next = new Button(800,800,50,50);next.text = "next";
  
  
  for (int i = 1; i<=20; i++) {
    Button but = new Button( ((i-1)*width /5) % width, ((i-1)/5)*height /4, 50, 50);// the grid stuff yayay
    but.i =i;
    but.text = ""+i;
    buttons.add(but);
  }
}

void draw() {
  switch (mode) {
  case MENU :
    drawMenu();
    break;
  case LEVELS :
    drawLevels();
    break;
  case PAUSE:
    rectMode(CENTER);
    setColour(ballRed);
    stroke(0);
    strokeWeight(1);
    rect(400,400,500, 400);
  case PLAY :
  case WIN : 
  case BUILD:
    drawlvl(world);
    if (mode == Mode.BUILD) drawSelector(world);
    break;
  case BEAT_GAME: drawBeatGame(); break;
  }
}

void mousePressed() {
  switch (mode) {
  case PLAY:
    break;
  case PAUSE:
    break;
  case WIN:
    break;
  case BUILD:
    if (!shifted) {
      float mX = mouseX;
      float flippedY = toY(mouseY);
      if (canPlacePeg(mX, flippedY)) {
        addUserPeg(world, mX, flippedY);
      }
    } else {
      removeNearestPeg(world,mouseX,toY(mouseY));
    }
    break;
  case LEVELS:
    for (Button but : buttons) {
      if (but.mouseOver()) {
        load(but.i);
      }
    }
    break;
  case MENU:
    if (play.mouseOver()){mode = Mode.LEVELS;}
    break;

  default: break;
  }
}

void keyPressed(){
  switch (mode){
    case PLAY:
      if (key == 'b'){mode = Mode.LEVELS;}
      if (!spaceHeld && key == ' '){
        mode = Mode.BUILD;
        spaceHeld = true;
      }
      break;
    case BUILD:
      if (key == 'b'){mode = Mode.LEVELS;}
      if (!spaceHeld && key == ' '){
        mode = Mode.PLAY;
        spaceHeld = true;
      }
      if (keyCode == SHIFT) {
        shifted = true;
      }
      if (keyCode == BACKSPACE) {
        mode = Mode.LEVELS;
      }
      break;
    case MENU:
      break;
    case LEVELS:
      if (key == 'b'){mode = Mode.MENU;}
      break;
    case PAUSE:
      break;
    case WIN:
      if (keyCode == ENTER || keyCode == RETURN) {
        if (level + 1 <= FINAL_LEVEL) {
          load(level + 1);
        } else {
          mode = Mode.BEAT_GAME;
        }
      } else if (keyCode == BACKSPACE) {
        mode = Mode.LEVELS;
      }
      break;
    default: break;
  }
}

void keyReleased() {
  switch (mode){
    case BUILD:
    if (keyCode == SHIFT) {
      shifted = false;
    }
    case PLAY:
    if (key == ' ') {
      spaceHeld = false;
    }
    default: break;
  }
}

void load(int lvl){
  world = read("level"+lvl);
  t0 = millis();
  mode = Mode.BUILD;
  level = lvl;

  winTicks = 0;
  lastTime = 0;
}

void drawLevels() {
  background(lime.r, lime.g, lime.b);
  for (Button but : buttons) but.show();
}

void drawMenu() {
  background(lime);
  textSize(60);
  setColour(pegBlue);
  text("omg its a game", 100,100);
  play.show();
}
