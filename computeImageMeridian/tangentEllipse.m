% code
function [slope, intercept] = tangentEllipse(x2, y2, xCenter, yCenter, aR, bR, th)  
% find tangent line at (x2,y2)
% Point where ellipse is centered: (xCenter, yCenter)
% semimajor and semiminor axis: (aR, bR)
% angle of tilt: th
%% first rotate x2 y2 point back to corresponding point on un-rotated ellipse
q = cos(th);
s = sin(th);
x1 = (x2 - xCenter)*q + (y2 - yCenter)*s + xCenter;
y1 = (y2 - yCenter)*q - (x2 - xCenter)*s + yCenter;
m1 = -((x1-xCenter)/(y1-yCenter))*(((bR)^2)/((aR)^2)); % slope of tangent to unrotated ellipse
%% rotate tangent line back to angle of the rotated ellipse
if q-m1*s ==0   % slope is infinite
      z = 2;       % where z > 0
      x1a = x1; 
      y1a = z + y1;
      %rotate x1a and y1a back onto the ellipse to new pt (x2a, y2a)
      x2a = (x1a - xCenter)*q - (y1a - yCenter)*s + xCenter;
      y2a = (y1a - yCenter)*q + (x1a - xCenter)*s + yCenter;
      dx2 = x2a-x2;
      dy2 = y2a - y2;
      m2 = dy2/dx2;
else            % slope is not infinite
    z = 2;
    x1a = x1 + z; % where z > 0
    y1a = m1*z + y1;
      %rotate x1a and y1a back onto the ellipse to new pt (x2a, y2a)
      x2a = (x1a - xCenter)*q - (y1a - yCenter)*s + xCenter;
      y2a = (y1a - yCenter)*q + (x1a - xCenter)*s + yCenter;
      x2 = (x1 - xCenter)*q - (y2 - yCenter)*s + xCenter;
      y2 = (y1 - yCenter)*q + (x2 - xCenter)*s + yCenter;
      % slope (m2) of rotated tangent line at (x2, y2) is dy2/dx2
      dx2 = x2a - x2;
      dy2 = y2a - y2;
      m2 = dy2/dx2;
end
%% calculate the slope and intercept of the tangent line
    % general equation for tangent line:
    %  y = m2(x - x2) + y2
      slope = m2;
      intercept = y2 - m2*x2;