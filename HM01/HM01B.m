rng(42); % Set random seed for reproducibility

% Generate intertwined moon-shaped data
n_samples = 300;
noise = 0.3;
X1 = mvnrnd([0.5, 0.25], [0.05, 0; 0, 0.05], n_samples);
X2 = mvnrnd([-0.5, -0.25], [0.05, 0; 0, 0.05], n_samples);
X = [X1; X2];
y = [ones(n_samples, 1); -ones(n_samples, 1)];

% Add noise to the data
X = X + noise*randn(size(X));

% Split the data into training and testing sets
c = cvpartition(y, 'HoldOut', 0.3);
X_train = X(c.training,:);
y_train = y(c.training,:);
X_test = X(c.test,:);
y_test = y(c.test,:);

% Train KNN models for k=1 and k=15
knn_1 = fitcknn(X_train, y_train, 'NumNeighbors', 1);
knn_15 = fitcknn(X_train, y_train, 'NumNeighbors', 15);

% Function to plot decision boundaries
plot_decision_boundaries = @(X, y, model, ax, title) ...
    plotDecisionBoundary(X, y, @(x) predict(model, x), ...
    'FillOption', 'off', 'Title', title, 'Axes', ax);

% Save the figure to a file
fig = figure;
fig.Position(3:4) = [800, 400];
ax1 = subplot(1, 2, 1);
plot_decision_boundaries(X_train, y_train, knn_1, ax1, 'KNN (k=1) Decision Boundary');
ax2 = subplot(1, 2, 2);
plot_decision_boundaries(X_train, y_train, knn_15, ax2, 'KNN (k=15) Decision Boundary');
saveas(fig, 'decision_boundaries.png');