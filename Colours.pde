class Colour {
 int r;
 int g;
 int b;
 
 Colour(int x, int y, int z) {
   r = x;
   g = y;
   b = z;
 }
}

Colour lime = new Colour(152,190,100);
Colour ballRed = new Colour(255,50,71);
Colour pegBlue = new Colour(119, 131, 255);
Colour bouncerPurple = new Colour(175, 96, 255);
Colour yellowImpass = new Colour(255, 190, 12);
Colour removerRed = new Colour(186, 57, 106);
Colour borderBrown = new Colour(178, 102, 85);
Colour borderBrown2 = new Colour(168, 150, 148);
Colour offwhite = new Colour(244, 220, 220);
Colour offwhite2 = new Colour(255, 243, 234);

void background(Colour col){
  background(col.r,col.g,col.b);
}
