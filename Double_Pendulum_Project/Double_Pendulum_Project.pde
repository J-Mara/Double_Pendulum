import java.util.*;
boolean play = false;
boolean pend2 = false;
float x2tem = 0;
float y2tem = 0;
float pinx = 210;
float piny = 210;
float grav = 15;
float mass1 = 1;
float mass2 = 1;
float length = 100.0;
float start_angle = 120.0;
float start_angle2 = 60.0;
float ang_veloc = 0;
float ang_veloc2 = 0;
double ang = Math.toRadians(start_angle);
double ang2 = Math.toRadians(start_angle2);
float start_angle01 = 120.0;
float start_angle02 = 60.1;
float ang_veloc01 = 0;
float ang_veloc02 = 0;
double ang01 = Math.toRadians(start_angle01);
double ang02 = Math.toRadians(start_angle02);
float ken = 0;
float potential = 0;
float x2p = 0;
float y2p = 0;
float x3p = 0;
float y3p = 0;
float xtem = (float) ((float) (pinx + length * Math.sin(ang)) + length * Math.sin(ang2));
float ytem = (float) ((float) (piny + length * Math.cos(ang)) + length * Math.cos(ang2));
float xtem1 = (float) (pinx + length * Math.sin(ang));
float ytem1 = (float) (piny + length * Math.cos(ang));
float xtem2 = (float) ((float) (pinx + length * Math.sin(ang01)) + length * Math.sin(ang02));
float ytem2 = (float) ((float) (piny + length * Math.cos(ang01)) + length * Math.cos(ang02));
float xtem12 = (float) (pinx + length * Math.sin(ang01));
float ytem12 = (float) (piny + length * Math.cos(ang01));
float dt = 0.1;

//-------
// Phase space diagram stuff

float plot_L = 200;
float prev_x = (float)((Math.sin(ang)) + Math.sin(ang2))*0.5*plot_L;
float prev_y = 650 - 0.5*plot_L;

void setup(){
  frameRate(120);
  size(1000, 700);
  background(150);
}

void pend3(){
  fill(150,150,150,225);
  rect(-1, -1, 2*length+pinx+20, 701);
  //background(200);
  float x2 = (float) (pinx + length * Math.sin(ang));
  float y2 = (float) (piny + length * Math.cos(ang));
  float x3 = (float) (x2 + length * Math.sin(ang2));
  float y3 = (float) (y2 + length * Math.cos(ang2));
  fill(255);
  stroke(0);
  strokeWeight(1);
  line(pinx, piny, x2, y2);
  line(x2, y2, x3, y3);
  ellipse(x2, y2, 10.0, 10.0); 
  ellipse(x3, y3, 10.0, 10.0);
  
  ken = 0.5*(0.5*(mass1*ang_veloc*ang_veloc*length*length) + 0.5*(mass2*(length*length*ang_veloc*ang_veloc + 
  length*length*ang_veloc2*ang_veloc2 + 2*length*length*ang_veloc*ang_veloc2*(float)Math.cos(ang-ang2))));
  potential = grav*(0.5*(mass1*(piny+length-y2)) + 0.5*(mass2*(piny+2*length-y3)));
  //println("kenetic: " + ken + ", potential: " + potential + ", total: " + (potential+ken));
  
  if(pend2){
    float xp2 = (float) (pinx + length * Math.sin(ang01));
    float yp2 = (float) (piny + length * Math.cos(ang01));
    float xp3 = (float) (xp2 + length * Math.sin(ang02));
    float yp3 = (float) (yp2 + length * Math.cos(ang02));
    fill(0);
    stroke(0);
    strokeWeight(1);
    line(pinx, piny, xp2, yp2);
    line(xp2, yp2, xp3, yp3);
    ellipse(xp2, yp2, 10.0, 10.0); 
    ellipse(xp3, yp3, 10.0, 10.0);
    fill(255);
    if(play){
      stroke(0);
      line(2*length+10+pinx+xtem2, ytem2, 2*length+10+pinx+xp3, yp3);
      line(2*length+10+pinx+xtem12, ytem12, 2*length+10+pinx+xp2, yp2);
      move02();
    }
    xtem2 = xp3;
    ytem2 = yp3;
    xtem12 = xp2;
    ytem12 = yp2;
  }
  if(play){
    stroke(255);
    line(2*length+10+pinx+xtem, ytem, 2*length+10+pinx+x3, y3);
    line(2*length+10+pinx+xtem1, ytem1, 2*length+10+pinx+x2, y2);
    stroke(0);
    move2();
  }
  xtem = x3;
  ytem = y3;
  xtem1 = x2;
  ytem1 = y2;
  rect(350,20,10,ken);
  rect(365,20,10,potential);
  rect(380, 20, 10, ken+potential);
  if(!play){
    rect(500, 20, 200, 50);
    rect(500, 75, 275, 50);
    rect(500, 130, 200, 50);
    rect(500, 180, 200, 20);
    rect(500, 205, 200, 50);
    rect(500, 255, 200, 20);
    if(pend2){
      rect(720, 130, 200, 50);
      rect(720, 180, 200, 20);
      rect(720, 205, 200, 50);
      rect(720, 255, 200, 20);
    }
    fill(0);
    textSize(20);
    text("Start simulation", 510, 50);
    text("Toggle second pendulum", 510, 105);
    text("Angle 1: " + (int)Math.toDegrees(ang), 510, 160);
    text("Angle 2: " + (int)Math.toDegrees(ang2), 510, 235);
    if(pend2){
      text("Angle 1: " + (int)Math.toDegrees(ang01), 730, 160);
      text("Angle 2: " + (int)Math.toDegrees(ang02), 730, 235);
    }
    else{
      stroke(150);
      fill(150);
      rect(719, 129, 300, 400);
    }
  }
}

