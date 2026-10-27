/*minimum screen size 17inches, 20+ inches recommended
 if minimum requirement is not met, program will not entirely fit on screen*/
Bar bar;
UserManual userManual;
PFont times;

void setup() {
  size(1500, 1000);
  background(255);
  bar = new Bar();
  userManual = new UserManual();
  times = createFont("times.ttf", 12);
}


void draw() {
  bar.draw();
  if (key == 'u' || key == 'U') {
    userManual.draw();
  }
}
