module oled() {
	color("green")
		translate([0, 0, 1.2 / 2])
			cube(size=[38, 12, 1.2], center=true);

	color("black")
		translate([2, 0, 1.2 + 1.15 / 2])
			cube(size=[30, 11.5, 1.15], center=true);

	color("yellow")
		translate([1-0.71, 0.78, 1.2 + 1.15 + 0.5 / 2])
			cube(size=[22.38, 5.58, 0.5], center=true);

	for(i=[0:3])
		translate([-19 + 1.25, (i - 1.5) * 2.54, -1.75]) {
			cube(size=[0.6, 0.6, 7], center=true);
			color("black")
				translate([0, 0, 0.6])
					cube(size=[2.5, 2.5, 2.3], center=true);
		}
}
