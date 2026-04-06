$fn = $preview ? 30 : 150;

include <roundedcube.scad>

module pcb() {
	color("yellow")
		translate([-43 / 2 - 0.3, 0, -2])
			import("clock_box.stl");
}


module enclosure() {
	w_shell = 1.5;
	// o_x = 48;
	o_x = 46.5;
	o_y = 43;
	o_z = 10;

	// Makes the casing thickness assymetric in y-direction
	left_shift = 2.5;

	difference() {
		translate([-left_shift / 2, 0, -4.5]) {
			roundedcubez_(size=[o_x + 4 - left_shift, o_y, o_z], radius=3);
			// translate([0, -o_y / 2, 0])
			// 	cube(size=[(o_x + 4 - left_shift) / 2, o_y / 2, o_z]);
		}

		// Hollow it out
		translate([0, 0, -3.5])
			roundedcubez_(size=[o_x - w_shell * 2, 40.5, 8], radius=3);

		// OLED
		translate([1.96, 0, 0])
			roundedcubez_(size=[23, 7, 10], radius=1.5);

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

		// Rocker
		translate([-10, 16, 0.9])
			cylinder(h=2.5, d=15, center=true);

		// Encoder
		translate([10, 16, 2.6])
			cylinder(h=2.5, d=16, center=true);
		// translate([17.3, 16, 2.6])
		// 	cylinder(h=2.5, d=16, center=true);

		// BOOT0 switch
		translate([-17.3, -20, 0.55])
			cube(size=[3, 10, 1.5], center=true);

		// Power LED
		translate([-18.5, 0, 0])
			cylinder(d=3, h=5.55);

	}

	// bottom plate
	translate([0, 0, -3])
		cube(size=[34, o_y - w_shell, 1.5], center=true);
}


// Simulate the rubber band
// for (i=[-1, 1])
// 	translate([i * 18, 0, 0.5])
// 		#cube(size=[5, 44, 11.5], center=true);


// Preview
pcb();
intersection() {
	enclosure();
	// translate([0, 0, -50])
	// 	cube(size=[100, 100, 100], center=true);
}


// Export the 2 shells
// intersection() {
// 	enclosure();
// 	translate([0, 0, 50])
// 		cube(size=[100, 100, 100], center=true);
// }
