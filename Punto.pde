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
      if (positionI == null) {
        positionI = position();
      } else if (positionJ == null) {
        positionJ = position();
      }
      println("positionI: ", positionI);;
      println("positionJ: ", positionJ);
      println("\n");
    }
  }
}
