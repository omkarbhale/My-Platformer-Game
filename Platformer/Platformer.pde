//global variables here
int mode = 0;

// 0 Main menu
// 1 Settings
// 2 Levels
// 3 In-Game

// images
PImage mainMenu; // mainmenu
PImage gameBackground;
PImage test;
PImage[] tiles;

// objects
Platform platform;
Player player;


//
boolean forward, backward, upward, downward;
int directionHorizontal, directionVertical;

void setup() {
  //fullScreen();
  //frameRate(10);
  size(1080, 720);
  
  // loading mainmenu
  mainMenu = loadImage("assets/images/mainMenu.jpg");
  mainMenu.resize(0, height);
  
  // loading game background
  gameBackground = loadImage("assets/images/tileset/BG/BG.png");
  gameBackground.resize(width, height);
  
  // loading all tiles in "tiles"
  tiles = new PImage[18];
  for(int i = 0; i < tiles.length; i++) {
    tiles[i] = loadImage("assets/images/tileset/Tiles/" + (i+1) + ".png");
    tiles[i].resize(height/10, height/10);
  }  
  
}

void draw() {
  switch(mode){
    case (0):
      drawMainMenu();
      break;
    case 1:
      drawSettingsMenu();
      break;
    case 2:
      drawLevels();
      break;
    case 3:
      drawGameLoop();
      break;
    
  }
}

void drawMainMenu() {
  background(72, 78, 112);
  textSize(height/9);
  
  // mainMenu image
  image(mainMenu, (width - mainMenu.width) / 2, 0);
  
  
  text("Play", (width - mainMenu.width) / 2 + mainMenu.width*0.38 , 0.188 * height);
  text("Settings", (width - mainMenu.width) / 2 + mainMenu.width*0.3, 0.5 * height);
  text("Quit", (width - mainMenu.width) / 2 + mainMenu.width*0.38, 0.8 * height);
  
  // check clicks on main menu
  if(mousePressed) {
    // check vertical
    if(mouseX > (width - mainMenu.width) / 2 + mainMenu.width*0.203 && mouseX < (width - mainMenu.width) / 2 + mainMenu.width*0.8){
     line(mouseX, 0, mouseX, height); 
     
     // check play
     if(mouseY > height*0.074 && mouseY < height*0.275) {
      line(0, mouseY, width, mouseY);
      mode = 2; // iitialising levels
     }
     
     // check settings
     if(mouseY > height*0.36 && mouseY < height*0.6) {
       line(0, mouseY, width, mouseY);
       mode = 1; // initialising settings
     }
     
     
     // check quit
     if(mouseY > height*0.67 && mouseY < height*0.9) {
       line(0, mouseY, width, mouseY);
       exit();
     }
    }
    
    
  }
}

void drawSettingsMenu() {
  background(72, 78, 112);
  
  rect(50, 50, 200, 200);
  
  textSize(height/9);
  text("Some settings here", 0, height/2);
  
  if(mousePressed) {
    // check back button
    if(mouseX > 50 && mouseX < 250 && mouseY > 50 && mouseY < 250) {
      line(mouseX, 0, mouseX, height);
      line(0, mouseY, width, mouseY);
      mode = 0; // back to main menu
    }
  }
}






void drawLevels() {

  // first level selected as default
  // so mode = 3;
  mode = 3;
  
  
  // initialise platform according to level selected
  platform = new Platform("assets/levels/1.txt");
  player = new Player(new PVector(height/8, height/8));
}


void drawGameLoop() {
  image(gameBackground, 0, 0);
  
  
  
  //player.applyGravity(platform.tileData); // here we initialise platform data
  //player.moveHorizontal(directionHorizontal); // here we use that data
  //player.jump(directionVertical); // here too:)
  
  player.update(platform.tileData, directionVertical, directionHorizontal);
  
  platform.show();
  player.show();
  
}


// up 38 down 40 left 37 right 39
void keyPressed() {
  if(keyCode == 37) { // left
    if(player.isAnimatingLeft == false) {
      player.currentImageLeft = 1;
      player.isAnimatingLeft = true;
    }
    backward = true;
    directionHorizontal = -1;
  } else if(keyCode == 39) { // right
    if(player.isAnimatingRight == false) {
      player.currentImageRight = 1;
      player.isAnimatingRight = true;
    }
    forward = true;
    directionHorizontal = 1;
  }
  
  if(keyCode == 38) { // up
    upward = true;
    directionVertical = 1;
  }
}
void keyReleased() { 
  if(keyCode == 37) { // left
    player.currentImageLeft = 0;
    player.isAnimatingLeft = false;
    backward = false;
    if(forward == true) {
      directionHorizontal = 1;
    } else {
      directionHorizontal = 0;
    }
  } else if(keyCode == 39) { // right
    
    player.currentImageRight = 0;
    player.isAnimatingRight = false;
    forward = false;
    if(backward == true) {
      directionHorizontal = -1;
    } else {
      directionHorizontal= 0;
    }
  }
  
  
  if(keyCode == 38) { // up
    upward = false;
    if(downward == true) {
      directionVertical = -1;
    } else {
      directionVertical = 0;
    }
  }
  
}
