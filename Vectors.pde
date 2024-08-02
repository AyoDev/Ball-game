class Vec2 {
  float r;
  float angle;
  
  public Vec2(float r, float angle) {
    this.r = r;
    this.angle = angle;
  }
}

class Coord {
 float x;
 float y;
 
 public Coord(float x, float y) {
   this.x = x;
   this.y = y;
 }
}

class Ray {
  
  float x;
  float y;
  float angle;
  
  public Ray(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  public Ray(float x1, float y1, float x2, float y2) {
    this(x1, y1, atan2(y2 - y1, x2 - x1));
  }
  
}

float project(Vec2 src, Vec2 screen) {
  Vec2 rotSrc = new Vec2(src.r, src.angle - screen.angle);
  return rotSrc.r * cos(rotSrc.angle);
}

float project(Vec2 src, Ray screen) {
  Vec2 rotSrc = new Vec2(src.r, src.angle - screen.angle);
  return rotSrc.r * cos(rotSrc.angle);
}

float project(float x, float y, Ray screen) {
  return project(toVec2(x, y), screen);
}

float absProject(float x, float y, Ray screen) {
  return abs(project(toVec2(x, y), screen));
}

float absProject(Vec2 v, Ray screen) {
  return abs(project(v, screen));
}

Vec2 toVec2(float x, float y) {
  return new Vec2(sqrt(x * x + y * y), atan2(y, x));
}

Vec2 toVec2(Coord c) {
  return new Vec2(sqrt(c.x * c.x + c.y * c.y), atan2(c.y, c.x));
}
