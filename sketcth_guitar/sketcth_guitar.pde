ArrayList<Note> notes;
int score;
int lives;

void setup() {
  size(800, 600);
  notes = new ArrayList<Note>();
  score = 0;
  lives = 3;
}

void draw() {
  background(0);
  
  // Dibujar "cuerdas"
  for (int i = 0; i < 4; i++) {
    stroke(255);
    line(200 + i * 100, 0, 200 + i * 100, height);
  }
  
  // Actualizar y dibujar notas
  for (int i = notes.size() - 1; i >= 0; i--) {
    Note note = notes.get(i);
    note.update();
    note.display();
    
    if (note.y > height) {
      notes.remove(i);
      lives--;
    }
  }
  
  // Mostrar puntuación y vidas
  fill(255);
  textSize(24);
  text("Puntuación: " + score, 10, 30);
  text("Vidas: " + lives, 10, 60);
  
  // Generar nuevas notas aleatoriamente
  if (random(1) < 0.02) {
    int lane = floor(random(4));
    notes.add(new Note(200 + lane * 100, 0));
  }
}

void keyPressed() {
  if (key == 'a' || key == 's' || key == 'd' || key == 'f') {
    int lane = key == 'a' ? 0 : key == 's' ? 1 : key == 'd' ? 2 : 3;
    checkHit(lane);
  }
}

void checkHit(int lane) {
  for (Note note : notes) {
    if (note.lane == lane && note.y > height - 100 && note.y < height - 50) {
      score += 10;
      notes.remove(note);
      break;
    }
  }
}

class Note {
  float x, y;
  int lane;
  
  Note(float x, float y) {
    this.x = x;
    this.y = y;
    this.lane = floor((x - 200) / 100);
  }
  
  void update() {
    y += 5;  // Velocidad de caída
  }
  
  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 50, 50);
  }
}
