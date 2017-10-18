function cas = tas2cas(tas,p,rho)
% TAS2CAS Convert TAS to CAS
% Christopher Chinske
% 10/17/17
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
% TAS2CAS(TAS,P,RHO) converts TAS to CAS.
% 
% Inputs
% TAS: True Airspeed (m/s)
% P: Static Pressure (Pa)
% RHO: Density (kg/m^3)
% 
% Outputs
% CAS: Calibrated Airspeed (m/s)
% 
% This function assumes subsonic flow and constant ratio of specific heats.

% sea-level values of pressure, density, and speed of sound
p0 = 1.01325E5;
rho0 = 1.2250;
a0 = 340.269;

% constants
gam = 1.4;

% termination criteria
es = 5E-5;

% initial estimates
v = tas;
x0 = v./2;
x1 = v;

% secant method
ea = 1;
while ea >= es
    % compute f(x0)
    qc = p0.*((1 + ((gam-1)./(2.*gam)).*(rho0./p0).*x0.^2).^ ...
        (gam./(gam-1)) - 1);
    f = compfact(p,qc);
    f0 = compfact(p0,qc);
    f_x0 = x0.*(f./f0).*sqrt(rho0./rho) - v;
    
    % compute f(x1)
    qc = p0.*((1 + ((gam-1)./(2.*gam)).*(rho0./p0).*x1.^2).^ ...
        (gam./(gam-1)) - 1);
    f = compfact(p,qc);
    f0 = compfact(p0,qc);
    f_x1 = x1.*(f./f0).*sqrt(rho0./rho) - v;
    
    % compute x2
    x2 = x1 - (f_x1.*(x0-x1))./(f_x0-f_x1);
    
    % compute error estimate
    ea = abs((x2-x1)./x2).*100;
    
    % update x0 and x1
    x0 = x1;
    x1 = x2;
    
end

cas = x2;