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
	o_y = 43.5;
	o_z = 10;

	difference() {
		translate([-1, 0, -4.5])
			roundedcubez_(size=[o_x + 2, o_y, o_z], radius=3);

		// Hollow it out
		translate([0, 0, -3.5])
			roundedcubez_(size=[o_x - w_shell * 2, o_y - w_shell * 2, 8], radius=3);

		// OLED
		translate([1.96, 0, 0])
			roundedcubez_(size=[23, 7, 10], radius=1.5);

		// USB
		translate([o_x / 2 - 7, -11.5, 1.3])
			rotate([90, 0, 90])
				roundedcubez_(size=[9.5, 4, 10], radius=1.5);

		// SMA
		for (i=[-1, 1])
			translate([-o_x / 2, 11.5 * i, 0])
				rotate([90, 0, 90]) {
					cylinder(h=10, d=6.7, center=true);
					translate([0, 0, 2.5])
						cube([7, 7, 5], center=true);
				}

		// Rocker
		translate([-9.5, 15.5, 0.9])
			cylinder(h=2.5, d=16, center=true);

		// Encoder
		translate([13.2, 15.5, 2.6])
			cylinder(h=2.5, d=16, center=true);
	}
}

pcb();

intersection() {
	union() {
		enclosure();
	}
	// translate([0, 50, 0])
	// 	cube(size=[100, 100, 100], center=true);
}


