/*
 Minimum screen size 17inches, 20+ inches recommended
 If minimum requirement is not met, program will not entirely fit on screen
 
 Program created by Thomas Rasmussen, student at City, St. George's,
 Creative coding course work assignment undergrad year 1
 Worked on between October - December 2026
 */

Bar bar;
UserManual userManual;
EachArtist eachArtist;
MusicNote musicNote;
boolean manualDisplayed;
int textColour;
int textAddition;    //determines whether textColour gets added or subtracted
String rawArtists[];
String rawStreams[];
String rawTotalStreams[];
String rawIDs[];
int posChecker;  //posChecker checks which class the user is currently viewing, this is so if they decide to pull up the user manual, when they leave it, they will not be booted back to the start screen

void setup() {
  size(1500, 1000);
  manualDisplayed = false;
  textColour = 5;
  textAddition = 2;
  posChecker = 0;
  rawArtists = loadStrings("TopArtistNames.txt");    //Loads the data from each text file in the constructor of the main class
  rawStreams = loadStrings("TopArtistStreams.txt");  //This is so that it does not have to be loaded in each individual class
  rawTotalStreams = loadStrings("TotalStreams.txt");
  rawIDs = loadStrings("ArtistID.txt");
  bar = new Bar(rawArtists, rawStreams, rawTotalStreams, rawIDs);
  eachArtist = new EachArtist(rawArtists, rawStreams);
  userManual = new UserManual();
  musicNote = new MusicNote(eachArtist);  //Passing eachArtist as parameter so MusicNote has a direct reference to the existing EachArtist object that is in memory
}

enum ScreenMode {  //enum value used to determine which class the user is currently viewing, and makes it so that the user can only leave each class by pressing ENTER
  BAR,
    EACH_ARTIST,
    MUSIC_NOTE,
    USER_MANUAL
}

ScreenMode currentMode = ScreenMode.BAR;

void mouseClicked() {
  eachArtist.handleClick();    //Connects the main program with eachArtist, so that the mouse click can be registered inside the eachArtist class
}

void keyPressed() {
  if (key == '1') {
    currentMode = ScreenMode.EACH_ARTIST;
    posChecker = 1;
  }
  if (key == '2') {
    currentMode = ScreenMode.MUSIC_NOTE;
    posChecker = 2;
    eachArtist.resetTable();  //Resets the table that activates the particles in EachArtist when user leaves the screen so that it does not continue running in the background
  }
  if (key == 'u' || key == 'U') {
    currentMode = ScreenMode.USER_MANUAL;
    manualDisplayed = true;
  }
  if (key == ENTER || key == RETURN) {
    if (currentMode == ScreenMode.USER_MANUAL) {
      if (posChecker == 0) {
        currentMode = ScreenMode.BAR;
      } else if (posChecker == 1) {
        currentMode = ScreenMode.EACH_ARTIST;
      } else if (posChecker == 2) {
        currentMode = ScreenMode.MUSIC_NOTE;
      }
    } else {
      currentMode = ScreenMode.BAR;
      eachArtist.resetTable();
    }
  }
  musicNote.handleKeyPressed();
}

void draw() {
  if (currentMode == ScreenMode.BAR) {
    bar.draw();
  }
  if (currentMode == ScreenMode.EACH_ARTIST) {
    eachArtist.draw();
  }
  if (currentMode == ScreenMode.MUSIC_NOTE) {
    musicNote.draw();
  }
  if (currentMode == ScreenMode.USER_MANUAL) {
    userManual.draw();
  }
  if (manualDisplayed == false) {    //checks whether user manual has been opened before or not, if it hasn't text is diplayed informing user of how to access user manual
    textAlign(CENTER);
    textSize(120);
    fill(textColour);
    text("Press U to open user manual", 750, 500);
    textColour = textColour + textAddition;  //adds/subtracts 2 to textColour so that the colour of the text gradually becomes lighter/darker
    if (textColour > 120) {
      textAddition = -textAddition;    //Flips the addition value when textColour reaches 120, so that instead of adding 2 it subtracts 2
    }
    if (textColour < 5) {
      textAddition = -textAddition;    //Flips the addition value when textColour reaches 5, so that it adds 2 again
    }
  }
}
