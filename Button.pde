class Button {
  float x;
  float y;
  float width;
  float height;
  int i;
  boolean pressed;
  String text;

  Button(float x,float y,float w,float h){
    this.x =x;
    this.y = y;
    this.width = w;
    this.height = h;
  }

  void show(){
    fill(255);
    rect(x,y,width, height);
    fill(100,100,220);
    textSize(20);
    text(text,x,y,width,height);
  }
  boolean mouseOver() {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
