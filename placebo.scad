module PlaceboCutout(height=1.6) {
  translate([-10.76, -16.6, -height/2])
    hull()
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

module Printer(d=7) {
  cr=3;
  h=3;
  w=64;
  l=50;

  difference() {
    union() {
      hull() {
        translate([w/2-cr,d,0]) cylinder(r=cr, h=h, center=true);
        translate([w/2-cr,l/2-cr,0]) cylinder(r=cr, h=h, center=true);
        translate([-w/2+cr,l/2-cr,0]) cylinder(r=cr, h=h, center=true);
        translate([-w/2+cr,0,0]) cylinder(r=cr, h=h, center=true);
      }
      hull() {
        translate([w/2-cr,-l/2+cr,0]) cylinder(r=cr, h=h, center=true);
        translate([w/2-cr,-d,0]) cylinder(r=cr, h=h, center=true);
        translate([-w/2+cr,0,0]) cylinder(r=cr, h=h, center=true);
        translate([-w/2+cr,-l/2+cr,0]) cylinder(r=cr, h=h, center=true);
      }
    }
    rotate([0,0,90])
      translate([0,-3,h/2-0.79])
      PlaceboCutout();
    rotate([0,0,90])
      translate([0,-3,h/2-0.79])
      scale([0.85,0.9,10]) 
      PlaceboCutout();
  }
}

$fn=128;

// projection(cut=true) translate([0,0,1])
Printer();
