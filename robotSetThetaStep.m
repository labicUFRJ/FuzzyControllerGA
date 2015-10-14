function [action] = robotSetThetaStep (theta, stepSize)

	global contrMem;

	contrMem(end).theta = theta;
	action{1}.func = 'actionSetTheta';
	action{1}.theta = theta;

	contrMem(end).step = stepSize;
	action{2}.func = 'actionSetStep';
	action{2}.step = stepSize;
