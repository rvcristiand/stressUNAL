// /**
//  * Frame.
//  * by Cristian Danilo Ramirez Vargas
//  *
//  * This class implements a Frame ...
//  */
//
public class Portico extends Interpolator {
  ArrayList<Frame> _path;

  Vector i;
  Vector j;

  public Portico(Scene scene, Vector i, Vector j) {
    super((Graph) scene);

    this.i = i;
    this.j = j;
    _path = new ArrayList();
  }

  @Override
  public ArrayList<Frame> path() {
    _path.add(new Frame(i, new Quaternion()));
    _path.add(new Frame(j, new Quaternion()));

    return _path;
  }
}
