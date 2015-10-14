function [d, phi] = robotPreProcessor (sensor)

	global contrMem contrPoint contrPInd;

	contrMem(end + 1).d1 = sensor{1}.dist;
	contrMem(end).d2 = sensor{2}.dist;
	contrMem(end).d3 = sensor{3}.dist;
	contrMem(end).phi = sensor{4}.phi;

	if (length(contrPoint) > 0)
		diffPhi = contrMem(end).phi - contrMem(end - 1).phi;

		p1 = contrPoint;
		p1(:, 1) = p1(:, 1) - deg2rad(diffPhi);
		[p1(:, 1) p1(:, 2)] = pol2cart(p1(:, 1), p1(:, 2));
		p2 = p1;
		p2(:, 1) = p1(:, 1) - contrMem(end - 1).step;
		p1 = p2;
		[p2(:, 1) p2(:, 2)] = cart2pol(p2(:, 1), p2(:, 2));
		contrPoint = p2;
		for i = 1:3,
			[p(1) p(2)] = pol2cart(deg2rad(sensor{i}.angle), sensor{i}.dist);
			d = (p(1) - p1(:, 1)) .^ 2 + (p(2) - p1(:, 2)) .^ 2;

			if (min(d) > (3 ^ 2))
				contrPoint(end + 1, 1) = deg2rad(sensor{i}.angle);
				contrPoint(end, 2) = sensor{i}.dist;
			end;
		end;
	else
		for i = 1:3,
			contrPoint(end + 1, 1) = deg2rad(sensor{i}.angle);
			contrPoint(end, 2) = sensor{i}.dist;
		end;
	end;

	interv = deg2rad([15 105; -15 15; -105 -15]);

	p1 = contrPoint;
	d = [];
	for i = 1:3,
		ind = find((p1(:, 1) >= interv(i, 1)) & (p1(:, 1) <= interv(i, 2)));
		if (isempty(ind))
			d(i) = sensor{i}.dist;
			contrPInd(i) = 1;
		else
			[d(i), contrPInd(i)] = min(p1(ind, 2));
			contrPInd(i) = ind(contrPInd(i));
			d(i) = p1(contrPInd(i), 2);
		end;
	end;

	contrMem(end).m3d = d;

	d1 = d(1);
	d2 = d(2);
	d3 = d(3);
	phi = sensor{4}.phi;
