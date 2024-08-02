class Block {
 Colour colour;
 float elasticity = 0.9; //0.8
 Rect r;
 float angle;
 boolean bouncer;
 
 public Block(float x, float y, float angle) {
   r = new Rect(x, y, 50, 30);
   this.angle = angle;
 }
 
}

Block newBlock(float x, float y, float angle) {
  Block p = new Block(x, y, angle);
  p.colour = yellowImpass;
  p.bouncer = false;
  return p;
}

Block newBlockBouncer(float x, float y, float angle) {
  Block p = new Block(x, y, angle);
  p.colour = bouncerPurple;
  p.elasticity = 1.4;
  p.bouncer = true;
  return p;
}
