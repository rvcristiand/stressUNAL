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
    super(graph, null, new Vector(), new Quaternion(0, -1, 0, 1), 1);
  }
  
  @Override
  public void interact(frames.input.Event event) {
    if (event.shortcut().matches(new Shortcut(Event.SHIFT, CENTER)))
      rotate(event);
    else if (event.shortcut().matches(new Shortcut(CENTER)))
      translate(event);
    else if (event.shortcut().matches(new Shortcut(processing.event.MouseEvent.WHEEL)))
      translateZ(event);
    //if (event.shortcut().matches(new Shortcut(RIGHT)))
    //  rotate(event);
    //else if (event.shortcut().matches(new Shortcut(LEFT))) {
    //  if (!event.isShiftDown()) {
    //    translate(event);
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
