final double WALK_AMOUNT = 0.0001;

double r1 () { return random (0, 255); }
double r2 () { return random (10, width-10); }
double r3 () { return random (10, 60); }
double r4 () { return random (-60, 60); }
double r5 () { return random (-WALK_AMOUNT, WALK_AMOUNT); }

PVector center = new PVector(width / 2, height / 2);
color bg = color(r1(), r1(), r1(), r1());

int count (Object[] objs) {
    int j = 0, i = 0;
    for (; i < objs.length; i++) {
        j += objs[i] == null ? 0 : 1;
    }
    return j;
}

class Shape {
    protected PVector[][] points = new PVector[15][3];
    protected int[] pType = new int[15];
    protected PVector[][] vels = new PVector[15][3];
    protected PVector[][] accs = new PVector[15][3];
    protected int pc = 0;
    protected color s, bg;
    protected String name = "Shape";

    Shape () {
        this.s = color(r1(), r1(), r1(), r1());
        this.bg = color(r1(), r1(), r1(), r1());
        this.pc = int(random(5, 15));
    }

    void setup () {
        double r_1 = r2();
        double r_2 = r2();
        this.points[0][0] = new PVector(r_1 + r4(), r_2 + r4());
        this.pType[0] = 0;
        this.vels[0][0] = new PVector(r5(), r5());
        this.accs[0][0] = new PVector(0, 0);
        for (int i = 1; i < this.pc; i++) {
            this.pType[i] = int(random(0, 3));
            for (int j = 0; j < 3; j++) {
                this.points[i][j] = new PVector(r_1 + r4(), r_2 + r4());
                this.vels[i][j] = new PVector(r5(), r5());
                this.accs[i][j] = new PVector(0, 0);
            }
        }
    }

    void draw (int j) {
        console.log(j);
        console.log(this.points);
        stroke(this.s);
        fill(this.bg);
        beginShape();
        for (int i = 0; i < this.pc; i++) {
            console.log(i, this.points[i][0], this.name);
            PVector[3] p = this.points[i];
            switch(pType[i]) {
                case 0 : 
                    vertex(p[0].x, p[0].y);
                break;

                case 1 :
                    curveVertex(p[0].x, p[0].y);
                break;

                // case 2 :
                //     quadraticVertex(p[0], p[1], p[3], p[4]);
                // break;

                case 2 :
                    bezierVertex(p[0].x, p[0].y, p[1].x, p[1].y, p[2].x, p[2].y);
                break;
            }
        }
        endShape(CLOSE);
    }

    void update () {
        for (int i = 0; i < this.pc; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 0 && j > 0) {continue;}
                PVector pv = PVector.random2D();
                pv.div(2);
                accs[i][j].add(pv);
                // PVector force = PVector.sub(center, points[i][j]);
                // double dist = force.mag();
                // double strength = dist / 1000;
                // force.normalize();
                // force.mult(strength);
                // accs[i][j].add(force);
                if (points[i][j].x > width) {
                    accs[i][j].add(new PVector(-5, 0));
                } else if (points[i][j].y < 0) {
                    accs[i][j].add(new PVector(5, 0));
                }
                if (points[i][j].y > height) {
                    accs[i][j].add(new PVector(0, -5));
                } else if (points[i][j].y < 0) {
                    accs[i][j].add(new PVector(0, 5));
                }
                
                points[i][j].add(vels[i][j]);
                vels[i][j].add(accs[i][j]);
                vels[i][j].set(constrain(vels[i][j].x, -.5, .5), constrain(vels[i][j].y, -.5, .5));
                accs[i][j].mult(0);
            }
        }
        this.s = color(
            constrain(red(this.s) + r5(), 0, 255),
            constrain(green(this.s) + r5(), 0, 255),
            constrain(blue(this.s) + r5(), 0, 255),
            constrain(alpha(this.s) + r5(), 0, 255)
        );
        this.bg = color(
            constrain(red(this.bg) + r5(), 0, 255),
            constrain(green(this.bg) + r5(), 0, 255),
            constrain(blue(this.bg) + r5(), 0, 255),
            constrain(alpha(this.bg) + r5(), 0, 255)
        );
    }
}

class Quad extends Shape {
    protected String name = "Quad";
    Quad () {
        super();
        this.pc = 4;
        this.setup();
    }
}

class Circle {
    double x, y, w, h, r;
    double[] vels = new double[5];
    double[] accs = new double[5];
    color s, bg;

    Circle () {
        this.s = color(r1(), r1(), r1(), r1());
        this.bg = color(r1(), r1(), r1(), r1());
        this.x = r2();
        this.y = r2();
        this.w = r3();
        this.h = r3();
        this.r = random(0, TWO_PI);
        for (int i = 0; i < 5; i++) {
            vels[i] = r5();
            accs[i] = 0;
        }
    }

    void draw () {
        stroke(this.s);
        fill(this.bg);
        pushMatrix();
        translate(this.x, this.y);
        rotate(this.r);
        ellipse(0, 0, this.w, this.h);
        popMatrix();
    }
    
    void update () {
        this.vels[0] += this.accs[0];
        this.vels[1] += this.accs[1];
        this.vels[2] += this.accs[2];
        this.vels[3] += this.accs[3];
        this.vels[4] += this.accs[4];
        this.x += vels[0];
        this.y += vels[1];
        this.w += vels[2];
        this.h += vels[3];
        this.r += vels[4] / 10;
        for (int i = 0; i < 5; i++) {
            this.accs[i] = r5();
        }

        this.s = color(
            constrain(red(this.s) + r5(), 0, 255),
            constrain(green(this.s) + r5(), 0, 255),
            constrain(blue(this.s) + r5(), 0, 255),
            constrain(alpha(this.s) + r5(), 0, 255)
        );
        this.bg = color(
            constrain(red(this.bg) + r5(), 0, 255),
            constrain(green(this.bg) + r5(), 0, 255),
            constrain(blue(this.bg) + r5(), 0, 255),
            constrain(alpha(this.bg) + r5(), 0, 255)
        );
    }
}

class Triangle extends Shape {
    String name = "Triangle";
    Triangle () {
        super();
        this.pc = 3;
        this.setup();
    }
}

Shape[] shapes = new Shape[30];
Quad[] rects = new Quad[30];
Circle[] circles = new Circle[30];
Triangle[] tris = new Triangle[30];


void setup () {
    size(1000, 1000);
    for (int i = 0; i < shapes.length; i++) {
        shapes[i] = new Shape();
        shapes[i].setup();
    }
    for (int i = 0; i < rects.length; i++) {
        rects[i] = new Quad();
    }
    for (int i = 0; i < circles.length; i++) {
        circles[i] = new Circle();
    }
    for (int i = 0; i <tris.length; i++) {
        tris[i] = new Triangle();
    }
    background(255);
    frameRate(10);
}


void draw () {
    background(bg);
    for (int i = 0; i < shapes.length; i++) {
        console.log(shapes[i]);
        shapes[i].draw(i);
        shapes[i].update();
    }
    for (int i = 0; i < rects.length; i++) {
        rects[i].draw(i);
        rects[i].update();
    }
    for (int i = 0; i < circles.length; i++) {
        circles[i].draw();
        circles[i].update();
    }
    for (int i = 0; i < tris.length; i++) {
        tris[i].draw(i);
        tris[i].update();
    }
    bg = color(
        constrain(red(bg) + r5(), 0, 255),
        constrain(green(bg) + r5(), 0, 255),
        constrain(blue(bg) + r5(), 0, 255),
        constrain(alpha(bg) + r5(), 0, 255)
    );
}