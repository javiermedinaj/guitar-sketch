import processing.video.*;
//import processing.sound.*;

class Game {
  PApplet p;
  ArrayList<Note> notes;
  int score;
  int lives;
  Movie backgroundVideo;
  //SoundFile hitSound;
  String[] lyrics;
  int currentLyricIndex;
  float lyricTimer;
  boolean isShaking;
  float shakeAmount;

  Game(PApplet p) {
    this.p = p;
    notes = new ArrayList<Note>();
    score = 0;
    lives = 3;
    
    // Cargar video de fondo
    backgroundVideo = new Movie(p, "bgvideo.mp4");
    backgroundVideo.loop(); // Reproducir en bucle

    // Cargar sonido
    //hitSound = new SoundFile(p, "sound_effect.mp3");
    
    isShaking = false;
    shakeAmount = 0;
  }

  void update() {
    // Actualizar el video de fondo
    if (backgroundVideo.available()) {
      backgroundVideo.read();
    }
    p.image(backgroundVideo, 0, 0, p.width, p.height);

    // Aplicar efecto de vibración
    if (isShaking) {
      p.translate(p.random(-shakeAmount, shakeAmount), p.random(-shakeAmount, shakeAmount));
      shakeAmount *= 0.9; // Reducir la vibración gradualmente
      if (shakeAmount < 0.1) {
        isShaking = false;
      }
    }
    
    // Dibujar "cuerdas"
    for (int i = 0; i < 4; i++) {
      p.stroke(255);
      p.line(200 + i * 100, 0, 200 + i * 100, p.height);
    }
    
    // Dibujar zona de impacto
    p.stroke(255, 255, 0);
    p.line(0, p.height - 100, p.width, p.height - 100);
    
    // Actualizar y dibujar notas
    for (int i = notes.size() - 1; i >= 0; i--) {
      Note note = notes.get(i);
      note.update();
      note.display();
      
      if (note.y > p.height) {
        notes.remove(i);
        lives--;
        shakeScreen();
      }
    }
    
    // Mostrar puntuación
    p.fill(255);
    p.textSize(24);
    p.text("Puntuación: " + score, 10, 30);
    
  
    
    // Generar nuevas notas aleatoriamente
    if (p.random(1) < 0.02) {
      int lane = p.floor(p.random(4));
      notes.add(new Note(200 + lane * 100, 0, p));
    }
  }

  void checkHit(int lane) {
    boolean hit = false;
    for (int i = notes.size() - 1; i >= 0; i--) {
      Note note = notes.get(i);
      if (note.isHit(lane)) {
        score += 10;
        notes.remove(i);
        hit = true;
        //hitSound.play();
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
}
