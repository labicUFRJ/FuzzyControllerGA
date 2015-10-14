function [ui, terminate] = uiPlotStep (ui, environ, robot)

	global contrPoint contrPInd;

	terminate = 0;

	numRobot = length(environ.robot);
	for i = 1:numRobot,
		plotCircle(environ.robot{i}.x, environ.robot{i}.y, environ.robot{i}.r, 'b');
		numSensor = length(environ.robot{i}.sensor);
		if (ui.drawSensors)
			for j = 1:numSensor,
				if (strcmp(environ.robot{i}.sensor{j}.func, 'sensorRayCast')),
					if (isfield(ui.robot{i}.sensor{j}, 'handle'))
						delete(ui.robot{i}.sensor{j}.handle);
					end;
					[sx, sy] = pol2cart(deg2rad(environ.robot{i}.phi + robot{i}.sensor{j}.angle), robot{i}.sensor{j}.dist);
					ui.robot{i}.sensor{j}.handle = plot([environ.robot{i}.x (environ.robot{i}.x + sx)], [environ.robot{i}.y (environ.robot{i}.y + sy)]);
				end;
			end;
		end;
		if (~isempty(contrPoint))
			if (isfield(ui.robot{i}, 'point'))
				delete(ui.robot{i}.point.handle);
			end;
			p1 = contrPoint;
			p1(:, 1) = p1(:, 1) + deg2rad(environ.robot{i}.phi);
			[rpx rpy] = pol2cart(p1(:, 1), p1(:, 2));
			ui.robot{i}.point.handle = plot(rpx + environ.robot{i}.x, rpy + environ.robot{i}.y, 'g.');
		end;
		if (~isempty(contrPInd))
			if (isfield(ui.robot{i}, 'pInd'))
				delete(ui.robot{i}.pInd.handle);
			end;
			p1 = contrPoint(contrPInd, :);
			p1(:, 1) = p1(:, 1) + deg2rad(environ.robot{i}.phi);
			[rpx rpy] = pol2cart(p1(:, 1), p1(:, 2));
			ui.robot{i}.pInd.handle = plot(rpx + environ.robot{i}.x, rpy + environ.robot{i}.y, 'y.');
			ui.robot{i}.pInd.handle(end + 1) = plot(rpx(2) + environ.robot{i}.x, rpy(2) + environ.robot{i}.y, 'm.');
		end;

		if (isfield(ui, 'robot'))
			if (isfield(ui.robot{i}, 'front'))
				delete(ui.robot{i}.front);
			end;
		end;
		[fx, fy] = pol2cart(deg2rad(environ.robot{i}.phi), 2 * robot{i}.r);
		ui.robot{i}.front = plot([fx + environ.robot{i}.x, environ.robot{i}.x], [fy + environ.robot{i}.y, environ.robot{i}.y], 'k');
	end;

	if (ui.pause >= 0)
		pause(ui.pause);
	end;
