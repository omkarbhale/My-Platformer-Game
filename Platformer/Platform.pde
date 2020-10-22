class Platform {
  int[][] tileData;
  boolean isTileDataInit = false;
  
  Platform(String filename) {
    
    String lines[] = loadStrings(filename);
    for(int row = 0; row < lines.length; row++) {
      String[] values = split(lines[row], ",");
      for(int col = 0; col < values.length; col++) {
        
        // initialising data
        if(!isTileDataInit) {
          tileData = new int[values.length][10];
          isTileDataInit = true;
        }

        // storing data
        tileData[col][row] = Integer.parseInt(values[col]);
      }
      //println(" ");
    } 
  }
  
  void show() {
    pushMatrix();
    translate(-(player.pos.x - 5*height/10), 0);
    
   for(int x = 0; x < tileData.length; x++) {
     for(int y = 0; y < tileData[x].length; y++) {
       switch (tileData[x][y]){
         case 0:
           image(tiles[0], x * height/10, y * height/10);
           break;
         case 1:
           image(tiles[1], x * height/10, y * height/10);
           break;
         case 2:
           image(tiles[2], x * height/10, y * height/10);
           break;
         case 3:
           image(tiles[3], x * height/10, y * height/10);
           break;
         case 4:
           image(tiles[4], x * height/10, y * height/10);
           break;
         case 5:
           image(tiles[5], x * height/10, y * height/10);
           break;
         case 6:
           image(tiles[6], x * height/10, y * height/10);
           break;
         case 7:
           image(tiles[7], x * height/10, y * height/10);
           break;
         case 8:
           image(tiles[8], x * height/10, y * height/10);
           break;
         case 9:
           image(tiles[9], x * height/10, y * height/10);
           break;
         case 10:
           image(tiles[10], x * height/10, y * height/10);
           break;
         case 11:
           image(tiles[11], x * height/10, y * height/10);
           break;
         case 12:
           image(tiles[12], x * height/10, y * height/10);
           break;
         case 13:
           image(tiles[13], x * height/10, y * height/10);
           break;
         case 14:
           image(tiles[14], x * height/10, y * height/10);
           break;
         case 15:
           image(tiles[15], x * height/10, y * height/10);
           break;
         case 16:
           image(tiles[16], x * height/10, y * height/10);
           break;
         case 17:
           image(tiles[17], x * height/10, y * height/10);
           break;
       }   
     }
   }
   popMatrix();
  }
}
