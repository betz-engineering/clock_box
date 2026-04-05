$fn = $preview ? 30 : 150;

// centered on XY only
module cube_(size=[1, 1, 1])
	translate([-size[0] / 2, -size[1] / 2, 0])
		cube(size);

translate([0, 0, -11 / 2]) {
	cylinder(h=11, d=5.2, center=true);
	cylinder(h=9, d=6.35, center=true);
}

cube_(size=[6.5, 6.5, 1.5]);

for (i=[-1, 1])
	for (j=[-1, 1])
		translate([5.1 / 2 * i, 2.5 * (j - 1) / 2, 1.5])
			cube_([0.9, 0.9, 4]);

translate([0, 0, 1.5])
	cylinder(h=4, d=0.9);
