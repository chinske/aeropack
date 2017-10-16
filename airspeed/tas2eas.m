function eas = tas2eas(tas,rho)
% TAS2EAS Convert TAS to EAS
% Christopher Chinske
% 10/15/17
% Copyright 2017 Christopher Chinske
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
% TAS2EAS(TAS,RHO) converts TAS to EAS.
% 
% Inputs
% TAS: True Airspeed (m/s)
% RHO: Density (kg/m^3)
% 
% Outputs
% EAS: Equivalent Airspeed (m/s)
% 
% This function assumes subsonic flow and constant ratio of specific heats.

% sea-level values of pressure, density, and speed of sound
p0 = 1.01325E5;
rho0 = 1.2250;
a0 = 340.269;

% constants
gam = 1.4;

% compute equivalent airspeed
v = tas;
ve = v.*sqrt(rho./rho0);
eas = ve;