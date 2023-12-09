function [pp,disttots,p] = timecorrection(all_locations_w_time,deliveries,p,num_V,depot)
% Correct for time constraint not being met
% Inputs- travel paths for each vehicle with their time traveled at each
% location, delivery locations, and locations to vehicles assignment, deopt
% location
% Outputs- path for each vehicle, total distance traveled, locations to vehicles assignment

    % Loop through all vehicle paths to find vehicle with shortest time
    % traveled
    for i=1:length(all_locations_w_time)
        current = all_locations_w_time{i};
        times_all(i) = length(current(:,3));
    end
    shortest_location = min(times_all);     
    idx = find(times_all==shortest_location); % Vehicle with shortest time
    
    % Loop through vehicle times to see where the vehicle time is greater than
    % 40 minutes
    opts=[];
    for i=1:length(all_locations_w_time) 
        current = all_locations_w_time{i};
        if current(end,3) > 40 % if greater than 40
            clust = find(p==i); % Find the cluster assignment
            for j=1:length(clust) % Loop through all possible delivery locations to reassign
                opts(j,:) = deliveries(clust(j),:);
            end
        end
    end
    
    % Loop through all possible cluster reassignments to find closest point to
    % another cluster to reassign
    minDistance = 100;
    closest = 0;
    for i = 1:size(opts, 1)
        currentPoint = opts(i, :);
        for j=1:size(deliveries,1)
            distance = norm(currentPoint - deliveries(j,:));
            % Check if the current point is closer than the previous one
            if distance < minDistance && distance~=0
                minDistance = distance;
                closest = currentPoint;
            end
        end
    end
    
    % Reassign the location to another cluster if necessary
    a=0;
    for k=1:length(deliveries)
       if(deliveries(k,:)==closest)
           a = k;
       end
    end
    if a~=0 % If no reassingment, ignore
    p(a) = idx;
    end

% Recalculate total distances and paths
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
        