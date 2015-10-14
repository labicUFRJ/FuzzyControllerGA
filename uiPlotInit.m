function [ui] = uiPlotInit (ui, environ, robot)

	xS = environ.limX(1);
	xE = environ.limX(2);
	yS = environ.limY(1);
	yE = environ.limY(2);

	figure;

	plot([xS xE xE xS xS], [yS yS yE yE yS], 'k');

	hold on;

	axis([xS xE yS yE]);

	h = gcf;
	fp = get(h, 'Position');
	fp(1) = fp(1) + (fp(3) / 2);
	fp(3) = fp(3) * 2;
	fp(1) = fp(1) - (fp(3) / 2);
	set(h, 'Position', fp);

	obst = environ.obst;
	numObst = length(obst);
	for i = 1:numObst,
		plotCircle(obst{i}.x, obst{i}.y, obst{i}.r, 'r');
	end;

	numRobot = length(environ.robot);
	for i = 1:numRobot,
		numSensor = length(environ.robot{i}.sensor);
		if (ui.drawSensors)
			for j = 1:numSensor,
				if (strcmp(environ.robot{i}.sensor{j}.func, 'sensorRayCast'))
					ui.robot{i}.sensor{j} = [];
				end;
			end;
		end;
	end;
