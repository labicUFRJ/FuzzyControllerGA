function [r] = randAB (a, b)

	if (a > b)
		t = a;
		a = b;
		b = t;
	end;

	d = b - a;

	r = a + d * rand(1);
