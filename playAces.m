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
[h, d] = acesRmFrame(h,d);

sAces = size(d);

%% the joints used
di = h(1:(length(h))) + 1;

%% colision matrix
co = [];

input('Set Video Settings then press ENTER');

for( i = 1:sAces(1) )
	disp(num2str(i))
	%% get deg values
	deg = d(i,:);

	%% set correct directions
	deg = deg.*orDir(di);

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
	disp('e')

end


disp('done')
end
