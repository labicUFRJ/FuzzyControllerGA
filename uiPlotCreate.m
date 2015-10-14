function [ui] = uiPlotCreate (uiPause, drawSensors)

	ui{1}.funcInit = 'uiPlotInit';
	ui{1}.funcStep = 'uiPlotStep';
	ui{1}.funcTerm = 'uiPlotTerm';

	ui{1}.pause = uiPause;
	ui{1}.drawSensors = drawSensors;
