/**
 * Cad Camera
 * by Cristian Danilo Ramirez Vargas
 * 
 * This example illustrates how to add a CAD Camera type to your scene
*/

import frames.processing.Scene;

import frames.core.Graph;
import frames.core.Node;

// import frames.primitives.Frame;
import frames.primitives.Vector;
import frames.primitives.Quaternion;

import frames.input.Shortcut;


Scene scene;
Node eye;

void setup() {
  size(640, 360, P3D);
  // Scene instanttiation
  scene = new Scene(this);
  // Set right handed world frame (usefil for engineers...)
  scene.setRadius(200);
  scene.fitBall();
  scene.setType(Graph.Type.ORTHOGRAPHIC);
  scene.setRightHanded();
  
  eye = new OrbitNode(scene);
  scene.setEye(eye);
  scene.setFieldOfView((float) Math.PI / 3);
  scene.setDefaultGrabber(eye); // el nodo captura los dispositivos de entrada
  scene.fitBall();
}

void draw() {
  background(0);
  scene.drawAxes();
  
}
