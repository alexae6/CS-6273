%% Inputs
num_Deliveries = input('Enter the number of deliveries: ');
deliveries = zeros(num_Deliveries, 2);

for i = 1:num_Deliveries
    coordinates = input(['Enter coordinates for delivery ' num2str(i) ' (x,y): '], 's');
    x  = extractBefore(coordinates,',');
    y = extractAfter(coordinates,',');
    x= str2num(x);
    y= str2num(y);
    deliveries(i, :) = [x, y];
end
num_V = input('Enter the number of vehicles: ');
%%
[pp,disttots] = createpaths(deliveries,num_V)
[samelocation,all_locations_w_time] = locationcheck(pp);
%%
[gridx,gridy] = meshgrid(1:20,1:20);
plot(gridx,gridy,'.w')
hold on
for i=1:num_V
    totalPath =[];
    for j=1:size(pp,2)
        pathPoints = pp{i,j};
        totalPath = vertcat(totalPath, pathPoints);
    end
    plot(totalPath(:, 1), totalPath(:, 2), 'LineWidth', 1);
end
plot(deliveries(:,1),deliveries(:,2),'xb','MarkerSize', 15)
hold off
