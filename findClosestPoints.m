function [point1, point2, minDistance] = findClosestPoints(deliveries)
    numPoints = size(deliveries, 1);
    minDistance = inf;

    for i = 1:numPoints - 1
        for j = i + 1:numPoints
            distance = sum((deliveries(i, :) - deliveries(j, :)).^2);
            if distance < minDistance
                minDistance = distance;
                point1 = deliveries(i, :);
                point2 = deliveries(j, :);
            end
        end
    end
end