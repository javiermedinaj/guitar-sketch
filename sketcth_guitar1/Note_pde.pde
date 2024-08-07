class Note {
  PApplet p;
  float x, y;
  int lane;
  
  Note(float x, float y, PApplet p) {
    this.x = x;
    this.y = y;
    this.lane = p.floor((x - 200) / 100);
    this.p = p;
  }
  
  void update() {
    y += 5;  // Velocidad de caída
  }
  
  void display() {
    p.fill(255, 0, 0);
    p.ellipse(x, y, 50, 50);
  }
  
  boolean isHit(int lane) {
    return this.lane == lane && this.y > p.height - 150 && this.y < p.height - 100;
  }
}
