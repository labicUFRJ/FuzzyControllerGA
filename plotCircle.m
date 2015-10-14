function [handle] = plotCircle (x, y, r, cor)

	theta = linspace(0, 2 * pi, 16);

	x = x + r * cos(theta);
	y = y + r * sin(theta);
	
	handle = plot(x, y, cor);
