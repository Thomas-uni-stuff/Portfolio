/*  This class displays a visualisation of the number of streams for each artist
 This is visualised with moving music notes, that are represented in the respective colours of each artist
 The visualisation of the notes is layered, so the ones in the top will be more visible, and the ones lower down more opaque
 The program also allows you to move between each level, as there are 39 artists it would not be logical or even possible to display all at once
 There is a 'Level' display window, that signals to the user which level they are currently viewing
 */

class MusicNote {
  EachArtist sharedRef;
  ArrayList<String> uniqueArtists = new ArrayList<String>();
  ArrayList <Integer> eachArtistStreams = new ArrayList<Integer>();
  ArrayList <Float> xCords = new ArrayList<Float>();
  ArrayList <Float> yCords = new ArrayList<Float>();
  int loadedImages[];
  float noteCordsX [];
  float noteCordsY [];
  PImage note;
  int pointer;  //signifies where in the list the user is, and which values (number of notes corresdonding to number of streams) should be displayed
  boolean fillArray;
  float vx;
  float vy;

  MusicNote(EachArtist artistRef) {
    sharedRef = artistRef;
    eachArtistStreams = sharedRef.getEachArtistStreams();
    uniqueArtists = sharedRef.getUniqueArtists();
    note = loadImage("musicNote.png");
    pointer = 0;
    fillArray = true;
    vx = 3;
    vy = 3;
  }

  void populateArrays() {    //Populates arrays 'xCords' and 'yCords' with x and y starting positions for each music note that should be displayed
    int tempPointer = 0;
    tempPointer = pointer;
    if (fillArray == true) {
      for (int i=0; i<3; i++) {
        for (int n=0; n<eachArtistStreams.get(tempPointer); n++) {
          xCords.add(random(0, width));
          yCords.add(random(0, height));
        }
        tempPointer = tempPointer + 1;
      }
    }
    fillArray = false;
  }

  void handleKeyPressed() {  //Connects MusicNote to main class so that keyPressed can be registered
    if (pointer >=0 && pointer < 31.1) {
      if (key == CODED) {
        if (keyCode == UP && pointer != 31) {
          pointer = pointer + 1;
          xCords.clear();
          yCords.clear();
          fillArray = true;
        }
        if (pointer > 0) {
          if (keyCode == DOWN) {
            pointer = pointer - 1;
            xCords.clear();
            yCords.clear();
            fillArray = true;
          }
        }
      }
    }
  }

  void displayNotes() {
    int brightness = 100;    //determines the brightness of the music notes depending on the level they are in (upper levels = more bright, lower levels = less bright)
    int tempPointer = 0;
    float noteColour = 0;
    int counter = 1;
    int size = 90;
    tempPointer = pointer;
    for (int i=0; i<xCords.size(); i++) {
      noteColour = (tempPointer * 137.5) % 360;
      tint(noteColour, 100, brightness);
      image(note, xCords.get(i), yCords.get(i), size, size);
      counter = counter + 1;
      if (counter == eachArtistStreams.get(tempPointer)) {  //Checks whether counter value is equal to the number of streams in the position tempPointer is pointing to
        brightness = brightness - 30;
        tempPointer = tempPointer + 1;
        counter = 1;
        size = size - 30;
      }
    }
  }

  void clearArrays() {
    xCords.clear();
    yCords.clear();
  }

  void draw() {
    background(0);
    populateArrays();
    displayNotes();
  }
}
