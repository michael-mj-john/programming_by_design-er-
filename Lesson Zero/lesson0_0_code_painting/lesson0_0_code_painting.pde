/* Coding example: Programming by Design(er)
Michael John mbjohn@ucsc.edu 2019
free to use with or without attribution (CC0 license) */

/* this very simple code is a good start for Processing. For learners who have never typed code before, it's a very gentle introduction */

void setup() {
     size( 400,400 );
     fill( 255,255,255,0);
}

void draw() {    
     ellipse(mouseX, mouseY, 20, 20);    
}

void keyPressed() {
     save("my painting.png");    
}
