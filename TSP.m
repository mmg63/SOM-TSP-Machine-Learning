%% In this code, we illustrate the use of the linear topology for
% the cluster units in a Kohonen self-ofganizing map to sole a classic
% problem in constrained optimization, the so-called traveling salesman
% problem(TSP). The aim of the TSP is to find a tour of a given set of
% cities that is of minimum length. A tour consists of visiting each city
% exactly one and returning to the starting city. The net has a linear
% topology, with the first and last cluster units.
% this code is implemented by Mustafa Mohammadi, student of University of Tehran

clear;
%% get cities point on the figure windows with getpts embeded function

% initialize figure value
figure1 = axes();

figure1.Title.String = 'Please input your cities, and then click enter';
axis([0 1 0 1])

[x, y] = getpts(figure1);
[number_city, temp] = size(x);
clear temp;
cities = zeros(number_city,2);
cities(:,1) = x;
cities(:,2) = y;
%% initial cluster weights
w = rand(number_city,2);

%% initial learning rate is 0.6 with decreasing 0.5 at each 100
% train the clusters

reset_couter_for_alpha = 0;
alpha = 0.5;

% initial radius (topological architecture)
radius = 1;

scatter(cities(:,1),cities(:,2));

for iteration = 1 : 100
%   plot cities and cluster relationship

    clf;
    plot(w(:,1),w(:,2),'b-O',cities(:,1),cities(:,2),'r*');
    
    axis([0 1 0 1]);
    title('Kohonen Self-organizing map');
    hold on
    legend('clusters information','Cities points');
    xlabel(['epoc = ' num2str(iteration) '  alpha = ' num2str(alpha) ...
        '   radius = ' num2str(radius)]);
    pause(.1);

    reset_couter_for_alpha = reset_couter_for_alpha + 1; 
    for city_X = 1 : number_city 
        
        
        % calculate distances by Euclidean distance measurance
        [m_min,m_indice] = minEuclidient(city_X, cities, number_city,w);

        % update the weights of the closest cluster agent to coming
        % closer to its cluster
        if (m_indice > 1)
            w(m_indice - radius,:) = w(m_indice - radius,:) + (alpha * ...
                (cities(city_X,:) - w(m_indice - radius,:)));
        end;
        w(m_indice,:) = w(m_indice,:) + (alpha * (cities(city_X,:) ...
            - w(m_indice,:)));
        if (m_indice < number_city)
            w(m_indice + radius,:) = w(m_indice + radius,:) + (alpha * ...
                (cities(city_X,:) - w(m_indice + radius,:)));
        end;
        
    end;
    if ((iteration == 50))
        radius = radius - 1;
    end;

    if (reset_couter_for_alpha == 20)
        alpha = 0.9 * alpha;
        reset_couter_for_alpha = 0;
    end;
end;


