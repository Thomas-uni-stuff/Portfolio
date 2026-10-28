/*minimum screen size 17inches, 20+ inches recommended
 if minimum requirement is not met, program will not entirely fit on screen*/
Bar bar;
UserManual userManual;
PFont times;
boolean manualDisplayed;
int textColour;
int textAddition;    //determines whether textColour gets added or subtracted

void setup() {
  size(1500, 1000);
  bar = new Bar();
  userManual = new UserManual();
  times = createFont("times.ttf", 12);
  manualDisplayed = false;
  textColour = 5;
  textAddition = 2;
}


void draw() {
  bar.draw();
  if (key == 'u' || key == 'U') {
    userManual.draw();
    manualDisplayed = true;
  }
  if (manualDisplayed == false) {    //checks whether user manual has been opened before or not, if it hasn't text is diplayed informing user of how to access user manual
    textAlign(CENTER);
    textSize(120);
    fill(textColour);
    text("Press U to open user manual", 750, 500);
    textColour = textColour + textAddition;  //adds/subtracts 2 to textColour so that the colour of the text gradually becomes lighter/darker
    if(textColour > 120){    
      textAddition = -textAddition;    //Flips the addition value when textColour reaches 120, so that instead of adding 2 it subtracts 2
    }
    if(textColour < 5){
      textAddition = -textAddition;    //Flips the addition value when textColour reaches 5, so that it adds 2 again
    }
  }
  textAlign(LEFT);    //realligns all text to the left, so text is displayed properly when bar class is called
}
