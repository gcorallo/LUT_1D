//1 dimensinal Lut test

PImage img;

float[] lutR=new float[32];
float[] lutG=new float[32];
float[] lutB=new float[32];
boolean ready=false;
void setup() {
  size(800, 300);
  img=loadImage("patitos.jpg");


  background(0);
  float inc=0;
  for (int i=0;i<32;i++) {
    inc+=.1;
    
    lutR[i]=i*10+noise(inc)*200;
     lutG[i]=(1-cos(i/12.0f))*200;
     lutB[i]=(1-sin(i/8.0f))*200;
     
     /*
    lutR[i]=sin(i/5.0f)*200;
    lutG[i]=sin(i/8.0f)*200;
    lutB[i]=sin(i/10.0f)*200;
    */
  }



  noLoop();
}


void draw() {

  image(img, 0, 0); 
  img.loadPixels();   

  for (int i=0;i<img.pixels.length;i++) {
    color c=img.pixels[i];

    int rc=(int)red(c);
    int gc=(int)green(c);
    int bc=(int)blue(c);     

    int ri=rc*32/256;
    int rs=ri+1;
    float x1=ri*256/32.0f;
    float x2=rs*256/32.0f;
    float y1=lutR[ri];
    float y2=lutR[rs];
    rc=int((rc-x1)*(y2-y1)/(x2-x1)+y1);  

    int gi=gc*32/256;
    int gs=gi+1;
     x1=gi*256/32.0f;
     x2=gs*256/32.0f;
     y1=lutG[gi];
     y2=lutG[gs];
    gc=int((gc-x1)*(y2-y1)/(x2-x1)+y1);  

    int bi=bc*32/256;
    int bs=bi+1;
     x1=bi*256/32.0f;
     x2=bs*256/32.0f;
     y1=lutB[bi];
     y2=lutB[bs];
    rc=int((bc-x1)*(y2-y1)/(x2-x1)+y1);  

    img.pixels[i]=color(rc, gc, bc);
  }
  img.updatePixels(); 
  image(img, width/2, 0);  

  fill(0, 150);
  rect(width-127, 200, 127, 127); 
  for (int i=0;i<256;i++) {
    int ind=i*32/256; 

    fill(255, 0, 0);
    noStroke();
    ellipse(width-127+i/2, 250+lutR[ind]/8, 2, 2);

    fill(0, 255, 0);
    noStroke();
    ellipse(width-127+i/2, 250+lutG[ind]/8, 2, 2);

    fill(0, 0, 255);
    noStroke();
    ellipse(width-127+i/2, 250+lutB[ind]/8, 2, 2);
  }
}



void keyPressed() {
  if (key==' ') {
    saveFrame();
  }
}

