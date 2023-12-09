function [pp,disttots,p] = createpaths(deliveries,num_V,depot)
% Create paths between closest points
% Inputs- delivery locations, number of vehicles, depot location
% Outputs - path for each vehicle, total distance traveled, delivery
% locations to vehicles assignment

    % Find closest points using linkage function
    distances = pdist(deliveries);
    linkageMatrix = linkage(distances, 'average');
    % Perform clustering
    p = cluster(linkageMatrix, 'MaxClust', num_V);
 
    % Create paths
    pp = cell(num_V, 1); 
    disttots = zeros(1,num_V);
    % Loop through all vehicles
    for i = 1:num_V 
        idx = find(p == i);
        pp{i} = cell(length(idx), 1); 
    
        if length(idx) == 1 % First path must connection must be made with depot location
            dist = calculateDistance(depot, deliveries(idx, :)); % Run function to calculate distances
            disttots(i) = disttots(i) + dist;
            pathPoints = paths(depot, deliveries(idx,:)); % Run function to create paths
            pp{i} = pathPoints;
        else
            % Loop through all possible path orders
            for j = 1:length(idx)-1
                if j==1 % First path must connection must be made with depot location
                   dist = calculateDistance(depot, deliveries(idx(j), :)); % Run function to calculate distances
                   disttots(i) = disttots(i) + dist;
                   pathPoints = paths(depot, deliveries(idx(j), :)); % Run function to create paths
                   pp{i,j} = pathPoints;
                end
                dist = calculateDistance(deliveries(idx(j), :), deliveries(idx(j+1), :)); % Run function to calculate distances
                disttots(i) = disttots(i) + dist;
                pathPoints = paths(deliveries(idx(j), :), deliveries(idx(j+1), :));  % Run function to create paths
                pp{i,j+1} = pathPoints;
              
            end
        end
    end
end
