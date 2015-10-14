function [environ] = environInit (environ)

	environ.steps = 0;

	global contrMem contrPoint contrPInd;
	contrMem = [];
	contrPoint = [];
	contrPInd = [];

	global termStatus;
	termStatus.colideWall = 0;
	termStatus.colideObst = 0;
	termStatus.maxSteps = 0;
	termStatus.success = 0;
