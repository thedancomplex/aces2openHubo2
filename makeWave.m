clear all
close all

%% add to path
addpath('recordAces');
addpath('huboJointConstants');
%% test
%% Load constants
huboJointConst

%% Sampling Rate
T = 0.01;


fname = '2012-04-26_Wave.pts';

[h, d] = readAces(fname);

[h1, d1] = smoothAces(h,d,5);
h1t = [];
for( i = 1:length(h1) )
	h1t{i} = jn{h1(i)+1};
end

[h2, d2] = changeJointOrder(h1t,d1);
wname = recordAces(h2,d2,[fname,'.main']);
hpWname = recordHuboP(h2,d2,[fname,'.main']);	%% huboP traj

v = playAces2(wname,T,2);
