function [co] = playAces(tname,T)
%%function [co] = playAces(tname,T)
% Plays aces file at time step and returns paramater from opt
% 
% Send:
%       tname   =       Name of aces file
%       T       =       period (hubo = 0.01) in sec
%
% Return:
%       co	=       colision matrix

%% init vlaues
theOut  =       [];

huboOpenRAVEsetup;

addpath('recordAces');

[h, d] = readAces(tname);
disp(num2str(h))
%[h, d] = acesRmFrame(h, d);

%[h, d] = acesRmHand(h, d);

if(sum(find(h == 99)) > 0 | sum(find(h == 70)) > 0)
	s = length(h);
	h = h(1:(s-1));
	d = d(:,(1:(s-1)));
end


disp(num2str(h));
disp(num2str(d));
sAces = size(d);

%% the joints used
di = h(1:(length(h)));

%% colision matrix
co = [];

input('Set Video Settings then press ENTER');

for( i = 1:sAces(1) )
	%% get deg values
	deg = d(i,:);

	%% set correct directions
	deg = deg.*orDir(di+1);

	%% set robot
	orRobotSetDOFValues(hubo,deg, di);

        %% step simulation
        orEnvStepSimulation(T,1);
        envTimeOut = orEnvWait(hubo,5);
        orBodyEnable(hubo,1)

	%% check for collisions ( 0 = no colisiions, 1 = yes)
        c = orRobotCheckSelfCollision(hubo);

        %% set colisions here
	if( c == 0 )
                %% do here if there is no colision
                co(i) = 0;
        else
                co(i) = 1;
        end

end


disp('done')
end
