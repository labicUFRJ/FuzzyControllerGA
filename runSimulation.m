function[robotEnviron] = runSimulation (environ, robot) %, ui)
	numRobot = length(robot);
	%numUI = length(ui);

	for i = 1:numRobot,
		environ.robot{i} = robot{i};
		[robot{i}] = feval(robot{i}.funcInit, robot{i});
	end;
	[environ] = feval(environ.funcInit, environ);
% 	for i = 1:numUI,
% 		[ui{i}] = feval(ui{i}.funcInit, ui{i}, environ, robot);
% 	end;

	while (1),
		for i = 1:numRobot,
			numSensor = length(environ.robot{i}.sensor);
			sensor = cell(0, 1);
			for j = 1:numSensor,
				[sensor{j}] = feval(environ.robot{i}.sensor{j}.func, environ, environ.robot{i}, environ.robot{i}.sensor{j});
			end;
			[robot{i}, action] = feval(robot{i}.funcStep, robot{i}, sensor);
			numAction = length(action);
			for j = 1:numAction,
				[environ, tempRobot] = feval(action{j}.func, environ, environ.robot{i}, action{j});
				environ.robot{i} = tempRobot;
			end;
		end;

		terminate = 0;
% 		for i = 1:numUI,
% 			[ui{i}, terminate] = feval(ui{i}.funcStep, ui{i}, environ, robot);
% 			if (terminate)
% 				break;
% 			end;
% 		end;
        
		if (terminate)
			terminate = 3;
			break;
		end;

		[environ, terminate] = feval(environ.funcStep, environ);
		
        if (terminate)
			terminate = 2;
			break;
		end;
	end;

%	if (terminate ~= 3)
%		for i = 1:numUI,
%			[ui{i}] = feval(ui{i}.funcStep, ui{i}, environ, robot);
%		end;
%	end;

	for i = 1:numRobot,
		[robot{i}] = feval(robot{i}.funcTerm, robot{i});
	end;
	[environ] = feval(environ.funcTerm, environ);
% 	for i = 1:numUI,
% 		[ui{i}] = feval(ui{i}.funcTerm, ui{i}, environ, robot);
% 	end;
    robotEnviron = environ.robot;
