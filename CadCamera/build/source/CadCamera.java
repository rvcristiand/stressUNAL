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

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CadCamera extends PApplet {

/**
 * Cad Camera
 * by Cristian Danilo Ramirez Vargas
 *
 * This example illustrates how to add a CAD Camera type to your scene.
*/














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
  scene.fitBall();
}

public void draw() {
  background(0);
  fill(204, 102, 0);
  box(20, 30, 50);
  scene.drawAxes();

  drawRectMouseDragged();
  zoomAll();
}

public void zoomAll() {
  // Perform fitBallInterpolation with double left clic button
  if (isMouseDoubleClicked && isLeftMouseButtonPressed) {
    scene.fitBallInterpolation();
    mouseButtonReleased();
    isMouseDoubleClicked = false;
  }
}

public void drawRectMouseDragged() {
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

public void mouseButtonPressed() {
  // mouse button flags
  switch (mouseButton) {
    case LEFT   : isLeftMouseButtonPressed   = true;
    case RIGHT  : isRightMouseButtonPressed  = true;
    case CENTER : isCenterMouseButtonPressed = true;
  }
}

public void mouseButtonReleased() {
  // mouse button flags
  isLeftMouseButtonPressed   = false;
  isRightMouseButtonPressed  = false;
  isCenterMouseButtonPressed = false;
}

public void mousePressed() {
  // position mouse pressed
  positionMousePressed = new int[]{mouseX, mouseY};
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
}

public void mouseClicked(MouseEvent evt) {
  // double clic mouse flag
  if (evt.getCount() == 2) {
    isMouseDoubleClicked = true;
    mouseButtonPressed();
  }
}

public void keyPressed() {
  // key pressed flags
  if (key == CODED) {
    switch (keyCode) {
      case CONTROL: isControlKeyPressed = true;
    }
  }
}

public void keyReleased() {
  // key pressed flags
  isControlKeyPressed = false;
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
    if (event.shortcut().matches(new Shortcut(LEFT)))
      translate(event);
    else if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
      translateZ(event);
    else if (event.shortcut().matches(new Shortcut(frames.input.Event.SHIFT, LEFT)))
      rotate(event);
    else if (event.shortcut().matches(new Shortcut(frames.input.Event.CTRL, LEFT)))
      zoomOnRegion(event);
    //  } else {
    //    rotate(event);
    //  }
    //else if (event.shortcut().matches(new Shortcut(CENTER)))
    //  translate(event);
    //else if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
    //  if (event.isShiftDown()) {
    //    translateZ(event);
    //}
  }
}
  public void settings() {  size(640, 360, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CadCamera" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
