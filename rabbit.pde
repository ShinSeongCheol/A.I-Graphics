import processing.sound.*;
SoundFile file;

PImage rabbitImage;
PImage tree;

float beginY[] = new float[4];  // Initial y-coordinate
float endY[] = new float[4];   // Final y-coordinate
float distY[] = new float[4];          // Y-axis distance to move
float exponent = 6.05;   // Determines the curve
float y[] = new float[4];        // Current y-coordinate
float step = 0.01;    // Size of each step along the path
float pct[] = new float[4];

float testY[] = new float[4];

boolean isHigh[] = new boolean[4];

void setup() {
  size(800, 400);
  rabbitImage = loadImage("https://cdn.pixabay.com/photo/2021/02/21/16/53/bunny-6037010_960_720.png");
  tree = loadImage("https://cdn.pixabay.com/photo/2014/12/22/00/07/tree-576847_960_720.png");

  for (int i=0; i<4; i++) {
    endY[i] = random(400);
    beginY[i] = 400.0;
  }

  file = new SoundFile(this, "C:/Users/cher3/Desktop/Gunfire And Voices.mp3");
}

void grass(int x, int y) {
  fill(0, 255, 0);
  beginShape();
  vertex(0+x, height);
  vertex(20+x, height-50-y);

  vertex(20+x, height-50-y);
  vertex(40+x, height-35);

  vertex(40+x, height-35);
  vertex(60+x, height-80-y);

  vertex(60+x, height-80-y);
  vertex(80+x, height-45);

  vertex(80+x, height-45);
  vertex(90+x, height-50-y);

  vertex(90+x, height-50-y);
  vertex(110+x, height-40);

  vertex(110+x, height-40);
  vertex(130+x, height-60-y);

  vertex(130+x, height-60-y);
  vertex(150+x, height);
  endShape(CLOSE);
}

float targetX[] = new float[4];
float targetY[] = new float[4];

void rabbit(int x, int numY) {
  pct[numY] += step;
  if (pct[numY] < 1.0) {
    distY[numY] = endY[numY] - beginY[numY];
    y[numY] = beginY[numY] + (pow(pct[numY], exponent) * distY[numY]);
    image(rabbitImage, 40+x, y[numY], 80, 80);
    textSize(15);
    fill(255, 0, 0);
    text("answer", 55+x, y[numY]+70);
  } else {
    if (isHigh[numY]) {
      isHigh[numY] = false;
      pct[numY] = 0.0;
      beginY[numY] = y[numY];
      endY[numY] = 400;
      distY[numY] = endY[numY] - beginY[numY];
      image(rabbitImage, 40+x, y[numY], 80, 80);
      textSize(15);
      fill(255, 0, 0);
      text("answer", 55+x, y[numY]+70);
    } else {
      isHigh[numY]=true;
      pct[numY] = 0.0;
      beginY[numY] = 400;
      endY[numY] = random(400);
      distY[numY] = endY[numY] - beginY[numY];
      image(rabbitImage, 40+x, y[numY], 80, 80);
      textSize(15);
      fill(255, 0, 0);
      text("answer", 55+x, y[numY]+70);
    }
  }
  targetX[numY] = 40+x;
  targetY[numY] = y[numY];
}

String answer;

void draw() {
  background(#3B5DFF);
  image(tree, -30, 0, 400, 400);
  System.out.println(answer);

  for (int i=0; i<4; i++) {
    rabbit(i*200, i);
  }

  for (int i=0; i<=width; i+=140) {
    grass(i, 65);
  }
}

void mousePressed() {

  file.play();

  if ((targetX[0]-80 < mouseX && targetX[0]+80 > mouseX) && (targetY[0]-80 < mouseY && targetY[0]+80 > mouseY)) {
    answer = "num1 rabbit";
  }
  if ((targetX[1]-80 < mouseX && targetX[1]+80 > mouseX) && (targetY[1]-80 < mouseY && targetY[1]+80 > mouseY)) {
    answer = "num2 rabbit";
  }
  if ((targetX[2]-80 < mouseX && targetX[2]+80 > mouseX) && (targetY[2]-80 < mouseY && targetY[2]+80 > mouseY)) {
    answer = "num3 rabbit";
  }
  if ((targetX[3]-80 < mouseX && targetX[3]+80 > mouseX) && (targetY[3]-80 < mouseY && targetY[3]+80 > mouseY)) {
    answer = "num4 rabbit";
  }
}
