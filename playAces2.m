function [theOut] = playAces2(tname,T, opt)
%%function [theOut] = playAces(tname,T)
% Plays aces file at time step and returns paramater from opt
% 
% Send:
%       tname   =       Name of aces file
%       T       =       period (hubo = 0.01) in sec
%	opt	=	option 1 = colision, 2 = velos
% Return:
%       theOut	=       dependent on opt

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

	%% Get Velos
        L = orBodyGetLinks(hubo);
        RH = 21;        % right hand shell
        RF = 36;        % right foot
        Trh = L(:,RH);  % get only the right hand pos and rot
        Trf = L(:,RF);  % get only the right foot pos and rot

        Trh = [reshape(Trh,[3,4]); 0 0 0 1];    % convert to square matrix
        Trf = [reshape(Trf,[3,4]); 0 0 0 1];    % convert to square matrix
        Tf = Trh*Trf;

        switch opt
                case 1,
                        theOut = co;
                case 2,
                        if( i == 1 )
                                x0 = [ Tf(1,4), Tf(2,4), Tf(3,4)];
                        end

                        x1 = x0;
                        x0 = [ Tf(1,4), Tf(2,4), Tf(3,4)];
                        f = x0 - x1;
                        vel(i,:) = f/T;
                        theOut = vel;
        end



end


disp('done')
end
