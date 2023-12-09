%% Inputs
grid_size = input(['Enter grid size (length,width): '], 's');
gridx  = str2num(extractBefore(grid_size,','));
gridy = str2num(extractAfter(grid_size,','));
num_Deliveries = input('Enter the number of deliveries: ');
num_V = input('Enter the number of vehicles: ');


% Check if number deliveries > 50% of grid
deliveryPercentage = (num_Deliveries / (gridx*gridy));
if deliveryPercentage > .50
    disp('Error: More than 50% of the city are deliveries. Please change deliveries');
    return;
end
% Check relationship between deliveries and vehicles
if num_V >= num_Deliveries
    fprintf('Warning: More vehicles than deliveries, only using %d vehicles \n',num_Deliveries);
end

deliveries = zeros(num_Deliveries, 2);
for i = 1:num_Deliveries
    coordinates = input(['Enter coordinates for delivery ' num2str(i) ' (x,y): '], 's');
    x  = extractBefore(coordinates,',');
    y = extractAfter(coordinates,',');
    x= str2num(x);
    y= str2num(y);
     if x > gridx
        disp("X Coordinate Delivery Location Outside of City Limits")
        break;  % Exit if
     elseif y > gridy
        disp("Y Coordinate Delivery Location Outside of City Limits")
        break;  % Exit if
    else
    deliveries(i, :) = [x, y];
    end
end

%%
[pp,disttots,p] = createpaths(deliveries,num_V);
[samelocation,all_locations_w_time] = locationcheck(pp);
[needTimeCorrection] = timecheck(all_locations_w_time);

itr = 1;
while needTimeCorrection == true && itr < 200
   [pp,disttots,p] = timecorrection(all_locations_w_time,deliveries,p,num_V);
   [samelocation,all_locations_w_time] = locationcheck(pp);
    itr = itr+1
end
%%
timetots = 0;
 for i = 1:num_V
    totalPath = [];
    for j = 1:size(pp,2)
        pathPoints = pp{i, j};
        totalPath = vertcat(totalPath, pathPoints);
        times = all_locations_w_time{i};
        tt = times(end,3);
        timetots(i) = tt;
    end
    
    fprintf('Vehicle %d Path:\n', i);
    disp(totalPath);    
 end

for i =1:num_V
fprintf('Vehicle %d Total Distance: %f \n', i,disttots(i));
fprintf('Vehicle %d Total Time: %d \n', i,timetots(i));
end

%%
[gridx,gridy] = meshgrid(1:gridx,1:gridy);
%plot(gridx,gridy,'.w')
hold on
for i=1:num_V
    totalPath =[];
    for j=1:size(pp,2)
        pathPoints = pp{i,j};
        totalPath = vertcat(totalPath, pathPoints);
    end
    plot(totalPath(:, 1), totalPath(:, 2), 'LineWidth', 1);
    for ii =1:3:length(totalPath)
    text(totalPath(ii,1)+.25,totalPath(ii,2)+.25,string(ii),'FontSize',8,'FontWeight','bold');
    end
end
plot(deliveries(:,1),deliveries(:,2),'.b','MarkerSize', 15)
plot(10,10,'gsquare', 'MarkerFaceColor','green')
legend('Vehicle 1','Vehicle 2', 'Vehicle 3', 'Deliveries','Delivery Origin')
xlim([0,20])
ylim([0, 20])
hold off
