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
load record_ThrowR2;

s = size(deg);

tSec 	=  	1.0;
nstep 	= 	tSec/T;
n 	= 	floor(nstep);
da 	= 	[];
d = [];
for( i = 0:(s(1)-2))

	for(j = 1:n)
		ii = i*n+j;
		dv = (deg(i+2,:) - deg(i+1,:))/n;
		dp = deg(i+1,:); 
		da(ii,:) =  dp + dv*j;
		
		for iii = 1:length(mDes)
			da(ii,iii) = da(ii,iii)*orDir(mDes(iii)+1);
		end
	end
	d(i+1,:) = deg(i+1,:);
	for iii = 1:length(mDes)
		d(i+1,iii) = d(i+1,iii)*orDir(mDes(iii)+1);
%%		da(i+1,iii) = da(i+1,iii)*orDir(mDes(iii)+1);
	end
end

mo = {};
for(i = 1:length(mDes))
	ii = mDes(i) + 1;
	
	mo{i} = jn{ii};
end



[mo, da] = smoothAces(mo,da,50);
[ms, ds] = traj2setup(mo,da,300);


fname = 'huboThrowR2';
sname = recordAces(ms,ds,[fname,'.setup']);
tname = recordAces(mo,da,[fname,'.main']);
%theOut = playAces(tname,T);

%playAces(sname,T);
%playAces(tname,T);

[h, d] = readAces(tname);




%% pos
figure
plot(d)
title('position')

%% velos
figure 
plot(diff(d)/T)
title('velos');


velot = playAces2(tname,T,2);
v = sum((velot.^2)');
figure
plot((1:length(v))*T,v);
xlabel('Time (sec)');
ylabel('Speed (m/sec)');
title('speed graph of right hand in reference to right foot');

figure
plot(da)
xlabel('Time (sec)')
ylabel('Pos (rad)')
title('position of all joints')

figure
dda = diff(da)/T;
plot(dda);
xlabel('Time (sec)')
ylabel('Velocity (rad/sec)');
title(['Velocity of all joints at Multiplyer = ',num2str(rat)]);

figure
ddda = diff(dda)/T;
plot(ddda);
xlabel('Time (sec)')
ylabel('Accelleration (rad/sec^2)');
title(['Accelleration of all joints at Multiplyer = ',num2str(rat)]);

