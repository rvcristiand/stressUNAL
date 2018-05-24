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
