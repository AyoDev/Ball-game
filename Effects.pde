interface Effect {
    public void effect(long progress, long target);
}

class Effect2 {
    Effect ef;
    long progress;
    long target;

    public Effect2(Effect e, long prog, long targ) {
        ef = e;
        progress = prog;
        target = targ;
    }
}

void bounce(float x, float y, long progress, long target) {
    float finalScale = 90;
    float initScale = 60;
    float ratio = min((float) progress / target, 1);
    float scale = ratio * finalScale + (1 - ratio) * initScale;

    float initOpac = 200;
    float finalOpac = 50;
    float invCbrt = (1 - ratio) * (1 - ratio) * (1 - ratio);
    float scaledOpac = (1 - invCbrt) * finalOpac + invCbrt * initOpac;

    fill(bouncerPurple.r, bouncerPurple.g, bouncerPurple.b, scaledOpac);
    circle(x, toY(y), scale);
}

void collideEffect(float x, float y, Colour c, long progress, long target) {
    float finalScale = 70;
    float initScale = 40;
    float ratio = min((float) progress / target, 1);
    float scale = ratio * finalScale + (1 - ratio) * initScale;

    float initOpac = 170;
    float finalOpac = 40;
    float invCbrt = (1 - ratio) * (1 - ratio) * (1 - ratio);
    float scaledOpac = (1 - invCbrt) * finalOpac + invCbrt * initOpac;

    fill(c.r, c.g, c.b, scaledOpac);
    circle(x, toY(y), scale);
}

void win(float x, float y, long progress, long target) {
    float finalScale = 150;
    float initScale = 70;
    float ratio = min((float) progress / target, 1);
    float scale = ratio * finalScale + (1 - ratio) * initScale;

    float initOpac = 200;
    float finalOpac = 0;
    float invCbrt = (1 - ratio) * (1 - ratio) * (1 - ratio);
    //float cube = ratio * ratio * ratio;
    //float scaledOpac = cube * finalOpac + (1 - cube) * initOpac;
    float scaledOpac = (1 - invCbrt) * finalOpac + invCbrt * initOpac;
    fill(ballRed.r, ballRed.g, ballRed.b, scaledOpac);
    circle(x, toY(y), scale);
}

void win2(float x, float y, long progress, long target) {
    float finalScale = 300;
    float initScale = 70;
    float ratio = min((float) progress / target, 1);
    float scale = ratio * finalScale + (1 - ratio) * initScale;

    float initOpac = 70; //70
    float finalOpac = 0; //0
    float invCbrt = (1 - ratio) * (1 - ratio) * (1 - ratio);
    float scaledOpac = (1 - invCbrt) * finalOpac + invCbrt * initOpac;
    fill(offwhite.r, offwhite.g, offwhite.b, scaledOpac);
    circle(x, toY(y), scale);
}

void test2() {
    test((x, y) -> {});
}

void test(Effect e) {

}
