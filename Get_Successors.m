function Successor = Get_Successors(board,turn)

    Successor.Boards = [];
    Successor.nThreated_white = [];
    Successor.nThreated_black = [];
    
    global numberOf_Threated_whiteNuts;
    global numberOf_Threated_blackNuts;
    numberOf_Threated_whiteNuts = 0;
    numberOf_Threated_blackNuts = 0;
    
    nuts = board.Nuts([board.Nuts.Status] == turn);
    nutsLength = numel(nuts);

    for i=1:nutsLength

        % Man Or King Man
        nut = nuts(i);
        if nuts(i).Type == 0
            % Man 
            if turn == 1
                % White
                Successor.Boards = [Successor.Boards MoveDR(board,nut)]; % Move Down-Right
                Successor.Boards = [Successor.Boards MoveDL(board,nut)]; % Move Down-Left
            else
                % Black
                Successor.Boards = [Successor.Boards MoveUR(board,nut)]; % Move Up-Right
                Successor.Boards = [Successor.Boards MoveUL(board,nut)]; % Move Up-Left
            end
        else
            % King Man
            Successor.Boards = [Successor.Boards MoveDR(board,nut)]; % Move Down-Right
            Successor.Boards = [Successor.Boards MoveDL(board,nut)]; % Move Down-Left
            Successor.Boards = [Successor.Boards MoveUR(board,nut)]; % Move Up-Right
            Successor.Boards = [Successor.Boards MoveUL(board,nut)]; % Move Up-Left
        end
    end 
    
    Successor.nThreated_white = numberOf_Threated_whiteNuts;
    Successor.nThreated_black = numberOf_Threated_blackNuts;
    
end

function newboard = MoveDR(board,nut)
    newboard = [];
    xnew = nut.Position.X + 1;
    ynew = nut.Position.Y + 1;
    
    if xnew <= 8 && ynew <= 8
        
        if board.Status(xnew, ynew) == 0
            % Simple Move
            newboard = Move(xnew,ynew,nut,board);
            return;
        else
            stat = board.Status(xnew,ynew);
            if nut.Status ~= stat
                % Hitting Move
                newboard = HittingDR(board,nut);
            else
                % No Move
            end
            
        end
        
    end
end

function newboard = HittingDR(board,nut)
    global numberOf_Threated_whiteNuts;
    global numberOf_Threated_blackNuts;
    newboard = [];

    x = nut.Position.X + 2;
    y = nut.Position.Y + 2;
    
    if x <= 8 && y <= 8
        if board.Status(x,y) ~= 0
           return;
        else
            newboard = board;
            newboard.Status(x,y) = nut.Status;
            newboard.Status(nut.Position.X, nut.Position.Y) = 0;
            newboard.Status(nut.Position.X + 1, nut.Position.Y + 1) = 0;
            
            index = GetNutByPosition(newboard,nut.Position.X + 1,nut.Position.Y + 1);
            if newboard.Nuts(index).Status == 1
                numberOf_Threated_whiteNuts = numberOf_Threated_whiteNuts + 1;
            else
                numberOf_Threated_blackNuts = numberOf_Threated_blackNuts + 1;
            end
            newboard.Nuts(index) = [];
            
            index = GetNutByPosition(newboard,nut.Position.X,nut.Position.Y);
            nut.Position.X = nut.Position.X + 2;
            nut.Position.Y = nut.Position.Y + 2;
            if nut.Position.X == 8
                nut.Type = 1;
            end
            newboard.Nuts(index) = nut;
        end
    end
    
end

function newboard = MoveDL(board,nut)
    newboard = [];

    xnew = nut.Position.X + 1;
    ynew = nut.Position.Y - 1;
    
    if xnew <= 8 && ynew >= 1
        
        if board.Status(xnew, ynew) == 0
            % Simple Move
            newboard = Move(xnew,ynew,nut,board);
            return;
        else
            stat = board.Status(xnew,ynew);
            if nut.Status ~= stat
                % Hitting Move
                newboard = HittingDL(board,nut);
            else
                % No Move
            end
            
        end
        
    end

end

function newboard = HittingDL(board,nut)
    global numberOf_Threated_whiteNuts;
    global numberOf_Threated_blackNuts;
    newboard = [];

    x = nut.Position.X + 2;
    y = nut.Position.Y - 2;
    
    if x <= 8 && y >= 1
        if board.Status(x,y) ~= 0
           return;
        else
            newboard = board;
            newboard.Status(x, y) = nut.Status;
            newboard.Status(nut.Position.X, nut.Position.Y) = 0;
            newboard.Status(nut.Position.X + 1,nut.Position.Y - 1) = 0;
            
            index = GetNutByPosition(newboard,nut.Position.X + 1,nut.Position.Y - 1);
            if newboard.Nuts(index).Status == 1
                numberOf_Threated_whiteNuts = numberOf_Threated_whiteNuts + 1;
            else
                numberOf_Threated_blackNuts = numberOf_Threated_blackNuts + 1;
            end
            newboard.Nuts(index) = [];
            
            
            index = GetNutByPosition(newboard,nut.Position.X,nut.Position.Y);
            nut.Position.X = nut.Position.X + 2;
            nut.Position.Y = nut.Position.Y - 2;
            if nut.Position.X == 8
                nut.Type = 1;
            end
            newboard.Nuts(index) = nut;
        end
    end
    
