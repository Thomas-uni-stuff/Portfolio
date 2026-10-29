/*
 This class displays a grid at the top of the canvas with a box that contains the name of each artist that appears in the TopArtistNames.txt file
 The class allows the user to click on each individual box with the artist names, and once clicked it will create a floating ball that reprsents the total streams for that artist
 The size of the ball will the the total number of streams, and the velocity of the ball will be how many times the artist appears accross the month
 */

class EachArtist {
  String artists[];
  ArrayList<String> uniqueArtists = new ArrayList<String>();
  ArrayList<Integer> artistApps = new ArrayList<Integer>();
  int ballVel;
  int ballSize;
  PFont times;
  boolean colourBox;


  EachArtist() {
    artists = loadStrings("TopArtistNames.txt");
    times = createFont("times.ttf", 12);
    colourBox = false;
    for (int i=0; i<artists.length; i++) {
      String tempArray[] = split(artists[i], '/');
      for (int u=0; u<tempArray.length; u++) {
        if (uniqueArtists.contains(tempArray[u])) {
        } else {
          uniqueArtists.add(tempArray[u]);
        }
      }
    }
  }
  void createBox() {
    float xPos = 0;
    int yPos = 0;
    colourBox = false;
    for (int i=0; i<uniqueArtists.size(); i++) {
      if (xPos > width) {
        yPos = yPos + 40;
        xPos = 0;
      }
      if (mouseX >= xPos && mouseX <= xPos + 100 && mouseY >= yPos && mouseY <= yPos + 40 && mousePressed == true) {
        colourBox = true;
      }
      if (colourBox == true) {
        fill(225);
      } else {
        fill(360);
      }
      rect(xPos, yPos, 125, 40);
      textAlign(CENTER, CENTER);
      textFont(times);
      fill(0);
      text(uniqueArtists.get(i), xPos+62.5, yPos+20);
      xPos = xPos + 125;
    }
  }

  void draw() {
    background(245);
    createBox();
  }
}
