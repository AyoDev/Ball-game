World world;
long lastTime;
long t0;
long winTicks = 0;

void drawlvl(World world) {
  background(lime.r, lime.g, lime.b);

  long time = millis() - t0;
  long lastTime2 = lastTime;
  long stepper = 5; //5 achieves stable whereas 15 doesn't.
  while (time - lastTime >= stepper) {
    lastTime += stepper;

    if (mode == Mode.PLAY) {
      physics(world, stepper);
    } else if (mode == Mode.BUILD) {
      world.ball.c.x = world.initX;
      world.ball.c.y = world.initY;
      world.ball.v = 0;
    }
  }

  renderFX(world, lastTime - lastTime2);
  renderWorld(world);
  drawBorder();
  renderMode();

  if (mode == Mode.WIN) {
    winTicks += lastTime - lastTime2;
    if (winTicks > 1000) {
      long delta = winTicks - 1000;
      renderWin(min(200, ((float) delta) / 10));
    }
  }
}

void renderWorld(World w) {
  stroke(0);
  strokeWeight(1);
  setColour(ballRed);
  ellipseMode(CENTER);
  Circle c = w.ball.c;
  ellipse(c.x, toY(c.y), 2 * c.r, 2 * c.r);
  
  setColour(ballRed);
  Rect r = w.goal.rect;
  translate(r.x, toY(r.y));
  rotate(-w.goal.angle);
  rectMode(CENTER);
  rect(0, 0, r.halfWidth * 2, r.halfHeight * 2);
  resetMatrix();

  stroke(0,200,0);
  translate(w.ball.c.x, toY(w.ball.c.y));
  rotate(-w.ball.angle);
  strokeWeight(5);
  line(0, 0, 50, 0);
  resetMatrix();
  strokeWeight(1);
  stroke(0);

  ellipseMode(CENTER);
  for (Peg p : w.placed) {
    setColour(p.colour);
    ellipse(p.c.x, toY(p.c.y), 2 * p.c.r, 2 * p.c.r);
  }

  if (mode == Mode.BUILD) {
    setColour(pegBlue);
    textSize(60);
    text("Pegs left: " + w.pegsLeft, 100,100);
  }
}

void setColour(Colour c) {
  fill(c.r, c.g, c.b);
}

float toY(float y) {
   return height - y;
}

void drawSelector(World w) {
   if (shifted) {
     int index = nearestPegIndex(w, mouseX, toY(mouseY));
     if (index != -1) {
       Peg p = w.placed.get(index);
       strokeWeight(2);
       stroke(removerRed.r, removerRed.g, removerRed.b, 100);
       line(mouseX, mouseY, p.c.x, toY(p.c.y));
       noStroke();
       fill(removerRed.r, removerRed.g, removerRed.b, 100);
       circle(p.c.x, toY(p.c.y), 60);
     }
   } else {
    if (!canPlacePeg(mouseX, toY(mouseY))) {
      stroke(255, 0, 0);
      strokeWeight(4);
      int xSmall = mouseX - 25;
      int xLarge = mouseX + 25;
      int ySmall = mouseY - 25;
      int yLarge = mouseY + 25;
      line(xSmall, ySmall, xLarge, yLarge);
      line(xSmall, yLarge, xLarge, ySmall);
      stroke(0);
      strokeWeight(1);
    }
    fill(pegBlue.r, pegBlue.g, pegBlue.b, 95);
      circle(mouseX, mouseY, 48);
      fill(pegBlue.r, pegBlue.g, pegBlue.b, 50);
      noStroke();
      circle(mouseX, mouseY, 60);
      stroke(0);
   }
}

boolean canPlacePeg(float x, float y) {
  if (!(world.pegsLeft > 0)) {
    return false;
  }

  float bdx = x - world.ball.c.x;
  float bdy = y - world.ball.c.y;
  float deltaBall = sqrt(bdx * bdx + bdy * bdy);
  if (deltaBall <= 24 + 30) {
    return false;
  }

  float minDelta = 48;
  for (Peg p : world.placed) {
    float dx = x - p.c.x;
    float dy = y - p.c.y;
    float dist = sqrt(dx * dx + dy * dy);
    if (dist <= minDelta) {
      return false;
    }
  }
  return true;
}

void renderFX(World w, long millis) {
  noStroke();
  for (Effect2 ef2 : w.fx) {
    ef2.progress += millis;
    ef2.ef.effect(ef2.progress, ef2.target);
  }

  ArrayList<Effect2> toRemove = new ArrayList<Effect2>();
  for (Effect2 ef2 : w.fx) {
    if (ef2.progress > ef2.target) {
      toRemove.add(ef2);
    }
  }

  for (Effect2 ef2 : toRemove) {
    w.fx.remove(ef2);
  }

  stroke(0);
}

void drawBorder() {
  int delta = 25;
  noStroke();
  fill(borderBrown2.r, borderBrown2.g, borderBrown2.b);
  rectMode(CORNER);
  rect(0, 0, width, delta);
  rect(0, 0, delta, height);
  rect(0, height - delta, width, delta);
  rect(width - delta, 0, delta, height);

  strokeWeight(20);
  stroke(borderBrown.r, borderBrown.g, borderBrown.b);

  line(delta, delta, width - delta, delta);
  line(delta, height - delta, width - delta, height - delta);
  line(delta, delta, delta, height - delta);
  line(width - delta, delta, width - delta, height - delta);

  strokeWeight(1);
  stroke(0);
}

void renderWin(float opacity) {
  int textDx = 400;
  int borderDelta = 75;
  
  fill(offwhite.r, offwhite.g, offwhite.b, opacity);
  rectMode(CORNER);
  rect(width/2 - textDx - borderDelta, height/2 - 100 - borderDelta, 1000, 400);

  fill(0);
  textSize(80);
  text("You won!", width/2 - textDx,height/2 - 100);
  textSize(60);
  text("Press Enter to go to next level", width/2 - textDx,height/2 + 100);
  text("Press Backspace to return to menu", width/2 - textDx,height/2 + 170);
}

void renderMode() {
  setColour(ballRed);
  textSize(60);
  text(mode.toString(), width - 300,100);
}

void drawBeatGame() {
  background(lime.r, lime.g, lime.b);
  fill(0);
  textSize(80);
  text("You beat the game  :)", width/2 - 300,height/2 - 100);
}
