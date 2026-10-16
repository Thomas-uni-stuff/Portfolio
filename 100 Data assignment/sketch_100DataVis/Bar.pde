class Bar {
  String artists[];    //Array holds artist names
  String aStreams[];    //Array holds artist streams for each day
  String tStreams[];    //Array holds total number of streams for each day
  int posX;
  int date;

  Bar() {
    posX = 10;
    date = 01;
    artists = loadStrings("TopArtistNames.txt");
    aStreams = loadStrings("TopArtistStreams.txt");
    tStreams = loadStrings("TotalStreams.txt");
  }


  void draw() {
    for (int i=0; i<tStreams.length; i++) {
      fill(65);
      stroke(65);
      rect(posX, height - int(tStreams[i])*8, 35, int(tStreams[i])*8);
      text(date +"/10", posX, 10);
      line(posX-10, 0, posX-10, 20);
      posX = posX + 45;
      date = date + 1;
    }
    posX = 10;
    date = 1;
  }
}
