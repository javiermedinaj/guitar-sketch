ArrayList<Note> notes;
int score;
int lives;
PImage background;
String[] lyrics;
int currentLyricIndex;
float lyricTimer;
boolean isShaking;
float shakeAmount;

void setup() {
  size(800, 600);
  notes = new ArrayList<Note>();
  score = 0;
  lives = 3;
  
  // Cargar fondo
  background = loadImage("background.jpg"); // Asegúrate de tener esta imagen en tu carpeta de datos
  
  // Inicializar letras
  lyrics = new String[] {
    "Cuando el mundo te quiere hacer caer",
    "Hay que levantarse y volver a creer",
    "La música te da la fuerza para continuar",
    "¡Sigue el ritmo y nunca dejes de soñar!"
  };
  currentLyricIndex = 0;
  lyricTimer = 0;
  
  isShaking = false;
  shakeAmount = 0;
}

void draw() {
  // Aplicar efecto de vibración
  if (isShaking) {
    translate(random(-shakeAmount, shakeAmount), random(-shakeAmount, shakeAmount));
    shakeAmount *= 0.9; // Reducir la vibración gradualmente
    if (shakeAmount < 0.1) {
      isShaking = false;
    }
  }
  
  // Dibujar fondo
  image(background, 0, 0, width, height);
  
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
      shakeScreen();
    }
  }
  
  // Mostrar puntuación y vidas
  fill(255);
  textSize(24);
  text("Puntuación: " + score, 10, 30);
  text("Vidas: " + lives, 10, 60);
  
  // Mostrar letra actual
  textAlign(CENTER, CENTER);
  textSize(28);
  fill(255, 255, 0);
  text(lyrics[currentLyricIndex], width/2, height - 50);
  
  // Actualizar letra
  lyricTimer += 1/frameRate;
  if (lyricTimer > 5) { // Cambiar letra cada 5 segundos
    currentLyricIndex = (currentLyricIndex + 1) % lyrics.length;
    lyricTimer = 0;
  }
  
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
  boolean hit = false;
  for (Note note : notes) {
    if (note.lane == lane && note.y > height - 100 && note.y < height - 50) {
      score += 10;
      notes.remove(note);
      hit = true;
      break;
    }
  }
  if (!hit) {
    shakeScreen();
  }
}

void shakeScreen() {
  isShaking = true;
  shakeAmount = 10;
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
