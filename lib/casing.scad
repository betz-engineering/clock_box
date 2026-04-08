$fn = $preview ? 30 : 150;

include <roundedcube.scad>
use <3x3_font_for_nerds.ttf>

// Makes the casing thickness assymetric in y-direction
left_shift = 2.5 / 2;

module enclosure() {
	w_shell = 1.5;
	// o_x = 48;
	o_x = 46.5;
	o_y = 43;
	o_z = 10;


	difference() {
		translate([-left_shift, 0, -4.5]) {
			roundedcubez_(size=[o_x + 4 - left_shift * 2, o_y, o_z], radius=3);
			// translate([0, -o_y / 2, 0])
			// 	cube(size=[(o_x + 4 - left_shift * 2) / 2, o_y / 2, o_z]);
		}

		// Hollow it out
		translate([0, 0, -3.5])
			roundedcubez_(size=[o_x - w_shell * 2, 40.5, 8], radius=3);

		// OLED
		translate([1.96, 0, 0])
			roundedcubez_(size=[23 + 2, 7 + 1, 10], radius=1.5);

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
		translate([-18.5, 0, 0])
			cylinder(d=3, h=5.55);
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
						translate([0, i * 17.5, 2]) {
							cylinder(h=5, d=5.5, center=true);
							translate([0, 2 * i, 0])
								cube([5.5, 4, 5], center=true);
						}
					}
				}
			}
			if (is_top) {
				// Encoder
				translate([10, 16, 2.6])
					cylinder(h=2.5, d=15.5, center=true);
				// translate([17.3, 16, 2.6])
				// 	cylinder(h=2.5, d=16, center=true);

				// Rocker
				translate([-10, 16, 0.9 - 2])
					cylinder(h=2.5 + 4, d=15, center=true);

				// BOOT0 switch
				translate([-17.3, -20, 0.55 - 2])
					cube(size=[3, 10, 1.5 + 4], center=true);

				// Text
				// translate([-left_shift, -10, 5.5 - 0.5])
				// 	linear_extrude(3)
				// 		text("clock_box", size=4, font="3x3 Font for Nerds", halign="center", valign="center");
			}
			for (i=[-1, 1]) {
				// M2 screw-holes
				translate([0, i * 17.5, 0])
					cylinder(h=20, d=2.2, center=true);
				// M2 hex nut holes
				translate([0, i * 17.5, -6.5 + 1.7])
					cylinder(h=4, d=4.2 * 1.155, center=true, $fn=6);
				// Screw head holes
				translate([0, i * 17.5, 10.5 - 3.55])
					cylinder(h=10, d=4.1, center=true);
			}
		}
		split_offset = -0.4;
		translate([0, 0, is_top ? 50 + split_offset : -50 + split_offset])
			cube(size=[100, 100, 100], center=true);
	}
}

// Mock components for Preview

module screw(l=6) {
	cylinder(h=2, d=3.8);
	translate([0, 0, 2])
		cylinder(h=l, d=2.0);
}

module pcb() {
	color("yellow")
		translate([0, 0, -2])
			import("clock_box.stl");
}

// Simulate the rubber band
// for (i=[-1, 1])
// 	translate([i * 18, 0, 0.5])
// 		#cube(size=[5, 44, 11.5], center=true);



// Comment these for export
// pcb();

// translate([0, 17.5, 4])
// 	rotate([180, 0, 0])
// 		screw();


// Export the 2 shells
intersection() {
	union() {
		// enclosure2(true);
		enclosure2(false);
	}
	// translate([50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}

