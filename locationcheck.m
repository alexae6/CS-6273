function [samelocation,all_locations_w_time] = locationcheck(pp)
samelocation = false(size(pp, 1), size(pp, 1));
for i = 1:size(pp, 1)
    totalpath = vertcat(pp{i, :});
    time = (1:length(totalpath))' * 2;
    location_w_time1 = [totalpath, time];
    all_locations_w_time{i} = location_w_time1;
        
    for j=1:size(pp,1)
        if i ~= j
        totalpath = vertcat(pp{j, :});
        time = (1:length(totalpath))' * 5;
        location_w_time2 = [totalpath, time]; 
   
        % Minimum length of paths
        minLength = min(size(location_w_time1, 1), size(location_w_time2, 1));
        % Check for equal locations
        clear E
        for k=2:minLength
                E(k,:) = location_w_time1(k,:) == location_w_time2(k,:);
        end
         if any(all(E,2))
                samelocation(i, j) = true;
            end
    end
    end
end
%end
