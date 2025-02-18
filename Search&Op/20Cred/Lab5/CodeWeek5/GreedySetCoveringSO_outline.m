clear all;
%% Input your U, S and c here
U = [1:13];
S1 = [1 2];
S2 = [2:5];
S3 = [6:13];
S4 = [1:2:13];
S5 = [2:2:13, 13];
S = {S1 S2 S3 S4 S5};
c = ones(1,5);

%% number of elements in U
m = size(U, 2)
% number subsets
n = size(S, 2)

% Initiate X and F
X = U;
% We use F_idx to store the indices of subsets in S
F_idx = [];

% It terminates when all rows are covered
while ~isempty(X) 
    % For each subset in S, calculate the cost effectiveness, i.e., ratio between 
    % the cost and the number of uncovered elements of each subset in S, 
    % see the pseudo-code (slides page 11)
    e = []; % We need a empty vector to store e_j
    % We need a for loop to iterate each subset in S
    for j=1:n
        %% Modify this line to implementation of calcuate e_j here
        e_j = c(1,j) / size(intersect(S{j}, X),2);
        e = [e e_j];
    end
    %% Your implementation here:    
      % Find the subset in S, i.e., S_i with minimum  $e_i$,  \\
      [temp, index] = min(e);
 
  	  % Update F = F \cup S_i; X = X \ S_i$ \\
      F_idx = [F_idx, index];
      X = setdiff(X, S{index});
end

disp(['The best solution is: S_j, j = ', num2str(F_idx)]);
disp(['The minimum cost found by the Greedy Algorithm is: ', num2str(sum(c(F_idx)))]);

