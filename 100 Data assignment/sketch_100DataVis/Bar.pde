class Bar {
  String artists[];    //Array holds artist names
  String aStreams[];    //Array holds artist streams for each day
  String tStreams[];    //Array holds total number of streams for each dayartistID[]
  String artistIDs[];
  int artistLen;
  int posX;
  int date;
  ArrayList<Integer> uniqueArtists = new ArrayList<Integer>();    //Creates arrayList that stores each unique artistID
  float artistColour;


  Bar() {
    colorMode(HSB, 360, 100, 100);    //setting the colour mode to HSB to make it easier to customise the colour of each artist bar
    posX = 10;
    date = 1;
    artistLen = 0;
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
  }

  void barColour(float floatVal) {    //Method fills in each artist block with a colour depending on their position in the uniqueArtist arrayList
    float listSize = (360/uniqueArtists.size());
    floatVal = (floatVal * listSize);
    fill(floatVal, 100, 100);
  }



  void createBar() {
    background(360);
    for (int i=0; i<tStreams.length; i++) {    //Loop to create the number of bars respective to the number of data items in the tStreams txt file
      fill(65);
      stroke(65);
      rect(posX, height - int(tStreams[i])*8, 35, int(tStreams[i])*8);    //Creates the bar in incrementing positions
      fill(0);
      stroke(0);
      text(date +"/10", posX, 10);
      line(posX-10, 0, posX-10, 20);
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
}
