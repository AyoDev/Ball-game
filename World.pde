class World {
 Ball ball;
 float initX;
 float initY;
 Goal goal;
 int pegsLeft;
 ArrayList<Peg> placed;
 ArrayList<Peg> pocket;
 ArrayList<Effect2> fx = new ArrayList<Effect2>();
}

void addPeg(World w, float x, float y) {
  w.placed.add(newImpass(x, y));
}

void addUserPeg(World w, float x, float y) {
  if (w.pegsLeft > 0) {
    w.pegsLeft--;
    w.placed.add(newPeg(x, y));
  }
}

void removeNearestPeg(World w, float x, float y) {
  int minIndex = nearestPegIndex(w, x, y);
  if (minIndex != -1) {
    w.pegsLeft++;
    w.placed.remove(minIndex);
  }
}

int nearestPegIndex(World w, float x, float y) {
  if (!w.placed.isEmpty()) {
    float min = 0;
    int minIndex = -1;
    Peg p = null;
    for (int i = 0; i < w.placed.size(); i++) {
      p = w.placed.get(i);
      if (p.removable) {
        float d = dist(x, y, p.c.x, p.c.y);
        if (minIndex == -1 || d < min) {
          min = d;
          minIndex = i;
        }
      }
    }
    return minIndex;
  }
  return -1;
}

void addBouncer(World w, float x, float y) {
  w.placed.add(newBouncer(x, y));
}
