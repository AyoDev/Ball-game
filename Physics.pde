float terminalV = 1.8; //0.7 //3 //1 has weird cool effects //0.7 is stable but boring

void physics(World w, long millis) {
  gravity(w.ball, millis);
  w.ball.c.x += w.ball.v * cos(w.ball.angle) * millis;
  w.ball.c.y += w.ball.v * sin(w.ball.angle) * millis;
  for (Peg p : w.placed) {
     float depth = circCirc(w.ball, p);
     if (depth > 0) {

       Vec2 v = new Vec2(w.ball.v, w.ball.angle);
       
       float dx = p.c.x - w.ball.c.x;
       float dy = p.c.y - w.ball.c.y;
       
       Vec2 axis = toVec2(dx, dy);
       float vParr = projectX(new Vec2(v.r, v.angle - axis.angle));
       float vPerp = projectY(new Vec2(v.r, v.angle - axis.angle));
       vParr *= -p.elasticity;
       vParr = constrain(vParr, -terminalV, terminalV); //this is technically an upper bound rather than required value - if vPerp was large this would be bad
       Vec2 newV = toVec2(vParr, vPerp);
       newV.angle += axis.angle;
       w.ball.v = newV.r;
       w.ball.angle = newV.angle;
       
       float correctionDelta = 0.1; //0.1
       depth += correctionDelta;
       w.ball.c.x += depth * cos(w.ball.angle);
       w.ball.c.y += depth * sin(w.ball.angle);

      if(p.bouncer) {
        Effect ef = (prog, target) -> bounce(p.c.x, p.c.y, prog, target);
        Effect2 ef2 = new Effect2(ef, 0, 200);
        w.fx.add(ef2);
      } else {
        Effect ef = (prog, target) -> collideEffect(p.c.x, p.c.y, p.colour, prog, target);
        Effect2 ef2 = new Effect2(ef, 0, 170);
        w.fx.add(ef2);
      }
     }
  }

  if (circRect(w.ball.c, w.goal.rect, w.goal.angle)) {
        //GAME ENDS
        Effect e = (prog, target) -> win2(w.ball.c.x, w.ball.c.y, prog, target);
        Effect2 e2 = new Effect2(e, 0, 1000);

        Effect ef = (prog, target) -> win(w.ball.c.x, w.ball.c.y, prog, target);
        Effect2 ef2 = new Effect2(ef, 0, 5000);
        w.fx.add(e2);
        w.fx.add(ef2);
        mode = Mode.WIN;

        //Button b = new Button(600,800,50,50);
        //b.text = "Next Level";
        //b.show();
     }

     if (w.ball.c.y < -300) {
      mode = Mode.BUILD;
     }
}

Circle resolveCircRect(Circle c, Rect r, float angle) {
  if (circRect(c, r, angle)) {
    Circle c2 = aboutRect(c, r, angle);
    float dx = c2.x;
    float dy = c2.y;
    if (abs(dx) >= abs(dy)) {
      c2.y = -r.halfHeight * Math.signum(dy);
    } else {
      c2.x = -r.halfWidth * Math.signum(dx);
    }
    return revertFromRect(c2, r, angle);
  } else {
    return c;
  }
}

void gravity(Ball b, long millis) {
  float GRAVITY = 0.0009; //-0.01 //0.003 //0.001 0.00085 might be nice
  float vx = b.v * cos(b.angle);
  float vy = b.v * sin(b.angle);
  vy -= GRAVITY * millis;
  b.v = sqrt(vx * vx + vy * vy);
  b.angle = atan2(vy, vx);
  double toRemove = 0.005 / 15;
  toRemove *= millis;
  b.v *= 1 - toRemove; //standard is calibrated for every 15ms
  b.v = constrain(b.v, -terminalV, terminalV);
}

float projectX(Vec2 v) {
  return v.r * cos(v.angle);
}

float projectY(Vec2 v) {
  return v.r * sin(v.angle);
}
