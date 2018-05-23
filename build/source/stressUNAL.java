import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.List; 
import java.util.Arrays; 
import frames.processing.Scene; 
import frames.core.Graph; 
import frames.core.Node; 
import frames.primitives.Vector; 
import frames.primitives.Quaternion; 
import frames.input.Shortcut; 
import frames.input.event.TapEvent; 
import frames.input.event.TapShortcut; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class stressUNAL extends PApplet {

/**
 * Cad Camera
 * by Cristian Danilo Ramirez Vargas
 *
 * This example illustrates how to add a CAD Camera type to your scene.
*/












// frames
Scene scene;
Node eye;

// stressUNAL
// Grilla grilla;
// ArrayList<Portico> porticos;
// Punto punto;

// mouse
Vector positionMousePressed;
// Vector i;
// Vector j;

// boolean isLeftMouseButtonPressed;
// boolean isRightMouseButtonPressed;
boolean isCenterMouseButtonPressed;
boolean isMouseDragged;
// boolean isMouseClicked;
// boolean isMouseDoubleClicked;

// keyboard
// boolean isControlKeyPressed;
// boolean addFrame;

public void setup() {
  
  // Scene instantiation
  scene = new Scene(this);
  // Set right handed world frame (usefil for engineers...)
  scene.setRightHanded();
  // scene.eyeFrame().setMotionBinding(LEFT, "rotateCAD"); // qué significa setBinding (Profile.java)
  // scene.setRadius(200);
  // Set scene
  // scene.fitBall();
  scene.setType(Graph.Type.ORTHOGRAPHIC);

  // Set eye
  eye = new OrbitNode(scene);
  scene.setEye(eye);
  scene.setFieldOfView((float) Math.PI / 3);
  scene.setDefaultGrabber(eye); // el nodo captura los dispositivos de entrada
  // scene.setRadius(100);
  scene.fitBall();  // como actualizar el radio dinámico

  // stressUNAL
  // grilla = new Grilla(scene);
  // grilla.setPoints();
  // porticos = new ArrayList();
  // Punto
  // punto = new Punto(scene);
}

public void draw() {
  background(127);
  fill(204, 102, 0);
  // box(20, 30, 50);
  // scene.traverse();
  scene.drawAxes();
  scene.drawDottedGrid();

  // addFrame();
  drawRectMouseDragged();
  // zoomAll();
}

// void addFrame() {
//   if (i == null) {
//     seti();
//     j = null;
//   } else {
//     setj();
//     println("i: ", i);
//     println("j: ", j);
//     // porticos.add(new Portico(i, j));
//     i = null;
//     j = null;
//   }
// }

// void seti() {
//   i = scene.unprojectedCoordinatesOf(new Vector(mouseX, mouseY));
// }
//
// void setj() {
//   j = scene.unprojectedCoordinatesOf(new Vector(mouseX, mouseY));
// }

// void zoomAll() {
//   // Perform fitBallInterpolation with double left clic button
//   if (isMouseDoubleClicked && isLeftMouseButtonPressed) {
//     scene.fitBallInterpolation();  // how update scene.setRadius();
//     mouseButtonReleased();
//     isMouseDoubleClicked = false;
//   }
// }

public void drawRectMouseDragged() {
  // Draw a rect in the frontbuffer
  if (isCenterMouseButtonPressed && isMouseDragged) {
    pushStyle();
    scene.beginScreenCoordinates();
    rectMode(CORNERS);
    stroke(125);
    fill(63, 125);
    rect(positionMousePressed.x(), positionMousePressed.y(), mouseX, mouseY);
    scene.endScreenCoordinates();
    popStyle();
  }
}

public void mouseButtonPressed() {
  // mouse button flags
  switch (mouseButton) {
    // case LEFT :
    //   isLeftMouseButtonPressed   = true;
    //   break;
    // case RIGHT :
    //   isRightMouseButtonPressed  = true;
    //   break;
    case CENTER :
      isCenterMouseButtonPressed = true;
      break;
  }
}

public void mouseButtonReleased() {
  // mouse button flags
  // isLeftMouseButtonPressed   = false;
  // isRightMouseButtonPressed  = false;
  isCenterMouseButtonPressed = false;
}

public void mousePressed() {
  // position mouse pressed
  positionMousePressed = new Vector(mouseX, mouseY);
  mouseButtonPressed();
}

public void mouseDragged() {
  // mouse dragged flag
  isMouseDragged = true;
}

public void mouseReleased() {
  // position mouse pressed
  positionMousePressed = null;

  // mouse button pressed
  mouseButtonReleased();

  // mouse dragged
  isMouseDragged = false;

  // mouse clicked
  // isMouseClicked = false;

  //mouse double clicked
  // isMouseDoubleClicked = false;
}

// void mouseClicked(MouseEvent event) {
//   // double clic mouse flag
//   switch (event.getCount()) {
//     case 1 :
//       if (addFrame) {
//         addFrame();
//       }
//       break;
//   }
//   // mouseButtonPressed();
// }

// void keyPressed() {
//   // key pressed flags
//   // if (key == '+') {
//   //   grilla.setnumx(5);
//   // }
//   if (key == 'f') {
//     addFrame = !addFrame;
//
//     if (addFrame) {
//       println("Draw a frame");
//     } else {
//       println('\n');
//     }
//   }
//   // if (key == CODED) {
//   //   switch (keyCode) {
//   //     case CONTROL : isControlKeyPressed = true;
//   //   }
//   // }
// }

// void keyReleased() {
//   // key pressed flags
//   isControlKeyPressed = false;
// }
/**
 * Grilla.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Gilla ...
 */

 public class Grilla {
   Graph graph;

   int numx = 10;
   int numy = 10;

   float distx = 50;
   float disty = 50;

   ArrayList<Punto> puntos;

   public Grilla(Graph graph) {
     this.graph = graph;
   }

   public void setPoints() {
     Punto punto;
     puntos = new ArrayList();

     for (int i = 0; i < this.numx; i++) {
       for (int j = 0; j < this.numy; j++) {
         punto = new Punto(this.graph);
         punto.translate(new Vector(i * this.distx,
                                    j * this.disty));
         puntos.add(punto);
       }
     }
   }

   public int numx() {
     return this.numx;
   }

   public void setnumx(int numx) {
     this.numx = numx;

     this.setPoints();
   }

   public void setnumy(int numy) {
     this.numy = numy;
   }

   public void setdistx(float distx) {
     this.distx = distx;
   }

   public void setdisty(float disty) {
     this.disty = disty;
   }
 }
/**
 * OrbitNode
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a node behavior which requires
 * overriding the interact(Event) method.
 *
 * Feel free to copy paste it.
 */




public class OrbitNode extends Node {
  public OrbitNode(Graph graph) {
    super(graph);
    setWheelSensitivity(-wheelSensitivity());
    setRotationSensitivity(1.5f);
    setSpinningSensitivity(100);
    setDamping(1.f);
  }

  @Override
  public void interact(frames.input.Event event) {
    // transladar
    if (event.shortcut().matches(new Shortcut(LEFT))) {
      translate(event);
    }
    // rotar
    else if (event.shortcut().matches(new Shortcut(RIGHT))) {
      rotate(event);
    }
    // zoom en region
    else if (event.shortcut().matches(new Shortcut(CENTER))) {
      zoomOnRegion(event);
    }
    // zoom con ruedita
    else if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL))) {
      translateZ(event);  // scale(event);
    }
    // zoom all
    else if (event.shortcut().matches(new TapShortcut(CENTER, 1))) {
      this.graph().fitBallInterpolation();
    }
  }
}
// /**
//  * Frame.
//  * by Cristian Danilo Ramirez Vargas
//  *
//  * This class implements a Frame ...
//  */
//
public class Portico {
  Node node;
  PShape s;

