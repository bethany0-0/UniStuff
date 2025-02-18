function [best_distance best_tour] = simple_hill_climbing_two_opt(inputcities)
% randomsearch

% Hill climbing search algorithm
%The input arguments are
% inputcities         - The cordinates for n cities are represented as 2
%                       rows and n columns and is passed as an argument for
%                       greedysearch.


num_cities = length(inputcities);

% Generate an initial solution
% You can generate a random solution as the inital solution. 
% If you execute your algorithm several times, you have the hill climbing
% algorithm with random restart. 
best_tour = [1:num_cities];
best_cities_coordinates = inputcities(:,best_tour);
best_distance = distance(best_cities_coordinates);

stuck = false;
while (stuck==false)
    for i = 2 : num_cities-1
        for k = i+1 : num_cities - 1
            stuck = true;
            % Execute the swapping function
            new_tour = twoopt(best_tour, i, k);
            new_cities_coordinates = inputcities(:,new_tour);
            new_distance = distance(new_cities_coordinates);
            if new_distance < best_distance %|| rand(1) < 0.1
                best_distance = new_distance;
                best_tour = new_tour;
                stuck = false;
                plotcities(new_cities_coordinates);
                % Since it is a simple hill climbing algorihtm,
                % accept the first better solution and then terminate (break) 
                % the search of other immediate neighbours
                
               break; 
                
                %%%%%%%%%%%5with break finds first best, leave in
                %checks all k
                % Question: how can you get a steepest ascent (descent)
                % hill climbing algorithm?
            end
        end
    end


end
end



