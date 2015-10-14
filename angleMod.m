function [ang] = angleMod (ang)

	while (ang < -180),
		ang = ang + 360;
	end;
	while (ang > 180),
		ang = ang - 360;
	end;
