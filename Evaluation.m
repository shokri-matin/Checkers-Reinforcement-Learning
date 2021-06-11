function Succ = Evaluation( Succ, W )

    boards = [Succ.Boards];
    bLength = numel(boards);
    
    for i=1:bLength
        
        board = boards(i);
        s = Get_Successors(board,2);
        Cost = V(board,s.nThreated_white,s.nThreated_black,W);
        boards(i).Cost = Cost;
    end
    Succ.Boards = boards;
end

