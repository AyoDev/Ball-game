boolean circRect(Circle c, Rect r, float rectAngle) {
  //first rotate world to have rectangle as axis-aligned.
  //i.e. rotate coordinate system by rectAngle, by using matrix rotation formulae.
  c = aboutRect(c, r, rectAngle);
  r = asCentre(r);

  //previously had a bug just above when wasn't rotating about the new origin.
  //and also rotated in the wrong direction

  Coord closest = rectCircNearest(c, r);
  float dx = closest.x - c.x;
  float dy = closest.y - c.y;
  return sqrt(dx * dx + dy * dy) <= c.r;
}

Rect asCentre(Rect r) {
  return new Rect(0, 0, r.halfWidth, r.halfHeight);
}

Circle aboutRect(Circle c, Rect r, float rectAngle) {
  return new Circle(rotateX(c.x - r.x, c.y - r.y, -rectAngle), rotateY(c.x - r.x, c.y - r.y, -rectAngle), c.r);
}

Circle revertFromRect(Circle c, Rect r, float rectAngle) {
  return new Circle(rotateX(c.x, c.y, rectAngle) + r.x, rotateY(c.x, c.y, rectAngle) + r.y, c.r);
}

float rotateX(float x, float y, float angle) {
  return x * cos(angle) - y * sin(angle);
}

float rotateY(float x, float y, float angle) {
  return x * sin(angle) + y * cos(angle);
}

float circCirc(Ball b, Peg p) {
  float dx = p.c.x - b.c.x;
  float dy = p.c.y - b.c.y;
  
  float penDepth = b.c.r + p.c.r - sqrt(dx * dx + dy * dy);
  return penDepth;
}

Coord nearest(Rect r, Vec2 screen) {
  float[] xs = {r.x - r.halfWidth, r.x + r.halfWidth};
  float[] ys = {r.y - r.halfHeight, r.x + r.halfHeight};
  Coord[] coords = new Coord[4];
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 2; j++) {
      coords[2 * i + j] = new Coord(xs[i], ys[j]);
    }
  }
  
  float max = 0;
  int maxIndex = 0;
  for (int i = 0; i < 4; i++) {
      Vec2 v = toVec2(coords[i]);
      float mag = project(v, screen);
      if (mag >= max) {
        max = mag;
        maxIndex = i;
      }
  }
  
  return coords[maxIndex];
}

Coord rectCircNearest(Circle c, Rect r) { //rectangle is AABB
  float xDir = Math.signum(c.x - r.x);
  float yDir = Math.signum(c.y - r.y);

  if (xDir == 0) {
    xDir = 1;
  }
  if (yDir == 0) {
    yDir = 1;
  }

  //identify rectangle corner closest to circle (implicitly using Voronoi regions)
  float cornerX = r.halfWidth * xDir;
  float cornerY = r.halfHeight * yDir;

  //clamp nearest point to circle as between centre of circle and rectangle corner.
  //first by projecting circle coordinates with rectangle as origin.
  float dx = c.x - r.x;
  float dy = c.y - r.y;

  float finalX = constrain(dx, min(cornerX, 0), max(cornerX, 0));
  float finalY = constrain(dy, min(cornerY, 0), max(cornerY, 0));

  //because r is AABB, the point on r closest to c
  //just minimises delta x and minimises delta y.

  return new Coord(finalX, finalY);
}
