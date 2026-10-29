//This class simply displays a user manual with all the necessary info of the program

class UserManual {

  PFont gothic;
  PFont times;
  UserManual() {
    gothic = createFont("OldLondonAlternate.ttf", 50);
    times = createFont("times.ttf", 12);
  }

  void draw() {
    fill(360);
    rect(200, 200, 1100, 600);
    fill(0);
    textFont(gothic);
    textAlign(CENTER);
    text("Welcome to my dear data project!", 750, 240);
    textSize(25);
    text("This is the user manual for my project, where I will be laying out a few of the cool things you can do with my program", 750, 280);
    text("But first a quick breakdown of what my project even displays:", 750, 320);
    textSize(20);
    text("My project displays a breakdown of the artists I've listened to during the month of October", 750, 345);
    text("I'm displaying the number of total streams for each day, as well as my top 5 artists for those days", 750, 365);
    textSize(25);
    text("The start-up page is a simple, statisitcal visualisation (don't worry I have more creative ways of displaying my data)", 750, 415);
    textSize(20);
    text("- If you run your mouse over each bar on the start up page you can see which artists appear in each bar", 750, 440);
    textSize(25);
    text("If you press 1, you'll open the part of the program I refer to as 'Each Artist'", 750, 490);
    textSize(20);
    text("- There is a visualisation of how many streams each artist has racked up during October", 750, 515);
    text("- I've also visualised how many seperate times the artist appears during October", 750, 540);
    textSize(15);
    text("Press any button (except u or esc) to leave the user manual", 750, 780);
    textFont(times);
    textAlign(LEFT);
  }
}
