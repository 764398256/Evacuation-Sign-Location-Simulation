function [path_real pathLength frequency] = GenerateRealPath(varargin)
%% Generate path for the map, can load from database or manaually set
%% source: 'database', 'manual'
%% when source is database, the next element is filename; when source is manaual, 
%% the next element is speed and frequency
if(nargin == 2)
    source = string(varargin(1));
    filename = string(varargin(2));
    if(source == 'database' )
        load(filename);
    end
elseif(nargin == 3)
    source = string(varargin(1));
    speed = double(string(varargin(2)));
    frequency = double(string(varargin(3)));
    if(source == 'manaual')
        %% Choose key points
        pointSquence = GetPointFromMap();
        pathLength = sum(sum(abs(pointSquence(:,1:2) - pointSquence(:, 3:4)).^2, 2).^(1/2));
        %% Generate the path
        for cnt = 1: length(pointSquence)
            if(exist('path_std', 'var'))
                newPart = Walk(pointSquence(cnt, 1:2), pointSquence(cnt, 3:4), speed, frequency);
                middlePoint = VectorInterp([path_std(end - 3 : end, :); newPart(2: 4, :)]);
                path_std(end - 3: end, :) = []; newPart(1: 4, :) = [];      
                path_std = [path_std; middlePoint; newPart];
            else
                path_std = Walk(pointSquence(cnt, 1:2), pointSquence(cnt, 3:4), speed, frequency);
            end
        end
        %% Add system noise to the real path
        % path_real = Theory2Real(path_std);
        path_real = path_std;
    end
end