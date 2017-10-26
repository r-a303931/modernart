double r1 () { return random (0, 255); }
double r2 () { return random (10, width - 10); }
double r3 () { return random (10, 60); }
double r4 () { return random (-60, 60); }

class Shape {
    protected double[][] points = new double[15][2];
    protected color stroke, bg;

    Shape () {
        this.stroke = color(r1(), r1(), r1(), r1());
        this.bg = color(r1(), r1(), r1(), r1());
        this.setup();
    }

    void setup () {
        int pc = random(5, 15);
        double r_1 = r2();
        double r_2 = r2();
        for (int i = 0; i < pc; i++) {
            points[i][0] = r_2 + r4();
            points[i][1] = r_2 + r4();
        }
    }

    void draw () {

    }

    void update () {

    }
}

class Quad extends Shape {
    Quad () {
        super();
    }

    void setup () {
        int pc = 4;
        double r_1 = r2();
        double r_2 = r2();
        for (int i = 0; i < pc; i++) {
            points[i][0] = r_2 + r4();
            points[i][1] = r_2 + r4();
        }
    }
}

class Circle {
    double x, y, w, h;

    Circle () {

    }

    void setup () {

    }
}

class Triangle extends Shape {
    Triangle () {
        super();
    }

    void setup () {
        int pc = 3;
        double r_1 = r2();
        double r_2 = r2();
        for (int i = 0; i < pc; i++) {
            points[i][0] = r_2 + r4();
            points[i][1] = r_2 + r4();
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
    
}