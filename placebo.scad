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
    hull() {
      translate([12, 18, 0]) cylinder(d=4, h=4, center=true);
      translate([-12, 18, 0]) cylinder(d=4, h=4, center=true);
      translate([-12, -16, -1]) cylinder(d=4, h=2, center=true);
      translate([12, -16, -1]) cylinder(d=4, h=2, center=true);
      translate([0, -20, -1]) cylinder(d=10, h=2, center=true);
    }

    hull() {
      translate([0, 0, 4])
        scale([1.05, 1.05, 2])
        PlaceboPCB(pin_height=0);
      translate([0, 0, -1.3]) 
        PlaceboPCB(pin_height=0);
    }
  }

  hull() {
    rotate([0, 90, 0])
      translate([-1.4, 18, 0])
      cylinder(r=0.6, h=22.4, center=true);
    rotate([0, 90, 0])
      translate([-0.4, 18, 0])
      cylinder(r=0.6, h=22.4, center=true);
    rotate([0, 90, 0])
      translate([-1.4, 14, 0])
      cylinder(r=0.6, h=23, center=true);
  }
}

$fn=32;

%translate([0, 0, -0.8]) 
  PlaceboPCB(pin_height=6);
Jig();
