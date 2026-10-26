/*minimum screen size 17inches, 20+ inches recommended
if minimum requirement is not met, program will not entirely fit on screen*/ 

Bar bar;

String test1[];
int test[];

void setup() {
  size(1500, 1000);
  background(255);
  bar = new Bar();
}


void draw(){
  bar.draw();
}
