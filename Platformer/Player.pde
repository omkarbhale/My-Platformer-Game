class Player {
  PVector pos, vel, size;
  
  int movementSpeed = 10, gravityStrength = 3, jumpStrength = 45;
  
  boolean isMidAir = true;
  int[] distance;
  
  int prevDir, movingDirection; // takes values: -1, 0, 1;
  int currentImageRight = 0, currentImageLeft = 0;
  boolean isAnimatingRight = false, isAnimatingLeft = false;
  PImage[] playerImage = new PImage[8];
  PImage[] playerRevImage = new PImage[8];
  
  
  // camera movement global variables
 
  Player(PVector _pos) {
    pos = _pos;
    vel = new PVector(0, 0);
    
    playerImage[0] = loadImage("assets/images/player/1.png");
    playerImage[1] = loadImage("assets/images/player/2.png");
    playerImage[2] = loadImage("assets/images/player/3.png");
    playerImage[3] = loadImage("assets/images/player/4.png");
    playerImage[4] = loadImage("assets/images/player/5.png");
    playerImage[5] = loadImage("assets/images/player/6.png");
    playerImage[6] = loadImage("assets/images/player/7.png");
    playerImage[7] = loadImage("assets/images/player/8.png");
    
    playerRevImage[0] = loadImage("assets/images/player/Rev1.png");
    playerRevImage[1] = loadImage("assets/images/player/Rev2.png");
    playerRevImage[2] = loadImage("assets/images/player/Rev3.png");
    playerRevImage[3] = loadImage("assets/images/player/Rev4.png");
    playerRevImage[4] = loadImage("assets/images/player/Rev5.png");
    playerRevImage[5] = loadImage("assets/images/player/Rev6.png");
    playerRevImage[6] = loadImage("assets/images/player/Rev6.png");
    playerRevImage[7] = loadImage("assets/images/player/Rev6.png");
    // pass these images inn. maybe later. because it slows it up.
    
    playerImage[0].resize(height/17, (int)(0.8 * height/10));
    playerImage[1].resize(height/17, (int)(0.8 * height/10));
    playerImage[2].resize(height/17, (int)(0.8 * height/10));
    playerImage[3].resize(height/17, (int)(0.8 * height/10));
    playerImage[4].resize(height/17, (int)(0.8 * height/10));
    playerImage[5].resize(height/17, (int)(0.8 * height/10));

    playerRevImage[0].resize(height/17, (int)(0.8 * height/10));
    playerRevImage[1].resize(height/17, (int)(0.8 * height/10));
    playerRevImage[2].resize(height/17, (int)(0.8 * height/10));
    playerRevImage[3].resize(height/17, (int)(0.8 * height/10));
    playerRevImage[4].resize(height/17, (int)(0.8 * height/10));
    playerRevImage[5].resize(height/17, (int)(0.8 * height/10));
    
    size = new PVector(playerImage[0].width, playerImage[0].height);
    
    
    //0 distance from bottom block
    //1 distance from top block
    //2 distance from left block
    //3 distance from right block
    distance = new int[4];
  }
  
  void show() {
    pushMatrix();
    translate(-(pos.x - 5*height/10), 0);
   
   //rect(pos.x, pos.y, size.x, size.y); 
   if(movingDirection == 1) {
     prevDir = 1;
     switch(currentImageRight) {
    case 0:
      image(playerImage[2], pos.x, pos.y);
      break;
    case 1:
      image(playerImage[0], pos.x, pos.y);
      currentImageRight = 2;
      break;
    case 2:
      image(playerImage[1], pos.x, pos.y);
      currentImageRight = 3;
      break;
    case 3:
      image(playerImage[2], pos.x, pos.y);
      currentImageRight = 4;
      break;
    case 4:
      image(playerImage[3], pos.x, pos.y);
      currentImageRight = 5;
      break;
    case 5:
      image(playerImage[4], pos.x, pos.y);
      currentImageRight = 6;
      break;
    case 6:
      image(playerImage[5], pos.x, pos.y);
      currentImageRight = 7;
      break;
    case 7:
      image(playerImage[5], pos.x, pos.y);
      currentImageRight = 8;
      break;
    case 8:
      image(playerImage[5], pos.x, pos.y);
      currentImageRight = 1;
      break;
   } 
   }else if(movingDirection == -1) {
     prevDir = -1;
     switch(currentImageLeft) {
      case 0:
        image(playerRevImage[2], pos.x, pos.y);
        break;
      case 1:
        image(playerRevImage[0], pos.x, pos.y);
        currentImageLeft = 2;
        break;
      case 2:
        image(playerRevImage[1], pos.x, pos.y);
        currentImageLeft = 3;
        break;
      case 3:
        image(playerRevImage[2], pos.x, pos.y);
        currentImageLeft = 4;
        break;
      case 4:
        image(playerRevImage[3], pos.x, pos.y);
        currentImageLeft = 5;
        break;
      case 5:
        image(playerRevImage[4], pos.x, pos.y);
        currentImageLeft = 6;
        break;
      case 6:
        image(playerRevImage[5], pos.x, pos.y);
        currentImageLeft = 7;
        break;
      case 7:
        image(playerRevImage[5], pos.x, pos.y);
        currentImageLeft = 8;
        break;
      case 8:
        image(playerRevImage[5], pos.x, pos.y);
        currentImageLeft = 1;
        break;
      }
    } else if(prevDir == -1){
      image(playerRevImage[2], pos.x, pos.y);
    } else {
      image(playerImage[2], pos.x, pos.y);
    }
    
    popMatrix();
  }
 
  void update(int[][] tileData, int directionVertical, int directionHorizontal) {
    applyGravity(tileData);
    jump(directionVertical);
    moveVertical();
    moveHorizontal(directionHorizontal);
  }
  
  void applyGravity(int[][] data) {
    
    distance = getDistances(data);
    
    vel.y += gravityStrength;
        
    //if(distance[0] > vel.y) {
    //  vel.y += gravityStrength;
    //} else {
    //  pos.y += distance[0];
    //  vel.y = 0;
    //}
  }
  
  int[] getDistances(int[][] data) {
    int[] distance;
    //0 distance of bottom block
    //1 distance from top block
    //2 distance from left block
    //3 distance from right block
    
    distance = new int[4];
    
    
    distance[0] = height;
    distance[1] = height;
    distance[2] = width;
    distance[3] = width;
    
    //int x1 = 0, y1 = 0, x2 = 0, y2 = 0;

    for(int x = 0; x < data.length; x++) {
      for(int y = 0; y < data[x].length; y++) {
        if(data[x][y] >=0 && data[x][y] <=17) {
          // //now we have some tile with location (x, y)*h/8

          // calculate distance[0]
          if(pos.x > x*height/10 - size.x && pos.x < x*height/10 + height/10) {
            int currentDistance = y*height/10 - (int)pos.y - (int)size.y;
            if(currentDistance < distance[0] && currentDistance >= 0) {
              distance[0] = currentDistance;
              //x1 = (int)pos.x + (int)(size.x)/2;
              //y1 = (int)pos.y + (int)size.y;
              //x2 = (int)pos.x + (int)(size.x)/2;
              //y2 = y*height/10;
            }
          }
          //line(x1, y1, x2, y2);
          
          // calculate distance[1]
          if(pos.x > x*height/10 - size.x && pos.x < x*height/10 + height/10) {
            int currentDistance = (int)pos.y - y*height/10  - height/10;
            if(currentDistance < distance[1] && currentDistance >= 0) {
              distance[1] = currentDistance;
              //x1 = (int)pos.x + (int)(size.x)/2;
              //y1 = (int)pos.y;
              //x2 = (int)pos.x + (int)(size.x)/2;
              //y2 = y*height/10 + height/10;
            }
          }
          //line(x1, y1, x2, y2);
          
          // calculate distance[2]
          if(pos.y > y*height/10 - size.y && pos.y < (y+1)*height/10) {
            int currentDistance = (int)pos.x - x*height/10;
            if(currentDistance < distance[2] && currentDistance >= 0) {
              distance[2] = currentDistance;
              //x1 = (int)pos.x;
              //y1 = (int)pos.y + (int)(size.y)/2;
              //x2 = (x+1)*height/10;
              //y2 = (int)pos.y + (int)(size.y)/2;
            }
          }
          //line(x1, y1, x2, y2);
          
          // calculate distance[3]
          if(pos.y > y*height/10 - size.y && pos.y < (y+1)*height/10) {
            int currentDistance = x*height/10 - (int)pos.x - (int)size.x;
            if(currentDistance < distance[3] && currentDistance >= 0) {
              distance[3] = currentDistance;
              //x1 = (int)pos.x + ((int)(size.x))/2;
              //y1 = (int)pos.y + (int)(size.y)/2;
              //x2 = x*height/10;
              //y2 = (int)pos.y + (int)(size.y)/2;
            }
          }
          //line(x1, y1, x2, y2);
          //fixCorner(x, y);
        }
      }
    }
        
    // mid Air
    if(distance[0] == 0) {
      isMidAir = false;
    } else  if(distance[0] > 0) {
      isMidAir = true;
    }
    
    return distance;
    
    //isMidAir = true;
    //return false; // for not  collision; and true for collision
  }
  
  
  
  void moveHorizontal(int direction) { // -1: left, 0: nothing, 1: right;
    movingDirection = direction;
  //
    if(direction == 1) {
      if(distance[3] > movementSpeed) {
        pos.x += movementSpeed;
      } else {
        pos.x += distance[3];
      }
    } else if(direction == -1) {
      if(distance[2] > movementSpeed) {
        pos.x -= movementSpeed;
      } else {
        pos.x -= distance[2];
      }
    }
    
  }
  
  void moveVertical() {
    //pos.y += vel.y;
    if(vel.y < 0) {
      if(distance[1] > -vel.y) {
        pos.y += vel.y;
      } else {
        vel.y = 0;
        pos.y -= distance[1];
      } 
    } else if(vel.y > 0) {
      if(distance[0] > vel.y) {
        pos.y += vel.y;
      } else {
        vel.y = 0;
        pos.y += distance[0];
      }
    
    }
  }
  
  void jump(int direction) { // 0: nothing, 1: up;
    if(!isMidAir && direction == 1) {
      vel.y -= jumpStrength;
      isMidAir = true;
    }
  }
  
  //void fixCorner(int x, int y) {
  //  // isIntersecting
  //  if(pos.x + size.x > x*height/10 && pos.x < x*height/10 + height/10 && pos.y + size.y > y*height/10 && pos.y < y*height/10 + height/10) {
  //    println("now", frameCount);
  //    // top left
  //    if(vel.x > 0 && vel.y > 0) {
  //      pos.x = x*height/10 - size.x - 1;
  //      pos.y = y*height/10 - size.y - 1;
  //      vel.x = 0;
  //      vel.y = 0;
  //    }
  //    // top right
  //    if(vel.x < 0 && vel.y > 0) {
  //      pos.x = x*height/10 + height/10 + 1;
  //      pos.y = y*height/10 - size.y - 1;
  //      vel.x = 0;
  //      vel.y = 0;
  //    }
  //    // bottom left
  //    if(vel.x > 0 && vel.y < 0) {
  //      pos.x = x*height/10 - size.x - 1;
  //      pos.y = y*height/10 + height/10 + 1;
  //      vel.x = 0;
  //      vel.y = 0;
  //    }
  //    // bottom right
  //    if(vel.x < 0 && vel.y < 0) {
  //      pos.x = x*height/10 + height/10 + 1;
  //      pos.y = y*height/10 + height/10 + 1;
  //      vel.x = 0;
  //      vel.y = 0;
  //    }
  //  }
  //}
 
 
 }
