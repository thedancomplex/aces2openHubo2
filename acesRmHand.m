function [h,d] = acesRmHand(h, d)


try

	addpath('huboJointConstants');
	huboJointConst;
	i = find( h == 70 );

	im = i-1;
	iM = i+1;

	L = length(h);
	r1 = [];
	r2 = [];
	if (iM < length(h))
		r1 = 1:im;
		r2 = im:L;
	else
		r1 = 1:im;
		r2 = [];
	end

	h = [h(r1),h(r2)];
	d = [d(:,r1),d(:,r2)];
catch exception
	h = h;
	d = d;
end



%h = [h(r1),h(r2)];
%d = [d(:,r1),d(:,r2)];
end
