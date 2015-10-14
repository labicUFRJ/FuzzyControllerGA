function [robot, action] = robotRandomStep (robot, sensor)

	[d, phi] = robotPreProcessor(sensor);

	theta = randAB(-15, 15);
	stepSize = 1.3;

	[action] = robotSetThetaStep(theta, stepSize);

	robot.sensor = sensor;
