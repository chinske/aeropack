function tas = eas2tas(eas,p,T)
% EAS2TAS Convert EAS to TAS
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
% EAS2TAS(EAS,P,T) converts EAS to TAS.
% 
% Inputs
% EAS: Equivalent Airspeed (m/s)
% P: Static Pressure (Pa)
% T: Temperature (K)
% 
% Outputs
% TAS: True Airspeed (m/s)
% 
% This function assumes subsonic flow and constant ratio of specific heats.

% sea-level values of pressure, density, and speed of sound
p0 = 1.01325E5;
rho0 = 1.2250;
a0 = 340.269;

% constants
R = 287;
gam = 1.4;

% compute density
rho = p./(R.*T);

% compute true airspeed
ve = eas;
v = ve.*sqrt(rho0./rho);
tas = v;