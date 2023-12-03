function [pathPoints] = paths(start,finish)
    x0 = start(1);
    y0 = start(2);
    x1 = finish(1);
    y1 = finish(2);
    dx = abs(x1-x0);
    dy = abs(y1-y0);
    
    xStep = sign(x1-x0);
    yStep = sign(y1-y0);
    
    pathPoints = [x0, y0];
    
    if dx >= dy
        error = dx / 2;
        while x0 ~= x1
            x0 = x0 + xStep;
            error = error - dy;
            if error < 0
                y0 = y0 + yStep;
                error = error + dx;
            end
            pathPoints = [pathPoints; x0, y0];
        end
    elseif dy > dx
        error = dy / 2;
        while y0 ~= y1
            y0 = y0 + yStep;
            error = error - dx;
            if error < 0
                x0 = x0 + xStep;
                error = error + dy;
            end
            pathPoints = [pathPoints; x0, y0];
        end
    end
end




