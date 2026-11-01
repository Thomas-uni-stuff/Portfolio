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
  boolean colourFlags[];
  int test;

  EachArtist() {
    test = 0;
    artists = loadStrings("TopArtistNames.txt");
    times = createFont("times.ttf", 12);
    for (int i=0; i<artists.length; i++) {
      String tempArray[] = split(artists[i], '/');
      for (int u=0; u<tempArray.length; u++) {
        if (uniqueArtists.contains(tempArray[u])) {
        } else {
          uniqueArtists.add(tempArray[u]);
        }
      }
    }
    colourFlags = new boolean[uniqueArtists.size()];    //initialises colourFlags with all false values
  }

  void createBox() {
    float xPos = 0;
    int yPos = 0;
    for (int i=0; i<uniqueArtists.size(); i++) {
      if (xPos > width-1) {    //width - 1 ensures that the last box on the x axis correctly overflows and gets put on the next line
        yPos = yPos + 40;
        xPos = 0;
      }
      if (mouseX >= xPos && mouseX <= xPos + 125 && mouseY >= yPos && mouseY <= yPos + 40) {
        colourFlags[i] = !colourFlags[i];
      }
      if (colourFlags[i] == true) {
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

  void mouseClicked() {
    test = 1;
  }

  void draw() {
    background(245);
    println(test);
  }
}
