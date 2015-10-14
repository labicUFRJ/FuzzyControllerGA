function [output] = sensorRayCast (environ, robot, sensor)

	output.angle = sensor.angle;

	rX = robot.x;
	rY = robot.y;
	rR = robot.r;

	phi = robot.phi + sensor.angle;

	while (phi < -180),
		phi = phi + 360;
	end;
	while (phi > 180),
		phi = phi - 360;
	end;

	output.dist = inf;

	phi = deg2rad(phi);
	cosPhi = cos(phi);
	sinPhi = sin(phi);

	if (abs(sinPhi) > sqrt(eps))
		% Parede superior
		t = (100 - rY) / sinPhi;
		if (t >= 0)
			xP = rX + t * cosPhi;
			if ((xP >= 0) & (xP <= 400))
				output.dist = min(output.dist, calcDist(rX, rY, xP, 100));
			end;
		end;

		% Parede inferior
		t = (0 - rY) / sinPhi;
		if (t >= 0)
			xP = rX + t * cosPhi;
			if ((xP >= 0) & (xP <= 400))
				output.dist = min(output.dist, calcDist(rX, rY, xP, 0));
			end;
		end;
	end;

	if (abs(cosPhi) > sqrt(eps))
		% Parede esquerda
		t = (0 - rX) / cosPhi;
		if (t >= 0)
			yP = rY + t * sinPhi;
			if ((yP >= 0) & (yP <= 100))
				output.dist = min(output.dist, calcDist(rX, rY, 0, yP));
			end;
		end;

		% Parede direita
		t = (400 - rX) / cosPhi;
		if (t >= 0)
			yP = rY + t * sinPhi;
			if ((yP >= 0) & (yP <= 100))
				output.dist = min(output.dist, calcDist(rX, rY, 400, yP));
			end;
		end;
	end;

	% Obstaculos
	obst = environ.obst;
	numObst = length(obst);
	for i = 1:numObst,
		inters = intersCirc(rX, rY, phi, obst{i}.x, obst{i}.y, obst{i}.r);
		if (~isempty(inters))
			output.dist = min(output.dist, calcDist(rX, rY, inters(1), inters(2)));
		end;
	end;
