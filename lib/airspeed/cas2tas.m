function tas = cas2tas(cas,p,T)
% CAS2TAS Convert CAS to TAS
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
% CAS2TAS(CAS,P,T) converts CAS to TAS.
% 
% Inputs
% CAS: Calibrated Airspeed (m/s)
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

% compute measured impact pressure
vc = cas;
qc = p0.*((1 + ((gam-1)./(2.*gam)).*(rho0./p0).*vc.^2).^ ...
    (gam./(gam-1)) - 1);

% compute true airspeed
f = compfact(p,qc);
f0 = compfact(p0,qc);
v = vc.*(f./f0).*sqrt(rho0./rho);
tas = v;

% if input CAS = 0, set output TAS = 0
k = find(cas == 0);
tas(k) = 0;