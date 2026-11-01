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
  int counter;
  PFont times;
  boolean colourFlags[];

  EachArtist() {
    counter = 0;
    artists = loadStrings("TopArtistNames.txt");
    times = createFont("times.ttf", 14);
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

  void handleClick() {    //Method checks where mouse is and is connected to mouseClicked method in main class, so that it runs every time mouse is pressed
    float xPos = 0;
    int yPos = 0;
    counter = 0;
    for (int i=0; i<uniqueArtists.size(); i++) {
      if (xPos > width-1) {
        yPos = yPos + 40;
        xPos = 0;
      }
      if (mouseX >= xPos && mouseX <= xPos + 150 && mouseY >= yPos && mouseY <= yPos + 40) {
        colourFlags[i] = !colourFlags[i];
      }
      if(colourFlags[i] == true){
        counter = counter + 1;    //counts the number of artists boxes currently active in the program
      }
      xPos = xPos + 150;
    }
  }

  void createBox() {
    float xPos = 0;
    int yPos = 0;
    for (int i=0; i<uniqueArtists.size(); i++) {
      if (xPos > width-1) {    //width - 1 ensures that the last box on the x axis correctly overflows and gets put on the next line
        yPos = yPos + 40;
        xPos = 0;
      }
      if (colourFlags[i] == true) {    //Changes the fill so that the box is darker when colourFlags[i] is true, i.e when mouse is clicked in corresponding position
        fill(225);
      } else {
        fill(360);
      }
      rect(xPos, yPos, 150, 40);
      textAlign(CENTER, CENTER);
      textFont(times);
      fill(0);
      text(uniqueArtists.get(i), xPos+75, yPos+20);
      xPos = xPos + 150;
    }
    rect(xPos, yPos, 150, 40);    //creates seperate box that serves the purpose of the 'counter box', here the number of artist boxes currently active is displayed
    fill(360);
    textAlign(RIGHT, CENTER);
    text("Counter :   " + counter, xPos+75, yPos+20);
  }

  void draw() {
    background(245);
    createBox();
  }
}
