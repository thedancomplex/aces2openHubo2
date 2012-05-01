function[h, d] = addWave(H, D, T)


%% add to path
addpath('recordAces');
addpath('huboJointConstants');
%% test
%% Load constants
huboJointConst


h = H;


s = size(D);

st = s(1);		%% number of time steps
sh = s(2);		%% number of actuators

t = 0:T:(st*T-T);


%% Fast Wave
ff = 0.5;
fw = ff*2*pi;
fs = sin(fw*t)';

%% Slow wave

sf = 0.25;
sw = sf*2*pi;
ss = sin(sw*t)';


%%------------------------
%%---[Left]---------------
%%------------------------
%% add to LSY
i = strcmp(H,'LSY');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.5*fs;

%% add to LSR
i = strcmp(H,'LSR');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.2*fs;

%% add to LWY
i = strcmp(H,'LWY');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.5*fs;

%% add to LEB
i = strcmp(H,'LEB');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;

%% add to LSP
i = strcmp(H,'LSP');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;


%%------------------------
%%---[Right]--------------
%%------------------------
%% add to RSY
i = strcmp(H,'RSY');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;

%% add to RSR
i = strcmp(H,'RSR');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;

%% add to REB
i = strcmp(H,'REB');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;

%% add to RSP
i = strcmp(H,'RSP');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.1*fs;



%% add to WST
i = strcmp(H,'WST');
i = min(find(i==1));
D(:,i) = D(:,i) + 0.5*ss;


d = D;
