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

Scene scene;
Node eye;

// mouse
int positionMousePressed[] = new int[2];

boolean isLeftMouseButtonPressed;
boolean isRightMouseButtonPressed;
boolean isCenterMouseButtonPressed;
boolean isMouseDragged;
boolean isMouseDoubleClicked;

// keyboard
boolean isControlKeyPressed;

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
  scene.fitBall();
}

void draw() {
  background(0);
  fill(204, 102, 0);
  box(20, 30, 50);
  scene.drawAxes();
  
  drawRectMouseDragged();
  zoomAll();
}

void zoomAll() {
  // Perform fitBallInterpolation with double left clic button
  if (isMouseDoubleClicked && isLeftMouseButtonPressed) {
    scene.fitBallInterpolation();
    mouseButtonReleased();
    isMouseDoubleClicked = false;
  }
}

void drawRectMouseDragged() {
  // Draw a rect in the frontbuffer
  if (isControlKeyPressed && isLeftMouseButtonPressed && isMouseDragged) {
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
  switch (mouseButton) {
    case LEFT   : isLeftMouseButtonPressed   = true;
    case RIGHT  : isRightMouseButtonPressed  = true;
    case CENTER : isCenterMouseButtonPressed = true;
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
}

public void mouseClicked(MouseEvent evt) {
  // double clic mouse flag
  if (evt.getCount() == 2) {
    isMouseDoubleClicked = true;
    mouseButtonPressed();
  }
}

void keyPressed() {
  // key pressed flags
  if (key == CODED) {
    switch (keyCode) {
      case CONTROL: isControlKeyPressed = true;
    }
  }
}

void keyReleased() {
  // key pressed flags
  isControlKeyPressed = false;
}
