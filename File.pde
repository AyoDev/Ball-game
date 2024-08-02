World read(String file){
  
  World w = new World();
  Ball b = new Ball();
  Goal g = new Goal(650, 100, PI/2);
  
  w.placed = new ArrayList<>();
  w.pocket = new ArrayList<>();
  String[] lines = loadStrings(file+".lvl");
  
  for (String line : lines){
    line = line.replaceAll("\\s","");
    String[] info = split(line,":");// name:value
    if (info.length == 1){continue;}
    String data = info[1];//the value
    println("g");
    float[] s;// for splitting data, coords etc
    switch (info[0]){
      case "c":
        s = fsplit(data,",");
        b.c = new Circle(s[0],s[1],s[2]);
        w.initX = b.c.x;
        w.initY = b.c.y;
        break;
      case "v":
        b.v = float(data);
        break;
      case "angle":
        s = fsplit(data,"/");
        b.angle = s[0] / s[1];
        break;
      case "peg":
        s = fsplit(data,",");
        addPeg(w, s[0], s[1]);
        break;
      case "bounce":
        s = fsplit(data,",");
        addBouncer(w, s[0], s[1]);
        break;
      case "goal":
        String[] x = split(data,",");
        String[] y = split(x[2], "/");
        g = new Goal(float(x[0]), float(x[1]), PI * int(y[0])/ int(y[1]));
        break;
      case "peg-count":
        w.pegsLeft = parseInt(data);
        break;
      default:
        break;
    }
  }
  w.ball = b;
  w.goal = g;
  return w;
}

float[] fsplit(String s, String sep){
  String[] a = split(s, sep);
  float[] b = {};
  for (String w : a){
    b = append(b,float(w));
  }
  return b;
  
}
