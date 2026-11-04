/*
 This class displays a grid at the top of the canvas with a box that contains the name of each artist that appears in the TopArtistNames.txt file
 The class allows the user to click on each individual box with the artist names, and once clicked it will create a floating ball that reprsents the total streams for that artist
 The size of the ball will the the total number of streams, and the velocity of the ball will be how many times the artist appears accross the month
 */

class EachArtist {
  String artists[];
  ArrayList<String> uniqueArtists = new ArrayList<String>();    //Stores the name of each unique artist that has been listened to during October
  ArrayList<Integer> totalArtistStreams = new ArrayList<Integer>();    //ArrayList used to store all 155 streaming values
  ArrayList<String> artistNames = new ArrayList<String>();    //Stores all 155 artist names
  ArrayList<Integer> eachArtistStreams = new ArrayList<Integer>();    //Stores the total number of streams for each artist
  ArrayList<Float> artistApps = new ArrayList<Float>();    //Stores the total number of appearances by each artist during October
  float ballCordsX[];
  float ballCordsY[];
  float vxs[];
  float vys[];
  int ballSize;
  int counter;
  String artistStreams[];
  PFont times;
  boolean colourFlags[];
  float radius;

  EachArtist() {
    counter = 0;
    radius = 0;
    artists = loadStrings("TopArtistNames.txt");
    artistStreams = loadStrings("TopArtistStreams.txt");
    times = createFont("times.ttf", 14);
    for (int i=0; i<artists.length; i++) {
      String tempArray[] = split(artists[i], '/');
      int tempArrayNum[] = int(split(artistStreams[i], '/'));
      for (int u=0; u<tempArray.length; u++) {
        totalArtistStreams.add(tempArrayNum[u]);
        artistNames.add(tempArray[u]);
        if (uniqueArtists.contains(tempArray[u])) {
        } else {
          uniqueArtists.add(tempArray[u]);
        }
      }
    }
    vxs = new float[uniqueArtists.size()];
    vys = new float[uniqueArtists.size()];
    ballCordsX = new float[uniqueArtists.size()];
    ballCordsY = new float[uniqueArtists.size()];
    for (int n=0; n<uniqueArtists.size(); n++) {
      float appearanceCounter = 0;
      int streamsCounter = 0;    //Re-initialises streamsCounter to 0 every time n is incremented
      ballCordsX[n] = random(400, 1100);
      ballCordsY[n] = random(550, 650);
      for (int a=0; a<artistNames.size(); a++) {
        if (uniqueArtists.get(n).equals(artistNames.get(a))) {    //compares uniqueArtists pos n with artistNames pos a
          streamsCounter = streamsCounter + totalArtistStreams.get(a);  //if uniqueArtists(n) and artistNames(a) are equal, streamsCounter is incremented by the value in topArtistStreams(a)
          appearanceCounter = appearanceCounter + 1;
        }
      }
      eachArtistStreams.add(streamsCounter);    //streamsCounter is added to the eachArtistStreams arrayList, so that it creates a parallel arrayList to uniqueArtists
      artistApps.add(appearanceCounter);
    }
    for (int b=0; b<uniqueArtists.size(); b++) {  //Initialises each velocity for each artist dependant on number of apperances 
      vxs[b] = artistApps.get(b)/2;
      vys[b] = artistApps.get(b)/2;
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
      if (colourFlags[i] == true) {
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
    text("Counter : " + counter, xPos+75, yPos+20);
  }

  void createBall() {    //Method creates a ball representing each artist, size is determined by number of streams
    float ballColour = 0;
    for (int i=0; i<uniqueArtists.size(); i++) {
      ballColour = (i * 137.5) % 360;    //Assigns the same colour that is used in the bar graph to represent each artist, to the ball that represents the same artist
      if (colourFlags[i] == true) {
        radius =  sqrt(eachArtistStreams.get(i)) * 8;  //takes the square root of the streams and multiplies by 8, this is so that there isn't a massive gap between the smallest and largest values
        fill(ballColour, 100, 100);
        circle(ballCordsX[i], ballCordsY[i], radius);
      }
      radius = 0;
      ballColour = 0;
    }
  }

  void collisionCheck() {    //Method checks collision of balls against walls and boxes
    for (int i=0; i<uniqueArtists.size(); i++) {
      radius = sqrt(eachArtistStreams.get(i)) * 8;
      if (ballCordsX[i] + radius/2 > width || ballCordsX[i] - radius/2 < 0) {
        vxs[i] = -vxs[i];
      }
      if (ballCordsY[i] + radius/2 > height || ballCordsY[i] - radius/2 < 160) {
        vys[i] = -vys[i];
      }
    }
  }

  void moveBall() {    //Method makes each ball move at a velocity dependant on the number of days in October they have been listened to
    for (int i=0; i<uniqueArtists.size(); i++) {
      ballCordsX[i] = ballCordsX[i] + vxs[i];
      ballCordsY[i] = ballCordsY[i] + vys[i];
    }
  }

  void draw() {
    background(245);
    createBox();
    createBall();
    moveBall();
    collisionCheck();
  }
}
