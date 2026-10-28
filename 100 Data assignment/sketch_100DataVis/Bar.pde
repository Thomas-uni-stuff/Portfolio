class Bar { //<>//
  String artists[];    //Array holds artist names
  String aStreams[];    //Array holds artist streams for each day
  String tStreams[];    //Array holds total number of streams for each dayartistID[]
  String artistIDs[];  //Array holds the artist ID's, this array is used in createBar with the method barColour to determine the bar colour for each individual artist
  int artistLen;
  int boxLen;
  int posX;
  int rectPosX;
  int date;
  int counter;
  int listPos;
  ArrayList<Integer> uniqueArtists = new ArrayList<Integer>();    //Creates arrayList that stores each unique artistID
  ArrayList<String> artistNames = new ArrayList<String>();    //Creates arrayList that stores the name of every single artist for each day
  float artistColour;
  boolean drawBox;


  Bar() {
    colorMode(HSB, 360, 100, 100);    //setting the colour mode to HSB to make it easier to customise the colour of each artist bar
    posX = 10;
    date = 1;
    artistLen = 0;
    rectPosX = 10;
    counter = 0;
    artists = loadStrings("TopArtistNames.txt");
    aStreams = loadStrings("TopArtistStreams.txt");
    tStreams = loadStrings("TotalStreams.txt");
    artistIDs = loadStrings("ArtistID.txt");
    for (int i=0; i<artistIDs.length; i++) {
      int tempIDs[] = int(split(artistIDs[i], '/'));
      for (int u=0; u<tempIDs.length; u++) {
        if (uniqueArtists.contains(tempIDs[u])) {    //if the uniqueArtists arrayList already contains the artistID in tempIDs[u], nothing happens and it checks the next element in tempIDs
        } else {
          uniqueArtists.add(tempIDs[u]);      //if it doesn't contain the artistID, then it is added to the uniqueArtists
        }
      }
    }
    for (int u=0; u<artists.length; u++) {
      String tempNames[] = split(artists[u], '/');
      for (int n=0; n<tempNames.length; n++) {
        artistNames.add(tempNames[n]);    //adds every single artist name into an arrayList, this is later used in the artistDisplay function
      }
    }
  }

  void barColour(float floatVal) {    //Method fills in each artist block with a colour depending on their position in the uniqueArtist arrayList
    floatVal = (floatVal * 137.5)%360;
    fill(floatVal, 100, 100);
  }

  void artistDisplay() {    //method that draws box which displays the artist names that appear in each bar
    drawBox = false;    //Initialises drawBox to false
    for (int i=0; i<tStreams.length; i++) {
      boxLen = int(tStreams[i])*8;
      int tempArrayNum[] = int(split(aStreams[i], '/'));
      for (int u=0; u<tempArrayNum.length; u++) {
        if (mouseX >= rectPosX && mouseX <= rectPosX+35 && mouseY <= height && mouseY >= height-boxLen) {
          drawBox = true;    //drawBox is flipped to true to signal when mouse position is over a bar
        }
      }
      if (mouseX <= 45) {
        counter = 0;
      }
      counter = int(mouseX/45.01);    //dividing by 45.01 so that the last pixel of the bar doesn't cause listPos to update to next position
      listPos = counter * 5;    //uses counter to assign the position in artistNames that needs to be fetched and displayed depending on the mouse position
      rectPosX = rectPosX + 45;
      if(mouseX > artistNames.size() * 45){
        counter = 0;    //prevents the program from crashing if mouse position exceeds last bar that is displayed, prevents overflow in artistNames
      }
    }
    rectPosX = 10;
    if (drawBox == true) {    //if statment only produces a rectangle if the mouse is within the correct areas of the screen, dictated by drawBox being true
      fill(360, 200);
      rect(mouseX, mouseY, 150, 120);
      fill(0);
      text(artistNames.get(listPos), mouseX + 10, mouseY + 20);
      text(artistNames.get(listPos+1), mouseX + 10, mouseY + 40);
      text(artistNames.get(listPos+2), mouseX + 10, mouseY + 60);
      text(artistNames.get(listPos+3), mouseX + 10, mouseY + 80);
      text(artistNames.get(listPos+4), mouseX + 10, mouseY + 100);
    }
  }

  void createBar() {
    background(245);
    for (int i=0; i<tStreams.length; i++) {    //Loop to create the number of bars respective to the number of data items in the tStreams txt file
      fill(65);
      stroke(65);
      rect(posX, height - int(tStreams[i])*8, 35, int(tStreams[i])*8);    //Creates the bar in incrementing positions
      fill(0);
      stroke(0);
      text(date +"/10", posX+10, 10);
      line(posX, 0, posX, 20);
      artistLen = int(tStreams[i])*8;
      int tempArrayNum[] = int(split(aStreams[i], '/'));
      for (int u=0; u<tempArrayNum.length; u++) {    //Overlays the artists bar on top of the bar for total streams, visualising the amount each artist was streamed
        int tempIDs[] = int(split(artistIDs[i], '/'));
        if (uniqueArtists.contains(tempIDs[u])) {
          artistColour = uniqueArtists.indexOf(tempIDs[u]);
        }
        barColour(artistColour);
        rect(posX, (height - artistLen), 35, tempArrayNum[u]*8);
        artistLen = artistLen - tempArrayNum[u]*8;
      }
      posX = posX + 45;    //Updates the position of each new bar
      date = date + 1;    //Adds 1 to the date counter
    }
    posX = 10;    //reinitialises posX so that only the bars in desired range are drawn
    date = 1;    //reinitialises date so that only the date until the desired point is added to the canvas
  }

  void draw() {
    textFont(times);    //sets the font to times new roman, the defaul font used in this program
    createBar();
    artistDisplay();
  }
}
