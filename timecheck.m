function [needTimeCorrection] = timecheck(all_locations_w_time)
NeedTimeCorrection = false;
for i=1:length(all_locations_w_time)
    current = all_locations_w_time{i};
    if current(end,3) > 40
        needTimeCorrection = true;
    end
end