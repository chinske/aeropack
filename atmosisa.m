function [T, a, p, rho] = atmosisa(height)
% ATMOSISA International Standard Atmosphere
% 
% Copyright 2017 Christopher Chinske
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
% 
% [T, a, p, rho] = atmosisa(height) returns International Standard
% Atmosphere values for: temperature (K), speed of sound (m/s), pressure
% (Pa), and density (kg/m^3).  Input geopotential altitude (m).

% check input
if ~isvector(height)
    error('Input height must be a vector.')
end

% base values
base_h = [0; 11; 25; 47; 53; 79; 90; 105].*1000;
base_T = [288.16; 216.66; 216.66; 282.66; 282.66; 165.66; 165.66; 225.66];
dTdh = [-6.5E-3; 0; 3E-3; 0; -4.5E-3; 0; 4E-3; 0];

% constants
R = 287;
g = 9.8;

% initialize outputs
T = zeros(size(height));
a = zeros(size(height));
p = zeros(size(height));
rho = zeros(size(height));

% compute ISA values for each index of height
for i = 1:length(height)
    
    % sea level p and rho
    p(i) = 1.01325E5;
    rho(i) = 1.2250;
    
    % if height < 0 km or height > 105 km, hold values constant
    if height(i) < 0
        height(i) = 0;
    end
    
    if height(i) > 105.*1000
        height(i) = 105.*1000;
    end
    
    % find region that contains height
    region = find(base_h<=height(i),1,'last');
    
    % compute ISA values by starting at sea level
    for j = 1:region
        
        h1 = base_h(j);
        T1 = base_T(j);
        p1 = p(i);
        rho1 = rho(i);
        
        if j == region
            h = height(i);
        else
            h = base_h(j+1);
        end
        
        if dTdh(j) == 0
            % isothermal layer
            T(i) = T1;
            p(i) = p1.*exp(-(g./(R.*T(i))).*(h-h1));
            rho(i) = rho1.*exp(-(g./(R.*T(i))).*(h-h1));
        else
            % gradient region
            T(i) = T1 + dTdh(j).*(h-h1);
            p(i) = p1.*(T(i)./T1).^(-g./(dTdh(j).*R));
            rho(i) = rho1.*(T(i)./T1).^(-((g./(dTdh(j).*R))+1));
        end
        
        % speed of sound
        a(i) = sqrt(1.4.*R.*T(i));
        
    end
    
end