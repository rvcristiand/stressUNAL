/**
 * Cad Camera
 * by Cristian Danilo Ramirez Vargas
 *
 * This example illustrates how to add a CAD Camera type to your scene.
*/

import java.util.List;
import java.util.Arrays;

import frames.processing.Scene;
import frames.core.Graph;
import frames.core.Node;
import frames.primitives.Vector;
import frames.primitives.Quaternion;
import frames.input.Shortcut;


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

void setup() {
  size(640, 360, P3D);
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

void draw() {
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

void drawRectMouseDragged() {
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

void mouseButtonPressed() {
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

void mouseButtonReleased() {
  // mouse button flags
  // isLeftMouseButtonPressed   = false;
  // isRightMouseButtonPressed  = false;
  isCenterMouseButtonPressed = false;
}

void mousePressed() {
  // position mouse pressed
  positionMousePressed = new Vector(mouseX, mouseY);
  mouseButtonPressed();
}

void mouseDragged() {
  // mouse dragged flag
  isMouseDragged = true;
}

void mouseReleased() {
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
