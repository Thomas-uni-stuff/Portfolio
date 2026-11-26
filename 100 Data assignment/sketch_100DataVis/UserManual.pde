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
    text("- You can also clear all selected Artists by pressing BACKSPACE", 750, 565);
    textSize(25);
    text("If you press 2, you'll open the MusicNote part of the program", 750, 615);
    textSize(20);
    text("- Here I am displaying my streams for each artist with a colour coded music note, which moves across the screen continously", 750, 640);
    text("- I display 3 'Levels' at once, and you can toggle between each level with the UP arrow and DOWN arrow keys", 750, 665);
    text("- You can also press 'o' to open a display window, which shows the artists currently displayed in descending order", 750, 685);
    textSize(25);
    text("I had an absolute blast creating this program, it took some time and a lot of work, but I am very proud of it", 750, 725);
    text("I hope you enjoy my visualisations (and that I get a good grade for it as well haha)", 750, 755);
    textSize(15);
    text("Press Enter to leave the user manual", 750, 780);
    textFont(times);
    textAlign(LEFT);
  }
}
