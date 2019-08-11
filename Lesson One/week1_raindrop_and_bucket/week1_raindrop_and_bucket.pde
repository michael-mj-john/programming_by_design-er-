/* Coding example: Programming by Design(er)
Michael John mbjohn@ucsc.edu 2019
free to use with or without attribution (CC0 license) */

/* 
A lot of concepts are put forward in this code sample, including:
 - variables
 - Basic animation of an object
 - a version of collision
 - boolean logic
 - user-defined types (classes)
 - drawing a non-primitive shape.
 
 The primary emphasis is on logic. For objects going offscreen, and for collision, having logic tests 
 is both sensible and crucial. 
*/


float dropX;
float dropY;

float dropSpeed; 

float dropRadius;
float dropHeight;

// the bucket is a trapezoidal shape, and to draw that we use Processing's 'PShape'
// While a rectangle would make a perfectly good bucket, this was an early introduction
// to a user-defined type. 
PShape bucket;

float bucketBottom = 80;
float bucketTop = 100;
float bucketHeight = 60;
float bucketX;
// this var is part of the 'bonus content' you'll see in the draw() loop
float bucketDrag = 30;

void setup() {
     
     size( 700, 600 );
     noStroke();
    
     // This is setting up a circular "raindrop"
     dropRadius = 30;
     dropX = width/2;
     dropY = 0;
     
     bucketX = width/2;
     
     frameRate(60);   
     dropSpeed = 3;
     
     // bucket as PShape object
     // PShapes are drawn as a series of vertices, which can be hard to follow
       bucket = createShape();
       bucket.beginShape();
       bucket.fill(0, 0, 0);
       bucket.noStroke();
       bucket.vertex(-bucketTop/2, 0);
       bucket.vertex(bucketTop/2, 0);
       bucket.vertex(bucketBottom/2, bucketHeight);
       bucket.vertex(-bucketBottom/2, bucketHeight);
       bucket.endShape(CLOSE);
}

void draw() {
     
     // for those that didn't pick this up in the first assignment, including 'background()' in the draw loop
     // is very important to them understanding how animation works. 
     background(128);
     
     // draw the raindrop!
     fill( 20, 20, 255 );
     ellipse( dropX, dropY, dropRadius, dropRadius );
     
     // bonus content: this gives the bucket a "loose" feel just for fun
     // it was added during class at student request.
     // to try it, uncomment this code, and comment out the line below "bucketX = mouseX"
     //float dx = mouseX - bucketX;
     //bucketX = bucketX + dx/bucketDrag;

     //move the bucket with the mouse
     bucketX = mouseX;
     
     // shape is the Processing function for drawing PShape. 
     // it *might* be worth going into draw order here. But probably not.
     shape( bucket, bucketX, height-bucketHeight - 3 ); 
     
     // move the drop down by dropSpeed (y incrementing is down the screen)
     dropY += dropSpeed;
     
     // the compound if() test looks for whether the drop is at the necessary Y value (the first test)
     // then tests to see if it's inside the boundaries of the bucket, using bucketX and the half-width
     // of the bucket's top. A good exercise would be to first fail to divide bucket by two, and show how 
     // that produces faulty collision. A quick drawing reveals why (because it's being measured from the middle)
     if( dropY > height - bucketHeight && 
          dropX < bucketX + bucketTop / 2 && 
          dropX > bucketX - bucketTop / 2 ) {
          println("point!");
          dropSpeed += 0.5; // speeds up the drop every time the player succeeds
          // reset to the top of the screen...
          dropY = 0; 
          // ... in a random x location 
          dropX = random( 0 , width); 
          // the above line was later modified as follows, to avoid spawning half off-screen:
          // making this mod live is a good demonstration of how game software (or any software)
          // is first blocked out and made functional, then improved. (rather than trying to write it
          // "perfectly to spec" the first time)
          // dropX = random( 0 + dropRadius, width - dropRadius); 
     }
     
     // test to see if the drop has passed off the bottom of the screen.
     if( dropY > height ) { 
          // same reset as above. This would be a good opportunity for a function but... 
          // ... we haven't talked about functions yet.
          dropY = 0; dropX = random( 0, width ); 
          println("missed...");
     }     
     
}
