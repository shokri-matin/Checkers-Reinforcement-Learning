function h = Show_Game_Space(Board)

    img = imread('pic/Chess_Board.png');
    figure(2),imshow(img)
    hold on;

    [imgWhite, ~, alpha] = imread('pic/white.png');
    [imgBlack, ~, alpha1] = imread('pic/black.png');
    [imgwhiteQueen, ~, alpha2] = imread('pic/whiteQueen.png');
    [imgblackQueen, ~, alpha3] = imread('pic/blackQueen.png');

    for i=1:size(Board.Status,1);
        for j=1:size(Board.Status,2);
            if Board.Status(i,j) ~= 0
                if Board.Status(i,j) == 1
                    
                    nut = GetNutByPosition(Board,i,j);
                    if nut.Type == 1
                        f = image((j - mod(i+j,2))*54+8,(i-1)*54+8,imgwhiteQueen);
                        set(f, 'AlphaData', alpha2);
                    else
                    	f = image((j - mod(i+j,2))*54+8,(i-1)*54+8,imgWhite);
                        set(f, 'AlphaData', alpha);
                    end
                    
                else
                    if Board.Status(i,j) == 2
                        nut = GetNutByPosition(Board,i,j);
                        if nut.Type == 1
                            f = image((j - mod(i+j,2))*54+8,(i-1)*54+8,imgblackQueen);
                            set(f, 'AlphaData', alpha3);
                        else
                        	f = image((j - mod(i+j,2))*54+8,(i-1)*54+8,imgBlack);
                            set(f, 'AlphaData', alpha1);
                        end
                    end
                end
            end
        end
    end
    hold off

end

function nut = GetNutByPosition(board,x,y)

    nuts = board.Nuts;
    for i=1:numel(nuts)
        nut = nuts(i);
        if nuts(i).Position.X == x && nuts(i).Position.Y == y
            break;
        end
    end
    
end