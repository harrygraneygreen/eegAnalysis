clear
clc
close all

%Joint1 v = 1.25 a =4
%Joint2 v =  a =    v= 1.5 a = 5 at 65 (for 1 second of 0)
%BOM IS 84 and that 1.4 seconds per beat
initial_position = [0 0 0 90 0 0 0]; 
initial_position = initial_position;

%defines the limits of the velocity and acceleration of the panda to ensure
%it never exceeds P_phase4(n) = Strumming_pattern(2,n);
vel_max = [180 180 180 180 180 180 180]; %rad/s
a_max = [1000 1000 1000 1000 1000 1000 1000]; %rad/s^2

%sets initial position of panda (must match initial in cpp code)
%Initial_position = [0, -pi/4, 0, -3 * pi/4, 0, pi/2, pi/4];


%% Desired Inputs 
BPM = 82.5; %BPM of your song
Time_factor = 60/BPM;
a=2;
DanceStep = {[0 -110 0];[15 2 -50 0];0;[30 0 -50 0];0;0;[0 0]}; %Position of your dance step
DanceStep_t = {[1 3 2];[2 1 2 1];6;[2 1 2 1];6;6;[2 4]}; %Time IN BEATS of each one

PreTurn = {0;30;0;-30;0;0;0};
PreTurn_t = {2;2;2;2;2;2;2};

Rturn = {-45;[-10 10];0;[15 -15];0;[-20 20];0};
Rturn_t = {2;[1 1];2;[1 1];2;[1 1];2};

Lturn = {45;[-10 10];0;[15-15]; 0; [-20 20]; 0};
Lturn_t = {2;[1 1];2;[1 1];2;[1 1];2};

SwayL = {[-30 -10 -5 0];[-40 -20 20 40]; 0;[20 5 -5 -20];0;[10 5 -5 -10];0};
SwayL_t ={[1 1 1 1];[1 1 1 1];4;[1 1 1 1];4;[1 1 1 1];4};

SwayR = {0;[40 20 -20 -40]; 0;[-20 -5 5 20];0;[-10 -5 5 10];0};
SwayR_t = {4;[1 1 1 1];4;[1 1 1 1];4;[1 1 1 1];4};

Worm = {[10 -20 10];[-15 30 -15];0;[20 -40 20]; [10 0 -10];[-5 10 -5];0};
Worm_t = {[1 1 1]; [1 1 1];3;[1 1 1];[1 1 1];[1 1 1];3};

Nod = {0;0;0;[-10 10 0];0;[0 35 -35];0};
Nod_t = {2;2;2;[0.67 1 0.33];2;[0.33 0.67 1];2};


%% right robot

%% Dance time Left to right is 1 through 5

timetoreturn = 6; %Beats to return all robots at the end to home position
xarmfilename = sprintf('/Users/Maureen/Dropbox/PC/Desktop/Dances/000001BREAKDOWN.csv'); %Change to match your dance
%Users\Maureen\Dropbox\PC\Desktop\Dances
% ROW 1
%Dance Routines for each robot
num = 1;
Dance_routine1 = {PreTurn     Rturn Lturn Rturn       Lturn SwayL SwayR Worm breath(3)};
Dance_routine1_t = {PreTurn_t Rturn_t Lturn_t Rturn_t Lturn_t SwayL_t SwayR_t Worm_t breath_t(3)};

num = num+1;

Dance_routine2 = {PreTurn Lturn Lturn Rturn Rturn breath(1) SwayL SwayR Worm breath(2)};
Dance_routine2_t = {PreTurn_t Lturn_t Lturn_t Rturn_t Rturn_t breath_t(1) SwayL_t SwayR_t Worm_t breath_t(2)};

num = num+1;

Dance_routine3 = {PreTurn     Rturn   Lturn    Lturn Rturn breath(2) SwayL SwayR Worm breath(1)};
Dance_routine3_t = {PreTurn_t Rturn_t Lturn_t Lturn_t Rturn_t breath_t(2) SwayL_t SwayR_t Worm_t breath_t(1)};

num = num+1;

Dance_routine4 = {    PreTurn Rturn    Lturn Rturn Lturn breath(3) SwayL SwayR Worm};
Dance_routine4_t = {PreTurn_t Rturn_t Lturn_t Rturn_t Lturn_t breath_t(3) SwayL_t SwayR_t Worm_t};

num = num+1;

Dance_routine5 = {PreTurn      Rturn Rturn     Lturn Lturn breath(1)       SwayL SwayR Worm breath(2)};
Dance_routine5_t = {PreTurn_t Rturn_t Rturn_t Lturn_t Lturn_t breath_t(1) SwayL_t SwayR_t Worm_t breath_t(2)};

num = num+1;

% ROW 2
Dance_routine6 = {Worm Nod        Worm Nod     PreTurn Rturn Lturn       Rturn Lturn Nod Nod};
Dance_routine6_t = {Worm_t Nod_t Worm_t Nod_t PreTurn_t Rturn_t Lturn_t Rturn_t Lturn_t Nod_t Nod_t};

