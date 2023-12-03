function [pp,disttots,p] = timecorrection(all_locations_w_time,deliveries,p,num_V)
for i=1:length(all_locations_w_time)
current = all_locations_w_time{i};
times_all(i) = length(current(:,3));
end
shortest_location = min(times_all);
idx = find(times_all==shortest_location);

for i=1:length(all_locations_w_time)
    current = all_locations_w_time{i};
    if current(end,3) > 40
        clust = find(p==i);
        move = deliveries(clust(end),:);
        p(clust(end)) = idx;
    end
end
pp = cell(num_V, 1); 
    disttots = zeros(1,num_V);
    for i = 1:num_V
        idx = find(p == i);
        pp{i} = cell(length(idx), 1); % Initialize cell array for each cluster
    
        if length(idx) == 1
            dist = calculateDistance([10;10], deliveries(idx, :));
            disttots(i) = disttots(i) + dist;
            pathPoints = paths([10,10], deliveries(idx,:));
            pp{i} = pathPoints;
        else
            for j = 1:length(idx)-1
                if j==1
                   dist = calculateDistance([10;10], deliveries(idx(j), :));
                   disttots(i) = disttots(i) + dist;
                   pathPoints = paths([10,10], deliveries(idx(j), :));
                   pp{i,j} = pathPoints;
                end
            % Calculate distance between points
                dist = calculateDistance(deliveries(idx(j), :), deliveries(idx(j+1), :));
                disttots(i) = disttots(i) + dist;
            % Calculate paths
                pathPoints = paths(deliveries(idx(j), :), deliveries(idx(j+1), :));
                pp{i,j+1} = pathPoints;
            end
        end
    end

        