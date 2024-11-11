clear all
clc

% Reading the data from csv file
points = readmatrix("iris.csv");

% Split to training and testing
% Get the amount of splitting from user
TraingingPercentage = input('Enter percentage of trainging set : ');
% Compute the percentage of split
dividerElement = size(points, 1) * TraingingPercentage / 100;
% making index with inputs size
Indices = randperm(size(points, 1));
% use indeces and percentage of splitting to make training and testing sets
trainingSet = points(Indices(1:dividerElement),:);
testingSet = points(Indices(dividerElement+1:end),:);

% ################## Training phase ##################

% K means 
% Get the number of centers from user
numberOfCenters = input('Enter the number of centers : ');
% Run the kmean to find centers
[idx, centers] = kmeans(trainingSet, numberOfCenters);

% RBF algorithm
% Making an empty matrix for phi storing
phiTraining = zeros(size(trainingSet, 1), size(centers, 1));

% Finding the sigma
distSum = 0;
distCounter = 0;
for x = 1:size(centers, 1)
    q = x + 1;
    for w = q:size(centers, 1)
        dist = sqrt(((centers(x,1) - centers(w,1)) ^2) + ((centers(x,2) - centers(w,2)) ^2));
        distSum = distSum + dist;
        distCounter = distCounter + 1;
    end
end
% Compute the sigma with average times two 
sigma = (distSum / distCounter) * 2;


% Computing and replacing phi matrix values
for i = 1:size(trainingSet, 1)
    for j = 1:size(centers, 1)
        dist = sqrt((trainingSet(i,1) - centers(j,1))^2 + (trainingSet(i,2) - centers(j,2))^2);
        phidist = exp(-dist^2 / 2 * sigma^2);
        phiTraining(i,j) = phidist;
    end
end

% Compute the weights
weights = pinv(phiTraining) * trainingSet;


% ################## Testing phase ##################

% K means
% Run the kmean to find centers of testing set
[idx, Tcenters] = kmeans(testingSet, numberOfCenters);

% Making an empty matrix for testing phi
Tphi = zeros(size(testingSet, 1),size(Tcenters, 1));


% Finding the sigma
distSum = 0;
distCounter = 0;
for x = 1:size(Tcenters, 1)
    z = x + 1;
    for w = z:size(Tcenters, 1)
        dist = sqrt(((centers(x,1) - centers(w,1)) ^2) + ((centers(x,2) - centers(w,2)) ^2));
        distSum = distSum + dist;
        distCounter = distCounter + 1;
    end
end
% Compute the sigma
Tsigma = (distSum / distCounter) * 2;

% Computing and replacing phi matrix values
for i = 1:size(testingSet, 1)
    for j = 1:size(Tcenters, 1)
        Tdist = sqrt((testingSet(i,1) - Tcenters(j,1))^2 + (testingSet(i,2) - Tcenters(j,2))^2);
        Tphidist = exp(-Tdist^2 / 2 * Tsigma^2);
        Tphi(i,j) = Tphidist;
    end
end

% Compute the final output to compare with testing set
finalOutput = Tphi * weights;

% Checking how many variables have true labe with 9% tolerance
cheking = ismembertol(testingSet, finalOutput, 0.09, 'ByRows', true);

% Counting the true labed
count = 0;
for u = 1:size(cheking, 1)
    if cheking(u) == 1
        count = count + 1;
    end
end

% Compute final percentage
finalPercentage = count * 100 / size(cheking, 1);

% Print out the result
h = ['True Labeled validation inputs equels ' ,num2str(finalPercentage) , '%'];
disp(h);




