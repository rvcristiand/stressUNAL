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
      translateZ(event);  // scale(event);
    else if (event.shortcut().matches(new Shortcut(RIGHT)))
      rotate(event);
    else if (event.shortcut().matches(new Shortcut(CENTER)))
      this.graph().fitBallInterpolation();
    else if (event.shortcut().matches(new Shortcut(frames.input.Event.CTRL, CENTER)))
      zoomOnRegion(event);
  }
}