void mousePressed(){
  if(!play){
    if(mouseButton == LEFT){
      if(mouseX >= 500 && mouseX <= 700 && mouseY >= 20 && mouseY <= 70){
        play = true;
        background(150);
      }
    }
  }
  if(!play){
    if(mouseButton == LEFT){
      if(mouseX >= 500 && mouseX <= 700 && mouseY >= 180 && mouseY <= 200){
        ang = Math.toRadians(1.8*(mouseX - 600));
      }
    }
  }
  if(!play){
    if(mouseButton == LEFT){
      if(mouseX >= 500 && mouseX <= 700 && mouseY >= 255 && mouseY <= 275){
        ang2 = Math.toRadians(1.8*(mouseX - 600));
      }
    }
  }
  if(pend2){
    if(!play){
      if(mouseButton == LEFT){
        if(mouseX >= 720 && mouseX <= 920 && mouseY >= 180 && mouseY <= 200){
          ang01 = Math.toRadians(1.8*(mouseX - 820));
        }
      }
    }
    if(!play){
      if(mouseButton == LEFT){
        if(mouseX >= 720 && mouseX <= 920 && mouseY >= 255 && mouseY <= 275){
          ang02 = Math.toRadians(1.8*(mouseX - 820));
        }
      }
    }
  }
  if(mouseButton == LEFT && !play){
    if(mouseX >= 500 && mouseX <= 775 && mouseY >= 75 && mouseY <= 125){
      pend2 = !pend2;
    }
  }
}

void move2(){
  float denom = (length*(2*mass1+mass2-mass2*(float)Math.cos(2*ang-2*ang2)));
  
  float ang_acc1 = (-1*grav*(2*mass1+mass2)*(float)Math.sin(ang) - 
  grav*mass2*(float)Math.sin(ang-2*ang2) - 
  2*(float)Math.sin(ang-ang2)*mass2*(ang_veloc2*ang_veloc2*length+ang_veloc*ang_veloc*length*(float)Math.cos(ang-ang2))) / 
  denom;
  
  float ang_acc2 = (2*(float)Math.sin(ang-ang2)*(ang_veloc*ang_veloc*length*(mass1+mass2) + 
  grav*(mass1+mass2)*(float)Math.cos(ang) + ang_veloc2*ang_veloc2*length*mass2*(float)Math.cos(ang-ang2))) / 
  denom;
  
  float vtover21 = ang_veloc + 0.5*ang_acc1*dt;
  float vtover22 = ang_veloc2 + 0.5*ang_acc2*dt;
  float angt = (float)ang + vtover21*dt;
  float angt2 = (float)ang2 + vtover22*dt;
  float at1 = get_acc1(angt, angt2, vtover21, vtover22);
  float at2 = get_acc2(angt, angt2, vtover21, vtover22);
  ang_veloc = vtover21 + 0.5*at1*dt;
  ang_veloc2 = vtover22 + 0.5*at2*dt;
  ang = angt;
  ang2 = angt2;
  
  if(ang >= 2*Math.PI) {
    ang = ang % (2*Math.PI);
  }
  if(ang2 >= 2*Math.PI) {
    ang2 = ang2 % (2*Math.PI);
  }
}

