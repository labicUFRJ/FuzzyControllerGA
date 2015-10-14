function [robot, action] = robotManualStep (robot, sensor)

	[d, phi] = robotPreProcessor(sensor);

	Y = evalfis([d(1) d(2) d(3) phi], robot.fis);

	theta = Y(1);
	stepSize = Y(2);

	[action] = robotSetThetaStep(theta, stepSize);

	robot.sensor = sensor;
