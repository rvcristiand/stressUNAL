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
Grilla grilla;
// Punto punto;

// mouse
int positionMousePressed[] = new int[2];
Vector i;
Vector j;

boolean isLeftMouseButtonPressed;
boolean isRightMouseButtonPressed;
boolean isCenterMouseButtonPressed;
boolean isMouseDragged;
boolean isMouseClicked;
boolean isMouseDoubleClicked;

// keyboard
boolean isControlKeyPressed;
boolean drawFrame;

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
  scene.fitBall();  // como actualizar el radio dinámico

  // Grilla
  grilla = new Grilla(scene);
  grilla.setPoints();
  // Punto
  // punto = new Punto(scene);
}

void draw() {
  background(127);
  fill(204, 102, 0);
  // box(20, 30, 50);
  scene.traverse();
  // scene.drawAxes();
  // scene.drawDottedGrid();

  seti();
  drawRectMouseDragged();
  // zoomAll();
}

void seti() {
  if (isMouseClicked && isLeftMouseButtonPressed && drawFrame) {
    i = new Vector(mouseX, mouseY, 0);
    println(i);
  }
}

void zoomAll() {
  // Perform fitBallInterpolation with double left clic button
  if (isMouseDoubleClicked && isLeftMouseButtonPressed) {
    scene.fitBallInterpolation();  // how update scene.setRadius();
    mouseButtonReleased();
    isMouseDoubleClicked = false;
  }
}

void drawRectMouseDragged() {
  // Draw a rect in the frontbuffer
  println(isCenterMouseButtonPressed);
  if (isCenterMouseButtonPressed && isMouseDragged) {
    pushStyle();
    scene.beginScreenCoordinates();
    rectMode(CORNERS);
    stroke(125);
    fill(63, 125);
    rect(positionMousePressed[0], positionMousePressed[1], mouseX, mouseY);
    scene.endScreenCoordinates();
    popStyle();
  }
}

void mouseButtonPressed() {
  // mouse button flags
  println(mouseButton);
  switch (mouseButton) {
    case LEFT :
      isLeftMouseButtonPressed   = true;
      break;
    case RIGHT :
      isRightMouseButtonPressed  = true;
      break;
    case CENTER :
      isCenterMouseButtonPressed = true;
      break;
  }
}

void mouseButtonReleased() {
  // mouse button flags
  isLeftMouseButtonPressed   = false;
  isRightMouseButtonPressed  = false;
  isCenterMouseButtonPressed = false;
}

void mousePressed() {
  // position mouse pressed
  positionMousePressed = new int[]{mouseX, mouseY};
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
  isMouseClicked = false;

  //mouse double clicked
  isMouseDoubleClicked = false;
}

public void mouseClicked(MouseEvent event) {
  // double clic mouse flag
  switch (event.getCount()) {
    case 1 : isMouseClicked       = true;
             isMouseDoubleClicked = false;
    case 2 : isMouseClicked       = false;
             isMouseDoubleClicked = true;
  }
  // mouseButtonPressed();
}

void keyPressed() {
  // key pressed flags
  // if (key == '+') {
  //   grilla.setnumx(5);
  // }
  if (key == 'f') {
    drawFrame = !drawFrame;

    if (drawFrame) {
      println("Draw a frame");
    } else {
      println('\n');
    }
  }
  if (key == CODED) {
    switch (keyCode) {
      case CONTROL : isControlKeyPressed = true;
    }
  }
}

void keyReleased() {
  // key pressed flags
  isControlKeyPressed = false;
}
