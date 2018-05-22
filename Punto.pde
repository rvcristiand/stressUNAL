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

  float endSize = 1.5 * this.startSize;
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
