function path = Walk(startPoint, endPoint, speed, frequency)
%% Return a simulated walking path according to the input
%% startPoint, endPoint: 2-dimensional coordinates(m); speed: (m/s); frequency: (Hz)
walkLength = norm(endPoint - startPoint);   % (m)
walkDirection = (endPoint - startPoint) / walkLength;
% ����������֮��ľ���Ϊʹ��ƽ���ٶ��߹��ľ���
dx = 1 / frequency * speed;
cnt = 1;
path(cnt, :) = startPoint;
while(norm(path(cnt, :) - endPoint) >= 2 * dx)
    cnt = cnt + 1;
    path(cnt, :) = path(cnt - 1, :) + walkDirection * 1 / frequency * speed * (1 + 0.003 * randn);
end
flagDistance = norm(path(end, :) - endPoint);
if(flagDistance >= 1.8 * dx)
    path(end + 1, :) = (path(end, :) + endPoint) / 2;
    path(end + 1, :) = endPoint;
elseif(flagDistance > dx && flagDistance < 1.8 * dx)
    path(end + 1, :) = endPoint;
end
end