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
