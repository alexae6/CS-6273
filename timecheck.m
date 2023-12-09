function [needTimeCorrection] = timecheck(all_locations_w_time)
% Check if time constraint is satisfied
% Inputs- locations for all vehicles with time steps
% Output- bool if time needs to be correct (1 = need time correction)

% Loop though all locations and time
for i=1:length(all_locations_w_time)
    current = all_locations_w_time{i};
    if current(end,3) > 40 % if vehicle time is greater than 40 minutes
        needTimeCorrection = true;
    else
        needTimeCorrection = false;
    end
end