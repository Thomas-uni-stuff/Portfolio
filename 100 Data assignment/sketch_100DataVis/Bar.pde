class Bar {
  String artists[];    //Array holds artist names
  String aStreams[];    //Array holds artist streams for each day
  String tStreams[];    //Array holds total number of streams for each day
  String artisID[];
  int tempArrayNum[];
  String tempArrayStr[];
  int artistLen;
  int posX;
  int date;
  

  Bar() {
    posX = 10;
    date = 1;
    artistLen = 0;
    artists = loadStrings("TopArtistNames.txt");
    aStreams = loadStrings("TopArtistStreams.txt");
    tStreams = loadStrings("TotalStreams.txt");
  }

  void createBar() {
    for (int i=0; i<tStreams.length; i++) {    //Loop to create the number of bars respective to the number of data items in the tStreams txt file
      fill(65);
      stroke(65);
      rect(posX, height - int(tStreams[i])*8, 35, int(tStreams[i])*8);    //Creates the bar in incrementing positions
      text(date +"/10", posX, 10);
      line(posX-10, 0, posX-10, 20);
      artistLen = int(tStreams[i])*8;
      tempArrayNum = int(split(aStreams[i], '/'));
      for (int u=0; u<tempArrayNum.length; u++) {
        fill(255);
        rect(posX, (height - artistLen), 35, tempArrayNum[u]*8);
        artistLen = artistLen - tempArrayNum[u]*8;
      }
      posX = posX + 45;
      date = date + 1;
    }
    posX = 10;
    date = 1;
  }
}
