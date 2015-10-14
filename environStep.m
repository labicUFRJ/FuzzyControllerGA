function [environ, terminate] = environStep (environ)

	global termStatus;

	terminate = 0;

	obst = environ.obst;
	numObst = length(obst);

	robot = environ.robot;
	numRobot = length(robot);

	for i = 1:numRobot,
		if ((robot{i}.x - robot{i}.r) < environ.limX(1))
			terminate = 1;
			termStatus.colideWall = 1;
			return;
		end;
		if ((robot{i}.x + robot{i}.r) > environ.limX(2))
			terminate = 1;
			termStatus.success = 1;
			return;
		end;
		if ((robot{i}.y - robot{i}.r) < environ.limY(1))
			terminate = 1;
			termStatus.colideWall = 1;
			return;
		end;
		if ((robot{i}.y + robot{i}.r) > environ.limY(2))
			terminate = 1;
			termStatus.colideWall = 1;
			return;
		end;
		for j = 1:numObst,
			if (calcDist(robot{i}.x, robot{i}.y, obst{j}.x, obst{j}.y) < (robot{i}.r + obst{j}.r))
				terminate = 1;
				termStatus.colideObst = 1;
				return;
			end;
		end;
	end;

	environ.steps = environ.steps + 1;
	if (environ.steps >= environ.maxSteps)
		terminate = 1;
		termStatus.maxSteps = 1;
		return;
	end;

	for i = 1:numRobot,
		robot{i}.phi = angleMod(robot{i}.phi + robot{i}.theta);
		phiRad = pi * (robot{i}.phi / 180);
		robot{i}.x = robot{i}.x + robot{i}.step * cos(phiRad);
		robot{i}.y = robot{i}.y + robot{i}.step * sin(phiRad);
	end;
	environ.robot = robot;
