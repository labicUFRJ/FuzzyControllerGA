function [environ] = environCreate (arg1, arg2)

	rR = 6;

	environ.funcInit = 'environInit';
	environ.funcStep = 'environStep';
	environ.funcTerm = 'environTerm';
	environ.maxSteps = 500;
	environ.limX = [0 200];
	environ.limY = [0 100];

	if (ischar(arg1))
		allObst = load(arg1);
		if (nargin == 1)
			arg2 = round(randAB(1, length(allObst.obst)));
		end;
		arg1 = allObst.obst{arg2};
	end;

	if (length(arg1) == 1)
		n = arg1;
		for i = 1:n,
			environ.obst{i}.r = rR / 2;
			environ.obst{i}.x = environ.limX(1) + environ.obst{i}.r + 2 * rR + rand * (environ.limX(2) - environ.limX(1) - 2 * environ.obst{i}.r - 2 * rR);
			environ.obst{i}.y = environ.limY(1) + environ.obst{i}.r + 2 * rR + rand * (environ.limY(2) - environ.limY(1) - 2 * environ.obst{i}.r - 2 * rR);
		end;
	else
		n = size(arg1, 1);
		for i = 1:n,
			environ.obst{i}.r = rR / 2;
			environ.obst{i}.x = arg1(i, 1);
			environ.obst{i}.y = arg1(i, 2);
		end;
	end;
