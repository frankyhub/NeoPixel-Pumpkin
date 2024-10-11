/*
*******************************************
Objekt Info: Pumpkin body

*******************************************
Version: 13.09.2024
*******************************************
*/
//***************   Parameter  ************

frag=85; //Fragmente
ws=0.95; //Wandstaerke

//***************   Libraries  ************

use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <sweep.scad>

//*****************************************




module pumpkin_body() {
    union () {
        for (angle = [0:40:360])
            rotate ([0,0,angle]) translate ([-16,0,0]) 
                sphere(20, $fn=frag);
    }
}

module one_leaf_part() {
    translate ([6,0,0]) intersection () {
        cylinder(20,10,10);
        translate ([-12,0,0]) cylinder(20,10,10);
    }
}

module pumpkin_leaf() {
    translate ([0,19,0]) intersection () {
       
        translate ([0,-5,0]) rotate ([90,0,0]) union () {
            scale ([1.5,1.2,1]) one_leaf_part();
            translate ([6,3,0]) rotate ([0,0,45]) one_leaf_part();
            translate ([-6,3,0]) rotate ([0,0,-45]) one_leaf_part();
        }
        
        difference () {
            sphere(20);
            sphere(18);
        }
    }
}

module pumpkin_stem() {
    pathstep = 1;
    height = 100;

    shape_points = [[-2,-2],[-1.8,0],
                    [-2,2],[0,1.8],
                    [2,2],[1.8,0],
                    [2,-2],[0,-1.8]];

    function linear_down(x) = 3 - 2.5 * x;

    path_transforms = [for (i=[0:pathstep:height/2]) 
                       let(t=i/height) 
                            rotation([0,120*(t)*(t)*(t+0.5)*(t+0.5),0])*
                            translation([0,0,i])*
                            scaling([linear_down(t),linear_down(t),i])*
                            rotation([0,0,720*t])
                      ];
    sweep(shape_points, path_transforms);
}

module pumpkin() {
    union () {
        pumpkin_body();
        translate ([0,0,10]) scale ([0.5,0.5,0.5]) pumpkin_stem();
    }
}


module top_cone() {
    translate ([0,0,5]) cylinder(150,0,100);
}

module bottom_inverse_cone() {
    difference () {
        cube([200,200,200],center=true);
        top_cone();
    }
}

module pumpkin_top_part() {
    union () {
        intersection () {
            pumpkin();
            top_cone();
        }
        translate ([-3,-8,26]) rotate ([-75,0,-45]) pumpkin_leaf();
   }
}

module pumpkin_bottom_part() {
    intersection () {
        difference () {
            pumpkin();
            // Wandstaerke
            scale ([ws,ws,ws]) pumpkin_body();
        }
        bottom_inverse_cone();
    }
}


difference() {
    pumpkin_bottom_part();
translate(v = [-40, -40, 15])
 cube([80,80,30]);

translate(v = [0, 0, 10])
cylinder (h = 20, r=25, center = true, $fn=100);
 /*   
   translate(v = [0, 0, 5]) //rundes Auge rechts
   rotate(a = [30, 90, 0])  
   cylinder (h = 50, r=5, $fn=100);   

   translate(v = [0, 0, 5]) //rundes Auge links
   rotate(a = [90, 20, 0])  
   cylinder (h = 50, r=5, $fn=100);
 */   
  translate(v = [9, 0, 5]) //Auge rechts
  rotate(a = [90, -40, 50])  
  cylinder (h = 50, r=5, $fn=5);   
  translate(v = [-3, 0, 7])
  rotate(a = [90, 40, 0])
  cube(size = [11,4,50]);
  
  rotate(a = [90, -40, 0])
 cube(size = [10,4,50]);
 
   translate(v = [0, 0, 0]) //Nase
   rotate(a = [90, -30, 30])  
   cylinder (h = 50, r=7, $fn=3); 

   translate(v = [-43, 35, -10]) //USB
  rotate(a = [90, 0, 45])   
  cube(size = [6,4,30]);  
  
    }
    

 
   
    