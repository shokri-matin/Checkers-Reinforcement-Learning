function Vhat = V( board,nTreatedwhite,nTreatedblack, W )
    
    BlackNuts = board.Nuts([board.Nuts.Status] == 2);
    nBlackNuts = numel(BlackNuts);
    
    WhiteNuts = board.Nuts([board.Nuts.Status] == 1);
    nWhiteNuts = numel(WhiteNuts);
    
    King_BlackNuts = BlackNuts([BlackNuts.Type] == 1);
    nKing_BlackNuts = numel(King_BlackNuts);
    
    King_WhiteNuts = WhiteNuts([WhiteNuts.Type] == 1);
    nKing_WhiteNuts = numel(King_WhiteNuts);
    
    x1 = nBlackNuts;
    x2 = nWhiteNuts;
    x3 = nKing_BlackNuts;
    x4 = nKing_WhiteNuts;
    x5 = nTreatedblack;
    x6 = nTreatedwhite;
    
    Vhat = W(1) + W(2)*x1 + W(3)*x2 + W(4)*x3 + W(5)*x4 + W(6)*x5 + W(7)*x6;

end