end

function newboard = MoveUR(board,nut)
    newboard = [];

    xnew = nut.Position.X - 1;
    ynew = nut.Position.Y + 1;
    
    if xnew >= 1 && ynew <= 8
        
        if board.Status(xnew, ynew) == 0
            % Simple Move
            newboard = Move(xnew,ynew,nut,board);
            return;
        else
            stat = board.Status(xnew,ynew);
            if nut.Status ~= stat
                % Hitting Move
                newboard = HittingUR(board,nut);
            else
                % No Move
            end
            
        end
        
    end
end

function newboard = HittingUR(board,nut)
    global numberOf_Threated_whiteNuts;
    global numberOf_Threated_blackNuts;
    newboard = [];

    x = nut.Position.X - 2;
    y = nut.Position.Y + 2;
    
    if x >= 1 && y <= 8
        if board.Status(x,y) ~= 0
           return;
        else
            newboard = board;
            newboard.Status(x,y) = nut.Status;
            newboard.Status(nut.Position.X, nut.Position.Y) = 0;
            newboard.Status(nut.Position.X - 1, nut.Position.Y + 1) = 0;
            
            index = GetNutByPosition(newboard,nut.Position.X - 1,nut.Position.Y + 1);
            if newboard.Nuts(index).Status == 1
                numberOf_Threated_whiteNuts = numberOf_Threated_whiteNuts + 1;
            else
                numberOf_Threated_blackNuts = numberOf_Threated_blackNuts + 1;
            end
            newboard.Nuts(index) = [];
            
            index = GetNutByPosition(newboard,nut.Position.X,nut.Position.Y);
            nut.Position.X = nut.Position.X - 2;
            nut.Position.Y = nut.Position.Y + 2;
            if nut.Position.X == 1
                nut.Type = 1;
            end
            newboard.Nuts(index) = nut;
        end
    end
    
end

function newboard = MoveUL(board,nut)
    newboard = [];

    xnew = nut.Position.X - 1;
    ynew = nut.Position.Y - 1;
    
    if xnew >= 1 && ynew >= 1
        
        if board.Status(xnew, ynew) == 0
            % Simple Move
            newboard = Move(xnew,ynew,nut,board);
            return;
        else
            stat = board.Status(xnew,ynew);
            if nut.Status ~= stat
                % Hitting Move
                newboard = HittingUL(board,nut);
            else
                % No Move
            end
            
        end
        
    end

end

function newboard = HittingUL(board,nut)
    global numberOf_Threated_whiteNuts;
    global numberOf_Threated_blackNuts;
    newboard = [];

    x = nut.Position.X - 2;
    y = nut.Position.Y - 2;
    
    if x >= 1 && y >= 1
        if board.Status(x,y) ~= 0
           return;
        else
            newboard = board;
            newboard.Status(x, y) = nut.Status;
            newboard.Status(nut.Position.X, nut.Position.Y) = 0;
            newboard.Status(nut.Position.X - 1,nut.Position.Y - 1) = 0;
            
            index = GetNutByPosition(newboard,nut.Position.X - 1,nut.Position.Y - 1);
            if newboard.Nuts(index).Status == 1
                numberOf_Threated_whiteNuts = numberOf_Threated_whiteNuts + 1;
            else
                numberOf_Threated_blackNuts = numberOf_Threated_blackNuts + 1;
            end
            newboard.Nuts(index) = [];
            
            
            index = GetNutByPosition(newboard,nut.Position.X,nut.Position.Y);
            nut.Position.X = nut.Position.X - 2;
            nut.Position.Y = nut.Position.Y - 2;
            if nut.Position.X == 1
                nut.Type = 1;
            end
            newboard.Nuts(index) = nut;
        end
    end
    
end

function newBoard = Move(xnew,ynew,nut,board)
    
    newBoard = board;
    newBoard.Status(nut.Position.X,nut.Position.Y) = 0;
    newBoard.Status(xnew,ynew) = nut.Status;

    if nut.Status == 1
        if xnew == 8
            nut.Type = 1; % King Man
        end
    else
        if xnew == 1
            nut.Type = 1; % King Man
        end
    end
    
    index = GetNutByPosition(newBoard,nut.Position.X,nut.Position.Y);
    nut.Position.X = xnew;
    nut.Position.Y = ynew;
    newBoard.Nuts(index) = nut;
end

function index = GetNutByPosition(board,x,y)
    nuts = board.Nuts;
    index = 0;
    for i=1:numel(nuts)
        index = i;
        if nuts(i).Position.X == x && nuts(i).Position.Y == y
            break;
        end
    end
end
