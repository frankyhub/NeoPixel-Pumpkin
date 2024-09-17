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





module pumpkin_body() {
    union () {
        for (angle = [0:40:360])
            rotate ([0,0,angle]) translate ([-16,0,0]) 
                sphere(20, $fn=80);
    }
}

module one_leaf_part() {
    translate ([6,0,0]) intersection () {
        cylinder(20,10,10);
        translate ([-12,0,0]) cylinder(20,10,10);
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
    translate ([0,0,5]) cylinder(0,0,100);
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
            scale ([0.75,0.75,0.7]) pumpkin_body();
        }
        bottom_inverse_cone();
    }
}


pumpkin_top_part();

difference() {
   pumpkin_bottom_part();
   translate(v = [-40, -40, -45])
   cube([80,80,60]);
}

difference() {
translate(v = [0, 0, 15])
    cylinder (h = 3, r=24, center = true, $fn=100);
    color("SlateGray")
    rotate([0, 180, 0])
    translate([-15, -4,-15])
    linear_extrude(2)
    text(n,  font = "Arial", size = 6);
}



difference() {
    pumpkin_bottom_part();
translate(v = [-40, -40, 15])
 cube([80,80,30]);

translate(v = [0, 0, 10])
cylinder (h = 20, r=25, center = true, $fn=100);
    
   translate(v = [0, 0, 5]) //Augen
   rotate(a = [30, 90, 0])  
   cylinder (h = 50, r=5, $fn=100);   

   translate(v = [0, 0, 5]) 
   rotate(a = [90, 20, 0])  
   cylinder (h = 50, r=5, $fn=100);
    
   translate(v = [0, 0, 0]) //Nase
   rotate(a = [90, -30, 30])  
   cylinder (h = 50, r=7, $fn=3); 

   translate(v = [-43, 35, -10]) //USB
  rotate(a = [90, 0, 45])   
  cube(size = [6,4,30]);  
  
    }
  
 translate([-123, -108, -3])
 import("Stamm.stl", convexity=3);
    
    