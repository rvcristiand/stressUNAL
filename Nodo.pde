/**
 * Nudo.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Nudo ...
 */

public class Nodo extends Punto {
  float startSize = 1;
  int startColor  = color(255, 0, 0);

  float endSize = 1.5 * startSize;
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
