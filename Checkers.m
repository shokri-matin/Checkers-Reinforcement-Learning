close all;
clear all;
clc;

%% Initialization 

nPlaye = 10;
nMove = 100;
% Initial Parameters

Nut.Position.X = []; % X Position
Nut.Position.Y = []; % Y Position
Nut.Type = [];     % Man Or KingMan
Nut.Status = [];   % White or Black
Nut.IsThreated = [];

Board.Status = zeros(8,8);
Board.Nuts = repmat(Nut,1,24);
Board.Cost = [];

Successor.Boards = [];
Successor.nThreated_white = [];
Successor.nThreated_black = [];

etha = 0.001;
beta=8;

% Initial Weights
W = rand([1 7]);

for j=1:nPlaye
    % Initial Board
    Board = Initial_Board(Board);

    %% Main Loop
    % Successor Of Red's Moves
    Succ = Get_Successors(Board,1);
    Succ = Evaluation(Succ,W);

    % Sort Successors
    Evals=[Succ.Boards.Cost];
    [Evals, SortOrder]=sort(Evals);
    Succ.Boards = Succ.Boards(SortOrder);


    for i=1:nMove
        v_hat = V(Board,Succ.nThreated_white,Succ.nThreated_black,W);
        if ~isempty(Succ.Boards)
            % Move Red [Best Move]
            % Calculate Selection Probabilities
            P=exp(-beta*[Succ.Boards.Cost]/Succ.Boards(end).Cost);
            P=P/sum(P);
            ri = RouletteWheelSelection(P);
            if j == 10
                Show_Game_Space(Succ.Boards(ri)); 
                pause(1);
            end
            % Successor Of Blue's Moves
            Succ = Get_Successors(Succ.Boards(ri),2);
        end
        if ~isempty(Succ.Boards)
            % Move Blue [Random Player]
            index = randi(numel(Succ.Boards));
            if j == 10
                Show_Game_Space(Succ.Boards(index));
                pause(1);
            end
            % Successor Of Red's Moves
            Succ = Get_Successors(Succ.Boards(index) ,1);
            if ~isempty(Succ.Boards)
                Succ = Evaluation(Succ,W);
                Evals=[Succ.Boards.Cost];

                [Evals, SortOrder] =sort(Evals);
                Succ.Boards = Succ.Boards(SortOrder);

                v_train = V(Succ.Boards(1),Succ.nThreated_white,Succ.nThreated_black,W);

                % Update W
                W = Update_W( Succ.Boards(1),Succ.nThreated_white,Succ.nThreated_black, W, v_hat, v_train, etha );
                Board = Succ.Boards(1);
            else
                break;
            end
        end
    end
    disp(['End Of Training Game ' num2str(j)]);
end
disp('End Of Game');