  Vector i;
  Vector j;

  public Portico(Vector i, Vector j) {
    this.i = i;
    this.j = j;

    this.node = new Node(scene) {
      @Override
      public void visit() {
        drawLine();
      }
    };
    node.setPosition(j);
  }

  public void drawLine() {
    beginShape();
    pushStyle();
    stroke(20);
    vertex(this.i.x(), this.i.y(), this.i.z());
    vertex(this.j.x(), this.j.y(), this.j.z());
    popStyle();
    endShape();
  }
}
/**
 * Punto.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Punto ...
 */

// import frames.primitives.Frame;

public class Punto extends Node {
  Graph graph;

  float startSize = 1;
  int startColor = color(255,   0,   0);

  float endSize = 1.5f * this.startSize;
  int endColor   = color(  0, 255, 255);

  public Punto(Graph graph) {
    super(graph);

    graph = graph;
  }

  @Override
  public void visit() {
    pushStyle();
    noStroke();
    if (!this.graph().isInputGrabber(this)) {
      fill(startColor);
      sphere(this.startSize);
    } else {
      fill(this.endSize);
      sphere(this.endSize);
    }


    popStyle();
  }
  // @Override
  // public void interact(frames.input.Event event) {
  //   if (event.shortcut().matches(new Shortcut(LEFT))) {
  //     println(this.position());
  //   }

    //  } else {
    //    rotate(event);
    //  }
    //else if (event.shortcut().matches(new Shortcut(CENTER)))
    //  translate(event);
    //else if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
    //  if (event.isShiftDown()) {
    //    translateZ(event);
    //}
    // this.graph.eye().interact(event);
  // }
}
  public void settings() {  size(640, 360, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "stressUNAL" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
