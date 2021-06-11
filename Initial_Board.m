function board = Initial_Board(board)

Boardrow = size(board.Status,1);
Boardcol = size(board.Status,2);
nutsCounter = 0;

for i=1:Boardrow
    for j=1:Boardcol
        if i ~= 4 && i ~= 5
            if mod(i+j,2) == 1
                if i<=3
                    board.Status(i,j) = 1;
                else
                    board.Status(i,j) = 2;
                end
                nutsCounter = nutsCounter + 1;
                board = Initial_Nuts(i,j,nutsCounter,board);
            end
        else
            board.Status(i,j) = 0;
        end
    end
end

end

function board = Initial_Nuts(i,j,nutsCounter,board)
    board.Nuts(nutsCounter).Position.X = i;
    board.Nuts(nutsCounter).Position.Y = j;

    board.Nuts(nutsCounter).Type = 0; % Man
if i <= 3
    board.Nuts(nutsCounter).Status = 1;% White
else
    board.Nuts(nutsCounter).Status = 2;% Black
end
    board.Nuts(nutsCounter).IsThreated = 0;
end