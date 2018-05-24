import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.List; 
import java.util.Arrays; 
import frames.processing.Scene; 
import frames.core.Node; 
import frames.core.Graph; 
import frames.core.Interpolator; 
import frames.primitives.Frame; 
import frames.primitives.Vector; 
import frames.primitives.Quaternion; 
import frames.input.Shortcut; 
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
Eye eye;

// stressUNAL
Grilla grilla;

Vector i;
Vector j;

ArrayList<Portico> porticos;
// Punto punto;

// mouse
Vector positionMousePressed;

// boolean isLeftMouseButtonPressed;
// boolean isRightMouseButtonPressed;
boolean isCenterMouseButtonPressed;
boolean isMouseDragged;
// boolean isMouseClicked;
// boolean isMouseDoubleClicked;

// keyboard
// boolean isControlKeyPressed;
boolean addPortico;

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
  eye = new Eye(scene);
  scene.setEye(eye);
  scene.setFieldOfView((float) Math.PI / 3);
  scene.setDefaultGrabber(eye); // el nodo captura los dispositivos de entrada
  // scene.setRadius(100);
  scene.fitBall();  // como actualizar el radio dinámico

  // stressUNAL
  grilla = new Grilla(scene);
  grilla.setPoints();
  porticos = new ArrayList();
  // Punto
  // punto = new Punto(scene);
}

public void draw() {
  background(127);
  fill(204, 102, 0);
  // box(20, 30, 50);
  scene.traverse();
  scene.drawAxes();
  // scene.drawDottedGrid();

  if (addPortico) {
    addPortico();
  }

  for (Portico portico : porticos) {
    scene.drawPath(portico);
  }

  drawRectMouseDragged();
  // zoomAll();
}

public void addPortico() {
  if (i != null && j != null) {
    Nodo i = new Nodo(scene, i);
    Nodo j = new Nodo(scene, j);
    // porticos.add(new Portico(scene, i, j));
    i = null;
    j = null;
  }
}

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

public void keyPressed() {
//   // key pressed flags
//   // if (key == '+') {
//   //   grilla.setnumx(5);
//   // }
  if (key == 'f') {
    addPortico = !addPortico;

    if (addPortico) {
      println("Draw a frame");
    } else {
      println("Abort !");
    }
//   }
//   // if (key == CODED) {
//   //   switch (keyCode) {
//   //     case CONTROL : isControlKeyPressed = true;
//   //   }
  }
}

// void keyReleased() {
//   // key pressed flags
//   isControlKeyPressed = false;
// }
/**
 * OrbitNode
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a node behavior which requires
 * overriding the interact(Event) method.
 *
 * Feel free to copy paste it.
 */

public class Eye extends Node {
  public Eye(Graph graph) {
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
      graph().fitBallInterpolation();
    }
  }
}
/**
 * Grilla.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Gilla ...
 */

 public class Grilla {
   int numx;
   int numy;

   float distx;
   float disty;

   ArrayList<Punto> puntos;

   public Grilla(Graph graph) {
     puntos = new ArrayList();

     numx = 10;
     numy = 10;

     distx = 50;
     disty = 50;
   }

   public void setPoints() {
     Punto punto;

     for (int i = 0; i < numx; i++) {
       for (int j = 0; j < numy; j++) {
         punto = new Punto(scene);
         punto.translate(new Vector(i * distx,
                                    j * disty));
         puntos.add(punto);
       }
     }
   }

   // int numx() {
   //   return this.numx;
   // }
   //
   // void setnumx(int numx) {
   //   this.numx = numx;
   //
   //   this.setPoints();
   // }
   //
   // void setnumy(int numy) {
   //   this.numy = numy;
   // }
   //
   // void setdistx(float distx) {
   //   this.distx = distx;
   // }
   //
   // void setdisty(float disty) {
   //   this.disty = disty;
   // }
 }
/**
 * Nudo.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Nudo ...
 */

public class Nodo extends Punto {
  float startSize = 1;
  int startColor  = color(255, 0, 0);

  float endSize = 1.5f * startSize;
  int endColor  = color(0, 255, 255);

  public Nodo(Scene scene, Vector i) {
    super(scene, null, i, new Quaternion(), 1);
  }

  @Override
  public void visit() {
    pushStyle();
    noStroke();
    if (!graph().isInputGrabber(this)) {
      fill(startColor);
      sphere(startSize);
    } else {
      fill(endSize);
      sphere(endSize);
    }
    popStyle();
  }

  // @Override
  // public void interact(frames.input.Event event) {
  //   if (event.shortcut().matches(new TapShortcut(LEFT, 1))) {
  //     if (addPortico) {
  //       if (i == null) {
  //         i = position();
  //       } else if (j == null) {
  //         j = position();
  //       }
  //       println("i: ", i);;
  //       println("j: ", j);
  //       println("\n");
  //     }
  //   }
  // }
}
// /**
//  * Frame.
//  * by Cristian Danilo Ramirez Vargas
//  *
//  * This class implements a Frame ...
//  */
//
public class Portico extends Interpolator {
  ArrayList<Frame> _path;

  Vector i;
  Vector j;

  public Portico(Scene scene, Vector i, Vector j) {
    super((Graph) scene);

    this.i = i;
    this.j = j;
    _path = new ArrayList();
  }

  @Override
  public ArrayList<Frame> path() {
    _path.add(new Frame(i, new Quaternion()));
    _path.add(new Frame(j, new Quaternion()));

    return _path;
  }
}
/**
 * Punto.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Punto ...
 */


public class Punto extends Node {
  public Punto(Scene scene) {
    super(scene);
  }

  @Override
  public void visit() {
    scene.drawPickingTarget(this);
  }
  @Override
  public void interact(frames.input.Event event) {
    if (event.shortcut().matches(new TapShortcut(LEFT, 1))) {
      if (addPortico) {
        if (i == null) {
          i = position();
        } else if (j == null) {
          j = position();
        }
        println("i: ", i);;
        println("j: ", j);
        println("\n");
      }
    }
  }
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
