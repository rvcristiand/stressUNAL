/**
 * OrbitNode
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a node behavior which requires
 * overriding the interact(Event) method.
 *
 * Feel free to copy paste it.
 */

import frames.input.event.TapEvent;
import frames.input.event.TapShortcut;

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
      this.graph().fitBallInterpolation();
    }
  }
}
