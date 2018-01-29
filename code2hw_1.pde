int p1Score;
int p2Score;

boolean p1Up = false;
boolean p1Down = false;
boolean p2Up = false;
boolean p2Down = false;

Ball b;
Paddle p1;
Paddle p2;

void setup() {
  size(1000, 700);
  b = new Ball();
  p1 = new Paddle(0);
  p2 = new Paddle(1);
}

void draw() {
  background(0);

  b.checkCollisionWithPaddle(p1);
  b.checkCollisionWithPaddle(p2);

  b.update();
  b.display();
  p1.update();
  p1.display();
  p2.update();
  p2.display();

  textSize(36);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text(p1Score, width/2 - 100, 50);
  fill(0, 0, 255);
  text(p2Score, width/2 + 100, 50);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2Up = true;
    }
    if (keyCode == DOWN) {
      p2Down = true;
    }
  } else {
    if (key == 'w') {
      p1Up = true;
    }
    if (key == 's') {
      p1Down = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2Up = false;
    }
    if (keyCode == DOWN) {
      p2Down = false;
    }
  } else {
    if (key == 'w') {
      p1Up = false;
    }
    if (key == 's') {
      p1Down = false;
    }
  }
}

class Paddle {
  float x;
  float y;
  float w;
  float h;
  int playerNum;

  Paddle(int whichPlayer) {
    playerNum = whichPlayer;
    if (whichPlayer == 0) {
      x = 30;
      y = height/2;
      w = 20;
      h = 150;
    } else if (whichPlayer == 1) {
      y = height/2;
      w = 20;
      h = 150;
      x = width-30-w;
    }
  }

  void update() {

    if (playerNum == 0) {
      if (p1Up) {
        y-=10;
      } 
      if (p1Down) {
        y+=10;
      }
    }
    if (playerNum == 1) {
      if (p2Up) {
        y-=10;
      } 
      if (p2Down) {
        y+=10;
      }
    }
  }

  void display() {
    rectMode(CORNER);
    fill(255);
    rect(x, y, w, h);
  }
}

class Ball {
  float x;   
  float y;   
  float dx;  
  float dy;  
  float s1;
  float s2;
  float r;
  float g;
  float b;

  Ball() {
    x = width/2;
    y = height/2;
    s1 = 10;
    s2 = 10;
    dx = 10;  
    dy = random(-3, 3);
    r = 255;
    g = 255;
    b = 255;
  }

  void display() {
    noStroke();
    fill(r, g, b);
    rectMode(CENTER);
    ellipse(x, y, s1, s2);
  }

  void update() {
    x += dx;

    if (x < 0 || x > width) {

      if (x < 0) {
        p2Score++;
        background(70, 0, 0);
        s1+=5;
        r-=50;
        g-=50;
      }

      if (x > width) {
        p1Score++;
        background(0, 0, 70);
        s2+=5;
        g-=50;
        b-=50;
      }

      x = width/2;
      y = height/2;
      dx = -dx; 
      dy = random(-3, 3);
    } 

    if (y < 0 || y > height) {
      dy *= -1;
      y += dy;
    } else { 
      y += dy;
    }
  }

  void checkCollisionWithPaddle(Paddle p) {
    if (x > p.x && x < p.x + p.w) {
      if (y > p.y && y < p.y + p.h) {
        dx = -dx;
        dy = random(-10, 10);
        //s2+=5;
        //if(s2 >= 60){
        // s2=10; 
        //}
        background(255);
      }
    }
  }
}