final double WALK_AMOUNT = 0.5;

double r1 () { return random (0, 255); }
double r2 () { return random (10, width-10); }
double r3 () { return random (10, 60); }
double r4 () { return random (-60, 60); }
double r5 () { return random (-WALK_AMOUNT, WALK_AMOUNT); }

int count (Object[] objs) {
    int j = 0, i = 0;
    for (; i < objs.length; i++) {
        j += objs[i] == null ? 0 : 1;
    }
    return j;
}

class Shape {
    protected double[][] points = new double[15][7];
    protected int pc = 0;
    protected color s, bg;

    Shape () {
        this.s = color(r1(), r1(), r1(), r1());
        this.bg = color(r1(), r1(), r1(), r1());
        this.setup();
    }

    void setup () {
        int pc = int(random(5, 15));
        this.pc = pc;
        double r_1 = r2();
        double r_2 = r2();
        points[0][0] = r_1 + r4();
        points[0][1] = r_2 + r4();
        points[0][2] = 0;
        for (int i = 1; i < pc; i++) {
            points[i][0] = r_1 + r4();
            points[i][1] = r_2 + r4();
            points[i][2] = int(random(0, 3));
            points[i][3] = r_1 + r4();
            points[i][4] = r_2 + r4();
            points[i][5] = r_1 + r4();
            points[i][6] = r_2 + r4();
        }
    }

    void draw () {
        stroke(this.s);
        fill(this.bg);
        beginShape();
        for (int i = 0; i < this.pc; i++) {
            double[7] p = this.points[i];
            if (p[0] < 15 && p[1] < 15) {
                console.log(p);
                console.log(i);
            }
            switch(p[2]) {
                case 0 : 
                    vertex(p[0], p[1]);
                break;

                case 1 :
                    curveVertex(p[0], p[1]);
                break;

                // case 2 :
                //     quadraticVertex(p[0], p[1], p[3], p[4]);
                // break;

                case 2 :
                    bezierVertex(p[0], p[1], p[3], p[4], p[5], p[6]);
                break;
            }
        }
        endShape(CLOSE);
    }

    void update () {

    }
}

class Quad extends Shape {
    Quad () {
        super();
    }

    void setup () {
        this.pc = 4;
        double r_1 = r2();
        double r_2 = r2();
        for (int i = 0; i < this.pc; i++) {
            points[i][0] = r_1 + r4();
            points[i][1] = r_2 + r4();
            points[i][2] = 0;
        }
    }
}

class Circle {
    double x, y, w, h, r;
    color s, b;

    Circle () {
        this.s = color(r1(), r1(), r1(), r1());
        this.b = color(r1(), r1(), r1(), r1());
        this.x = r2();
        this.y = r2();
        this.w = r3();
        this.h = r3();
        this.r = random(0, TWO_PI);
    }

    void draw () {
        stroke(this.s);
        fill(this.b);
        pushMatrix();
        translate(this.x, this.y);
        rotate(this.r);
        ellipse(0, 0, this.w, this.h);
        popMatrix();
    }
    
    void update () {

    }
}

class Triangle extends Shape {
    Triangle () {
        super();
    }

    void setup () {
        this.pc = 3;
        double r_1 = r2();
        double r_2 = r2();
        for (int i = 0; i < this.pc; i++) {
            points[i][0] = r_1 + r4();
            points[i][1] = r_2 + r4();
            points[i][2] = 0;
        }
    }
}

Shape[] shapes = new Shape[60];
Quad[] rects = new Quad[60];
Circle[] circles = new Circle[60];
Triangle[] tris = new Triangle[60];

void setup () {
    size(500, 500);
    for (int i = 0; i < 60; i++) {
        shapes[i] = new Shape();
    }
    for (int i = 0; i < 60; i++) {
        rects[i] = new Quad();
    }
    for (int i = 0; i < 60; i++) {
        circles[i] = new Circle();
    }
    for (int i = 0; i < 60; i++) {
        tris[i] = new Triangle();
    }
    background(255);
}

void draw () {
    background(255);
    for (int i = 0; i < 60; i++) {
        shapes[i].draw();
        shapes[i].update();
    }
    for (int i = 0; i < 60; i++) {
        rects[  i].draw();
        rects[i].update();
    }
    for (int i = 0; i < 60; i++) {
        circles[i].draw();
        circles[i].update();
    }
    for (int i = 0; i < 60; i++) {
        tris[i].draw();
        tris[i].update();
    }
}