function [environ, robot] = actionSetStep (environ, robot, action)

	robot.step = action.step;
