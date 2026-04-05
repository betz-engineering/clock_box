$fn = $preview ? 30 : 150;

// centered on XY only
module cube_(size=[1, 1, 1])
	translate([-size[0] / 2, -size[1] / 2, 0])
		cube(size);

color("green")
	cube_(size=[38, 12, 1.6]);

color("black")
	translate([1.0, 0, 1.6])
		cube_(size=[30, 11.5, 0.5]);

color("yellow")
	translate([-0.71, 0.78, 1.6 + 0.41])
		cube_(size=[22.38, 5.58, 0.1]);
