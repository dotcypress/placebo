module PlaceboCutout(height=1.6) {
  translate([-10.76, -16.6, -height/2])
    linear_extrude(height=height, convexity=8)
    import(file="placebo.svg");
}

module PlaceboPCB(pin_height=10, pin_offset=2) {
  PlaceboCutout();

  translate([-0.1, 1.1, 0])
    cube([18.4, 26, 1.6], center=true);
  translate([-0.1, -12.4, 0])
    cube([14, 4, 1.6], center=true);

  for (i=[0:9]) {
    rotate([0, 0, 90]) {
      translate([i*2.54 - 10.2, 7.8, -pin_offset])
        cylinder(d=1.4, h=pin_height, center=true);
      translate([i*2.54 - 10.2, -7.5, -pin_offset])
        cylinder(d=1.4, h=pin_height, center=true);
    }
  }

  for (i=[-1:2]) {
    translate([i*2.54, -12.6, -pin_offset])
      cylinder(d=1.4, h=pin_height, center=true);
  }

  *translate([0, 11.8, 0.6])
    cube([7, 4, 0.6], center=true);
}

module Jig() {
  difference() {
    union() {
      hull() {
        translate([9.4, 14, 1.5]) cylinder(d=4, h=3.6, center=true);
        translate([-9.4, 14, 1.5]) cylinder(d=4, h=3.6, center=true);
        translate([-9.4, -14, 0]) cylinder(d=4, h=1, center=true);
        translate([9.4, -14, 0]) cylinder(d=4, h=1, center=true);
        translate([0, -17, 0]) cylinder(d=8, h=1, center=true);
      }
      difference() {
        rotate([-15, 0, 0]) hull() {
          translate([9, 13, 6.7])
            cylinder(d=4, h=2, center=true);
          translate([-9, 13, 6.7])
            cylinder(d=4, h=2, center=true);
        }
        rotate([-15, 0, 0])
          translate([0, -1.1, 5])
          scale([1.02, 1.02, 2.1])
          PlaceboPCB(pin_height=0);
      }
    }
 
    translate([3, -17, 0]) 
        cylinder(d=1, h=10, center=true);
    translate([-3, -17, 0]) 
        cylinder(d=1, h=10, center=true);
    translate([0, -20, 1.5]) 
        cylinder(d=1, h=3, center=true);

    translate([0, 0, 1.9])
      scale([1.02, 1.02, 2.4])
      PlaceboPCB(pin_height=5);
  }
}

$fn=32;

%translate([0, 0, 2.7]) PlaceboPCB(pin_height=6);
Jig();
