import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV cv;
static final int W = 640/2;
static final int H = 480/2;
static final float GAPW = 0.33;
static final float GAPH = 0.33;




void setup(){
    size(W*2, H*2);
    video = new Capture(this, W, H);
    cv = new OpenCV(this, W, H);
    cv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    
    video.start();
}



void draw(){
      pushMatrix();
  scale(-2,2);
  image(video,-W,0);
  popMatrix();
    
    cv.invert();
    scale(2);
    cv.loadImage(video);
    cv.flip(1);

    
//    image(video, 0, 0);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = cv.detect();
    stalk(faces);
//    println(faces.length);
    
    for (int i = 0; i < faces.length; i++) {
//        println(faces[i].x + "," + faces[i].y);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    drawAreas();
}


void drawAreas(){
    stroke(0, 0, 0);
    strokeWeight(1);
    line(W*GAPW,0 ,W*GAPW, H);
    line(W - W*GAPW,0 ,W -W*GAPW, H);
    line(0,H*GAPH ,W, H*GAPH);
    line(0,H - H*GAPH ,W, H -H*GAPH);
}

void stalk(Rectangle[] faces){    
    if(faces.length == 0){
        print("Nenhuma face encontrada");
        return;        
    }
    float pontoX = faces[0].x + faces[0].width/2;
    float pontoY = faces[0].y + faces[0].height/2;
    print(pontoX + " " + pontoY);
    if(pontoX <W*GAPW)
        print("ESQUERDA");
    if(pontoX > W -W*GAPW)
        print("DIREITA");
    if(pontoY > H -H*GAPH)
        print("BAIXO");  
    if(pontoY < H*GAPH)
        print("CIMA");
    
}
void captureEvent(Capture c){
    c.read();
    
}


