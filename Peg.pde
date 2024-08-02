class Peg {
 Colour colour;
 float elasticity = 0.85; //0.8
 Circle c;
 boolean removable;
 boolean bouncer;
 
 public Peg(float x, float y) {
   c = new Circle(x, y, 24);
 }
 
}

Peg newPeg(float x, float y) {
  Peg p = new Peg(x, y);
  p.colour = pegBlue;
  p.removable = true;
  p.bouncer = false;
  return p;
}

Peg newImpass(float x, float y) {
  Peg p = new Peg(x, y);
  p.colour = yellowImpass;
  p.removable = false;
  p.bouncer = false;
  return p;
}

Peg newBouncer(float x, float y) {
  Peg p = new Peg(x, y);
  p.colour = bouncerPurple;
  p.elasticity = 1.4;
  p.bouncer = true;
  return p;
}
