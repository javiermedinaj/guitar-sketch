Game game;

void setup() {
  size(800, 600);
  game = new Game(this);
}

void draw() {
  game.update();
}

void keyPressed() {
  if (key == 'a' || key == 's' || key == 'd' || key == 'f') {
    int lane = key == 'a' ? 0 : key == 's' ? 1 : key == 'd' ? 2 : 3;
    game.checkHit(lane);
  }
}
