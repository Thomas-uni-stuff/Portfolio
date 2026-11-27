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
  ArrayList <Float> vxs = new ArrayList<Float>();
  ArrayList <Float> vys = new ArrayList<Float>();
  int loadedImages[];
  float noteCordsX [];
  float noteCordsY [];
  PImage note;
  int pointer;  //signifies where in the list the user is, and which values (number of notes corresdonding to number of streams) should be displayed
  boolean fillArray;
  boolean doDisplay;  //Checks whether box containing artist information should be displayed
  boolean displayFPS;

  MusicNote(EachArtist artistRef) {
    sharedRef = artistRef;
    eachArtistStreams = sharedRef.getEachArtistStreams();
    uniqueArtists = sharedRef.getUniqueArtists();
    note = loadImage("musicNote.png");
    pointer = 0;
    fillArray = true;
    doDisplay = false;
    displayFPS = false;
  }

  void populateArrays() {    //Populates arrays 'xCords' and 'yCords' with x and y starting positions for each music note that should be displayed, as well as velocity for x and y
    int tempPointer = 0;
    tempPointer = pointer;
    if (fillArray == true) {
      for (int i=0; i<3; i++) {
        for (int n=0; n<eachArtistStreams.get(tempPointer); n++) {
          xCords.add(random(0, width));
          yCords.add(random(0, height));
          vxs.add(random(-2, -3));
          vys.add(random(-0.5, -2.5));
        }
        tempPointer = tempPointer + 1;
      }
    }
    fillArray = false;
  }

  void handleKeyPressed() {  //Connects MusicNote to main class so that keyPressed can be registered
    if (pointer >=0 && pointer < 36.1) {
      if (key == CODED) {  //checks whether key is cooded, so UP and DOWN arrows can be detected
        if (keyCode == UP && pointer != 36) {
          pointer = pointer + 1;
          xCords.clear();    //both arrays get cleared so that new cords get added to a blank array, and won't be added at the end of the already existing cords that are present
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
    if (key == 'o' || key == 'O') {
      doDisplay = !doDisplay;
    }
    if (key == 'p' || key == 'P') {
      displayFPS = !displayFPS;
    }
  }


void displayNotes() {
  int brightness = 30;    //determines the brightness of the music notes depending on the level they are in (upper levels = more bright, lower levels = less bright)
  int tempPointer = 0;
  float noteColour = 0;
  int counter = 1;
  float size = 20;
  int loopChecker = 2;
  tempPointer = pointer + 2;
  for (int i=xCords.size()-1; i>=0; i--) {
    noteColour = (tempPointer * 137.5) % 360;
    tint(noteColour, 100, brightness);
    image(note, xCords.get(i), yCords.get(i), size, size);
    counter = counter + 1;
    if (counter == eachArtistStreams.get(tempPointer) && loopChecker > 0) {  //Checks whether counter value is equal to the number of streams in the position tempPointer is pointing to
      brightness = brightness*2;
      tempPointer = tempPointer - 1;
      counter = 1;
      size = size*2;
      loopChecker = loopChecker - 1;
    }
  }
}

void displayBox(boolean boolVal1, boolean boolVal2) {
  if (boolVal1 == true) {
    fill(360);
    rect(width-100, 0, 100, 20);
    fill(0);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("Level: "+pointer, width-50, 10);
    fill(360);
    rect(width-100, 20, 100, 100);
    fill(0);
    text("ARTISTS", width-50, 30);
    line(width-90, 40, width-10, 40);
    textSize(10);
    text(uniqueArtists.get(pointer), width-50, 50);
    text(uniqueArtists.get(pointer+1), width-50, 70);
    text(uniqueArtists.get(pointer+2), width-50, 90);
  }
  if (boolVal2 == true) {
    fill(360);
    textSize(20);
    textAlign(LEFT);
    text(frameRate, 0, 20);
  }
}

void moveNotes() {
  for (int i=0; i<xCords.size(); i++) {
    xCords.set(i, xCords.get(i) + vxs.get(i));
    yCords.set(i, yCords.get(i) + vys.get(i));
    if (xCords.get(i) < -100) {
      xCords.set(i, xCords.get(i)+ (width + 100));
      yCords.set(i, -yCords.get(i)+height);
    }
  }
}

void clearArrays() {
  xCords.clear();
  yCords.clear();
  pointer = 0;
}

void draw() {
  background(0);
  populateArrays();
  displayNotes();
  moveNotes();
  displayBox(doDisplay, displayFPS);
  }
}
