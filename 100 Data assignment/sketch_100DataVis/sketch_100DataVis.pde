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
boolean manualDisplayed;
int textColour;
int textAddition;    //determines whether textColour gets added or subtracted
String rawArtists[];
String rawStreams[];
String rawTotalStreams[];
String rawIDs[];

void setup() {
  size(1500, 1000);
  manualDisplayed = false;
  textColour = 5;
  textAddition = 2;
  rawArtists = loadStrings("TopArtistNames.txt");    //Loads the data from each text file in the constructor of the main class
  rawStreams = loadStrings("TopArtistStreams.txt");  //This is so that it does not have to be loaded in each individual class
  rawTotalStreams = loadStrings("TotalStreams.txt");
  rawIDs = loadStrings("ArtistID.txt");
  bar = new Bar(rawArtists, rawStreams, rawTotalStreams, rawIDs);
  eachArtist = new EachArtist(rawArtists, rawStreams);
  userManual = new UserManual();
}

void mouseClicked() {
  eachArtist.handleClick();    //Connects the main program with eachArtist, so that the mouse click can be registered inside the eachArtist class
}

void keyPressed() {
  if (key == 'u' || key == 'U') {
    userManual.draw();
    manualDisplayed = true;
  }
  textAlign(LEFT);    //realligns all text to the left, so text is displayed properly when bar class is called
  if (key == '1') {
    eachArtist.draw();
  }
}


void draw() {
  bar.draw();
  keyPressed();
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
