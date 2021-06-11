function W = Update_W( board,nTreatedwhite,nTreatedblack, W, v_hat, v_train, etha )

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
    
    W(2) = W(2) + etha*(v_train - v_hat)*x1;
    W(3) = W(3) + etha*(v_train - v_hat)*x2;
    W(4) = W(4) + etha*(v_train - v_hat)*x3;
    W(5) = W(5) + etha*(v_train - v_hat)*x4;
    W(6) = W(6) + etha*(v_train - v_hat)*x5;
    W(7) = W(7) + etha*(v_train - v_hat)*x6;
    
end

