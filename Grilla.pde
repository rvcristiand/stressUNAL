/**
 * Grilla.
 * by Cristian Danilo Ramirez Vargas
 *
 * This class implements a Gilla ...
 */

 public class Grilla {
   int numx;
   int numy;

   float distx;
   float disty;

   ArrayList<Punto> puntos;

   public Grilla(Graph graph) {
     puntos = new ArrayList();

     numx = 10;
     numy = 10;

     distx = 50;
     disty = 50;
   }

   void setPoints() {
     Punto punto;

     for (int i = 0; i < numx; i++) {
       for (int j = 0; j < numy; j++) {
         punto = new Punto(scene);
         punto.translate(new Vector(i * distx,
                                    j * disty));
         puntos.add(punto);
       }
     }
   }

   // int numx() {
   //   return this.numx;
   // }
   //
   // void setnumx(int numx) {
   //   this.numx = numx;
   //
   //   this.setPoints();
   // }
   //
   // void setnumy(int numy) {
   //   this.numy = numy;
   // }
   //
   // void setdistx(float distx) {
   //   this.distx = distx;
   // }
   //
   // void setdisty(float disty) {
   //   this.disty = disty;
   // }
 }
