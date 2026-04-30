$fn = $preview ? 30 : 150;

include <OLED_0.91.scad>

// Makes the casing thickness assymetric in y-direction
left_shift = 2.5 / 2;

w_shell = 1.5;
// o_x = 48;
o_x = 46.5;
o_y = 43;
o_z = 10.75;

// centered on XY only
module roundedcubez_(size = [1, 1, 1], radius = 0.5) {
	linear_extrude(height=size[2]) {
		square([size[0] - 2 * radius, size[1]], center=true);
		square([size[0], size[1] - 2 * radius], center=true);
		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([i * (size[0] / 2 - radius), j * (size[1] / 2 - radius), 0])
					circle(r = radius);
	}
}

module enclosure() {
	difference() {
		translate([-left_shift, 0, -4.5]) {
			roundedcubez_(size=[o_x + 4 - left_shift * 2, o_y, o_z], radius=3);
			// translate([0, -o_y / 2, 0])
			// 	cube(size=[(o_x + 4 - left_shift * 2) / 2, o_y / 2, o_z]);
		}

		// Hollow it out
		translate([0, 0, -3.5])
			roundedcubez_(size=[o_x - w_shell * 2, 40.5, o_z - 2], radius=3);

		// OLED
		// translate([1.96, 0, 0])
		// 	roundedcubez_(size=[23, 7, 10], radius=1.5);
		translate([0.7, 0, 0])
			roundedcubez_(size=[23 + 1.6, 7 + 1, 10], radius=1.5);

		// USB
		translate([o_x / 2 - 7, -13.75, 1.3])
			rotate([90, 0, 90])
				roundedcubez_(size=[10, 4, 10], radius=1.5);
		// translate([27.75, -11.5 - 5, -7])
		// 	roundedcubez_(size=[10, 15 + 10, 15], radius=4);


		// SMA
		for (i=[-1, 1])
			translate([-o_x / 2, 11.5 * i, 0])
				rotate([90, 0, 90]) {
					cylinder(h=10, d=6.7, center=true);
					translate([0, 0, 2.5])
						cube([7, 7, 5], center=true);
				}

		// Power LED
		translate([-18.6, 0, o_z - 7.5])
			cylinder(d=2, h=5);
	}

	// bottom plate
	translate([0, 0, -3])
		cube(size=[34, o_y - w_shell, 2], center=true);
}


module enclosure2(is_top=false) {
	intersection() {
		difference() {
			union() {
				enclosure();
				if (is_top) {
					// Standoffs
					for (i=[-1, 1]) {
						translate([0, i * 17.5, -0.5]) {
							cylinder(h=o_z - 5, d=5.5, center=false);
							translate([-5.5 / 2, 2 * i - 2, 0])
								cube([5.5, 4, o_z - 5], center=false);
						}
					}
				}
			}
			if (is_top) {
				// Encoder
				translate([10, 16, 2.7])
					cylinder(h=2.7, d=15.5, center=true);
				// translate([17.3, 16, 2.6])
				// 	cylinder(h=2.5, d=16, center=true);

				// Rocker
				translate([-10, 16, 0.9 - 2])
					cylinder(h=2.5 + 4, d=15, center=true);

				// BOOT0 switch
				translate([-17.3, -20, 0.55 - 2])
					cube(size=[3, 10, 1.5 + 4], center=true);
			}
			for (i=[-1, 1]) {
				// M2 screw-holes
				translate([0, i * 17.5, 0])
					cylinder(h=20, d=2.2, center=true);
				// M2 hex nut holes
				translate([0, i * 17.5, -6.5 + 1.7])
					cylinder(h=4, d=4.2 * 1.155, center=true, $fn=6);
				// Screw head holes
				translate([0, i * 17.5, 10.5 - 3.75])
					cylinder(h=10, d=4.1, center=true);
			}
		}
		split_offset = -0.4;
		translate([0, 0, is_top ? 50 + split_offset : -50 + split_offset])
			cube(size=[100, 100, 100], center=true);
	}
}

// Mock components for Preview

// module screw(l=6) {
// 	cylinder(h=2, d=3.8);
// 	translate([0, 0, 2])
// 		cylinder(h=l, d=2.0);
// }

// translate([0, 17.5, 3.75])
// 	rotate([180, 0, 0])
// 		screw();

// PCB mockup: Needs a 3D export in .stl format from Kicad
// module pcb() {
// 	color("yellow")
// 		translate([0, 0, -2])
// 			import("clock_box.stl");
// 	translate([1, 0.78, 1.9])
// 		rotate([0, 0, 180])
// 			oled();
// }


// Export the 2 shells
intersection() {
	union() {
		enclosure2(true);
		// enclosure2(false);
	}
	// Cross-section view
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}

