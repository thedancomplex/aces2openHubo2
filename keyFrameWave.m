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

%% initial hubo and world setup
% huboOpenRAVEsetup

%% enable the robot
%orBodyEnable(hubo,1)

%% load the recorded frame data

load record_wave1;

d = deg;

desSec = 4;
nstep = desSec/T;
n = floor(nstep);

for( i = 1:n )

	deg(i,:) = d;

end


s = size(deg);


%% change to the propper sign
for( i = 1:s(2) )
	deg(:,i) = deg(:,i)*orDir(mDes(i)+1);
end

%% make motor names
mo = {};
for(i = 1:length(mDes))
	ii = mDes(i) + 1;
	mo{i} = jn{ii};
end



%% this is where we add our waving motions
da = deg;

%% add wave
[mo, da] = addWave(mo,da,T);

[mo, da] = smoothAces(mo,da,5);
[mo, da] = smoothAces(mo,da,5);
[mo, da] = smoothAces(mo,da,5);
[mo, da] = smoothAces(mo,da,5);
[ms, ds] = traj2setup(mo,da,300);


%% reorder
[mo, da] = changeJointOrder(mo, da);
[ms, ds] = changeJointOrder(ms, ds);

fname = 'huboWave';
sname = recordAces(ms,ds,[fname,'.setup']);
tname = recordAces(mo,da,[fname,'.main']);
snameH = recordHuboP(ms,ds,[fname,'.setup']);
tnameH = recordHuboP(mo,da,[fname,'.main']);
theOut = playAces(tname,T);

%playAces(sname,T);
%playAces(tname,T);

[h, d] = readAces(tname);




%% pos
figure
plot(d)
title('position')