float get_acc1(float x1, float x2, float v1, float v2){
  float denom = (length*(2*mass1+mass2-mass2*(float)Math.cos(2*x1-2*x2)));
  
  float ang_acc1 = (-1*grav*(2*mass1+mass2)*(float)Math.sin(x1) - 
  grav*mass2*(float)Math.sin(x1-2*x2) - 
  2*(float)Math.sin(x1-x2)*mass2*(v2*v2*length+v1*v1*length*(float)Math.cos(x1-x2))) / 
  denom;
  
  return ang_acc1;
}

float get_acc2(float x1, float x2, float v1, float v2){
  float denom = (length*(2*mass1+mass2-mass2*(float)Math.cos(2*x1-2*x2)));
  
  float ang_acc2 = (2*(float)Math.sin(x1-x2)*(v1*v1*length*(mass1+mass2) + 
  grav*(mass1+mass2)*(float)Math.cos(x1) + v2*v2*length*mass2*(float)Math.cos(x1-x2))) / 
  denom;
  
  return ang_acc2;
}

void move02(){
  float denom = (length*(2*mass1+mass2-mass2*(float)Math.cos(2*ang01-2*ang02)));
  
  float ang_acc01 = (-1*grav*(2*mass1+mass2)*(float)Math.sin(ang01) - 
  grav*mass2*(float)Math.sin(ang01-2*ang02) - 
  2*(float)Math.sin(ang01-ang02)*mass2*(ang_veloc02*ang_veloc02*length+ang_veloc01*ang_veloc01*length*(float)Math.cos(ang01-ang02))) / 
  denom;
  
  float ang_acc02 = (2*(float)Math.sin(ang01-ang02)*(ang_veloc01*ang_veloc01*length*(mass1+mass2) + 
  grav*(mass1+mass2)*(float)Math.cos(ang01) + ang_veloc02*ang_veloc02*length*mass2*(float)Math.cos(ang01-ang02))) / 
  denom;
  
  float vtover21 = ang_veloc01 + 0.5*ang_acc01*dt;
  float vtover22 = ang_veloc02 + 0.5*ang_acc02*dt;
  float angt = (float)ang01 + vtover21*dt;
  float angt2 = (float)ang02 + vtover22*dt;
  float at1 = get_acc1(angt, angt2, vtover21, vtover22);
  float at2 = get_acc2(angt, angt2, vtover21, vtover22);
  ang_veloc01 = vtover21 + 0.5*at1*dt;
  ang_veloc02 = vtover22 + 0.5*at2*dt;
  ang01 = angt;
  ang02 = angt2;
  
  if(ang01 >= 2*Math.PI) {
    ang01 = ang01 % (2*Math.PI);
  }
  if(ang02 >= 2*Math.PI) {
    ang02 = ang02 % (2*Math.PI);
  }
}

void phase(){
  line(500, 650, 500+plot_L, 650);
  line(500, 650, 500, 650-plot_L);
  if(play){
    line(prev_x, prev_y, (float)((Math.sin(ang)) + Math.sin(ang2))*0.25*plot_L + 500 + 0.5*plot_L, 600 - 0.5*plot_L*(ang_veloc2));
  }
  prev_x = (float)((Math.sin(ang)) + Math.sin(ang2))*0.25*plot_L + 500 + 0.5*plot_L;
  prev_y = 600 - 0.5*plot_L*(ang_veloc2);
}

void draw(){
  pend3();
  phase();
}
