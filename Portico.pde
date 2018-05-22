// /**
//  * Frame.
//  * by Cristian Danilo Ramirez Vargas
//  *
//  * This class implements a Frame ...
//  */
//
public class Portico {
  Node node;
  PShape s;

  Vector i;
  Vector j;

  public Portico(Vector i, Vector j) {
    this.i = i;
    this.j = j;

    this.node = new Node(scene) {
      @Override
      public void visit() {
        drawLine();
      }
    };
    node.setPosition(j);
  }

  void drawLine() {
    beginShape();
    pushStyle();
    stroke(20);
    vertex(this.i.x(), this.i.y(), this.i.z());
    vertex(this.j.x(), this.j.y(), this.j.z());
    popStyle();
    endShape();
  }
}
