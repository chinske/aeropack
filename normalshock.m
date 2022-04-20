function [p2p1,r2r1,T2T1,p02p01,r02r01,M2M1] = normalshock(gamma,M1)
% NORMALSHOCK Normal Shock Property Ratios
% 
% Copyright 2022 Christopher Chinske
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
% [P2P1,R2R1,T2T1,P02P01,R02R01,M2M1] = NORMALSHOCK(GAMMA,M1) returns the
% property ratios across a normal shock for a perfect gas.
% 
% Inputs
% ------
% GAMMA : Ratio of specific heats
% M1 : Upstream Mach number
% 
% Outputs
% -------
% P2P1 : Pressure ratio
% R2R1 : Density ratio
% T2T1 : Temperature ratio
% P02P01 : Total pressure ratio
% R02R01 : Total density ratio
% M2M1 : Mach number ratio
% 
% Note that T02 = T01 across a normal shock for a perfect gas.
% 
% References
% ----------
% [1] White, Frank M. 1999. Fluid Mechanics. Fluid Mechanics. 4th ed.
% McGraw-Hill Series in Mechanical Engineering. Boston, Mass:
% WCB/McGraw-Hill.

k = gamma;

p2p1 = (1./(k+1)) .* (2.*k.*M1.^2 - (k-1));
r2r1 = ( (k+1).*M1.^2 )./( (k-1).*M1.^2 + 2);
T2T1 = (2 + (k-1).*M1.^2) .* (2.*k.*M1.^2 - (k-1)) ./ ((k+1).^2 .* M1.^2);
p02p01 = ( ( (k+1).*M1.^2 )./( 2 + (k-1).*M1.^2 ) ).^(k./(k-1)) .* ...
    ( (k+1)./( 2.*k.*M1.^2 - (k-1) ) ).^(1./(k-1));
r02r01 = p02p01;

M2 = sqrt(((k-1).*M1.^2 + 2)./(2.*k.*M1.^2 - (k-1)));
M2M1 = M2./M1;