/**
 * Grilla.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Gilla ...
 */

 public class Grilla {
   Graph graph;

   int numx = 10;
   int numy = 10;

   float distx = 50;
   float disty = 50;

   ArrayList<Punto> puntos;

   public Grilla(Graph graph) {
     this.graph = graph;
   }

   void setPoints() {
     Punto punto;
     puntos = new ArrayList();

     for (int i = 0; i < this.numx; i++) {
       for (int j = 0; j < this.numy; j++) {
         punto = new Punto(this.graph);
         punto.translate(new Vector(i * this.distx,
                                    j * this.disty));
         puntos.add(punto);
       }
     }
   }

   int numx() {
     return this.numx;
   }

   void setnumx(int numx) {
     this.numx = numx;

     this.setPoints();
   }

   void setnumy(int numy) {
     this.numy = numy;
   }

   void setdistx(float distx) {
     this.distx = distx;
   }

   void setdisty(float disty) {
     this.disty = disty;
   }
 }
