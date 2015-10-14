function [robot] = robotCreate (x0, y0, phi0, rtype)

	robot{1}.funcInit = ['robot' rtype 'Init'];
	robot{1}.funcStep = ['robot' rtype 'Step'];
	robot{1}.funcTerm = ['robot' rtype 'Term'];

	robot{1}.r = 6;
	robot{1}.x = x0;
	robot{1}.y = y0;
	robot{1}.phi = phi0;

	robot{1}.theta = 0;
	robot{1}.step = 1.3;

	robot{1}.sensor = {};

	robot{1}.sensor{end + 1}.func = 'sensorRayCast';
	robot{1}.sensor{end}.angle = 15;

	robot{1}.sensor{end + 1}.func = 'sensorRayCast';
	robot{1}.sensor{end}.angle = 0;
	
	robot{1}.sensor{end + 1}.func = 'sensorRayCast';
	robot{1}.sensor{end}.angle = -15;

	robot{1}.sensor{end + 1}.func = 'sensorGetPhi';

	global contrMem;
	contrMem = [];

	global contrPoint contrPInd;
	contrPoint = [];
	contrPInd = [];
