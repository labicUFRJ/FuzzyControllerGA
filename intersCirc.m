function [sol] = intersCirc (xr, yr, theta, xo, yo, r)

	sol = [];

	ct = cos(theta);
	st = sin(theta);

	a = 1;
	b = 2 * ((xr - xo) * ct + (yr - yo) * st);
	c = (xr - xo) ^ 2 + (yr - yo) ^ 2 - r ^ 2;

	delta = b * b - 4 * a * c;

	if (delta < -sqrt(eps))
		return;
	end;
	if (delta < 0)
		delta = 0;
	end;

	delta = sqrt(delta);

	t = (-b - delta) / (2 * a);
	if (t >= 0)
		sol(1) = xr + t * ct;
		sol(2) = yr + t * st;
		return;
	end;

	t = (-b + delta) / (2 * a);
	if (t >= 0)
		sol(1) = xr + t * ct;
		sol(2) = yr + t * st;
	end;