num = num+1;

Dance_routine7 = {PreTurn        Rturn Lturn Lturn Rturn breath(3) SwayL SwayR Worm};
Dance_routine7_t = {PreTurn_t Rturn_t Lturn_t Lturn_t Rturn_t breath_t(3) SwayL_t SwayR_t Worm_t};

num = num+1;

Dance_routine8 = {PreTurn          Rturn Rturn Lturn Lturn breath(2) SwayL SwayR Worm breath(1)};
Dance_routine8_t = {PreTurn_t Rturn_t Rturn_t Lturn_t Lturn_t breath_t(2) SwayL_t SwayR_t Worm_t breath_t(1)};

num = num+1;

%  ROW 3

Dance_routine9 = {PreTurn Rturn Lturn Rturn Lturn breath(3) SwayL SwayR Worm};
Dance_routine9_t = {PreTurn_t Rturn_t Lturn_t Rturn_t Lturn_t breath_t(3) SwayL_t SwayR_t Worm_t};

num = num+1;

Dance_routine10 = {PreTurn Rturn Lturn Lturn Rturn breath(3) SwayL SwayR Worm};
Dance_routine10_t = {PreTurn_t Rturn_t Lturn_t Lturn_t Rturn_t breath_t(3) SwayL_t SwayR_t Worm_t};



% Assigns each dance routine to a robot)IE dance routine 1 goes to robot
% 1). Can be changed based on # of robots and what robot is doing what
% routine
Dances = {Dance_routine1 Dance_routine2 Dance_routine3 Dance_routine4 Dance_routine5 Dance_routine6 ...
    Dance_routine7 Dance_routine8 Dance_routine9 Dance_routine10};

%MAKE SURE THESE MATCH
Dances_t = {Dance_routine1_t Dance_routine2_t Dance_routine3_t Dance_routine4_t Dance_routine5_t ...
    Dance_routine6_t Dance_routine7_t Dance_routine8_t Dance_routine9_t Dance_routine10_t};

numrobots = numel(Dances);

%%


%%

[Trajectory,Velocity] = TrajectoryGeneration(Dances,Dances_t,BPM,timetoreturn);

for robot = 1:numrobots
    robotpos = 7*(robot-1);
figure
for i = 1:7
    Trajectory(i+robotpos,:) = Trajectory(i+robotpos,:) + initial_position(i);
%     if i == 2 || i == 1 || i == 3
%         Trajectory(i,:) = -1*Trajectory(i,:);
%     end
    plot(Trajectory((i+robotpos),:))
    hold on
end
title('Position plot of each joint')
legend('Joint 1','Joint 2','Joint 3','Joint 4','Joint 5','Joint 6','Joint 7')

figure
for i = 1:7
    plot(Velocity(i+ robotpos,:))
    hold on
end
legend('Joint 1','Joint 2','Joint 3','Joint 4','Joint 5','Joint 6','Joint 7')
title('Velocity plot of each joint')


%pause
end
final_position_db = transpose(Trajectory);
final_position = final_position_db(1:6:end,:);

delete(xarmfilename);
csvwrite(xarmfilename,final_position);

final_trajectory = Velocity;
final_trajectory = transpose(final_trajectory);
%csvwrite(pandafilename,final_trajectory);



function [dance,dance_t] = delaymod(robotnum,wave_wait,step,step_t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for k =1:robotnum
    step_t{1} = -1*center_angles(k);
    for i =1:7
    if k ==1
        Move{k}{i}=[step{i} 0];
        Move_t{k}{i} = [step_t{i} wave_wait*(robotnum-1)];
    elseif k == robotnum
        Move{k}{i}=[0 step{i}];
        Move_t{k}{i} = [wave_wait*(robotnum-1) step_t{i}];
    else
        Move{k}{i}= [0 step{i} 0];
        second_wait = wave_wait*(robotnum-1)- wave_wait*(k-1);
        Move_t{k}{i}=[wave_wait*(k-1) step_t{i} second_wait];
    end
    

    end
end
dance = transpose(Move);
dance_t = transpose(Move_t);
end

function [traj] = breath(dur)

move = [];
repeats = floor(dur/4);
remainder = mod(dur,4);
for j = 1:2*repeats
    move(j) = (-1)^j*2;
end
if dur<4
    traj = {0;0;0;0;0;0;0};
else
    traj = {0;[0 -move];0;-move;0;0;0};
end

end

function [traj_t] = breath_t(dur)



if dur<4
    traj_t = {dur;dur;dur;dur;dur;dur;dur};
else
    repeats = floor(dur/4);
    remainder = mod(dur,4);
    move = zeros(1,2*repeats)+2;
    move4 = move;
    move4(2*repeats) = 2+remainder;
    move(2*repeats) = 1.5+remainder;
    traj_t = {dur;[0.5 move];dur;move4;dur;dur;dur};
end

end