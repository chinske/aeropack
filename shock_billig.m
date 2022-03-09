function x = shock_billig(btype,R,gam,M1,deltac,y)
% SHOCK_BILLIG Billig's Correlation for Blunt-Body Shock-Wave Shapes
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
% X = SHOCK_BILLIG(BTYPE,R,GAM,M1,DELTAC,Y) returns the x-coordinates of
% the hyperbolic shock shape for the input y-coordinates as given by
% Billig's correlation for hypersonic shock-wave shapes.
% 
% Inputs
% ------
% BTYPE  : String specifying body type, 'sphere-cone' or 'cylinder-wedge'
% R      : Radius of the nose
% GAM    : Ratio of specific heats
% M1     : Free stream Mach number
% DELTAC : Cone half-angle (deg)
% 
% References 
% ----------
% [1] Anderson, (John David), John D. 2019. Hypersonic and
% High-Temperature Gas Dynamics. Hypersonic and High-Temperature Gas
% Dynamics. Third edition. AIAA Education Series. Reston, Virginia:
% American Institute of Aeronautics and Astronautics, Inc.
% 
% [2] Billig, Frederick S. 1967. “Shock-Wave Shapes around Spherical-and
% Cylindrical-Nosed Bodies.” Journal of Spacecraft and Rockets 4 (6):
% 822–23. https://doi.org/10.2514/3.28969.

% correlations from experimental data (see Section 5.4 in [1])
if strcmp(btype,'sphere-cone')
    delta_R = 0.143.*exp(3.24./M1.^2);
    Rc_R = 1.143.*exp(0.54./(M1 - 1).^1.2);
elseif strcmp(btype,'cylinder-wedge')
    delta_R = 0.386.*exp(4.67./M1.^2);
    Rc_R = 1.386.*exp(1.8./(M1 - 1).^0.75);
else
    error('Invalid btype.')
end

delta = delta_R.*R;
Rc = Rc_R.*R;

% Taylor-Maccoll to get shock angle
[beta,pcp1,rcr1] = taylormaccoll(gam,M1,deltac);

% hyperbolic shock shape (see Section 5.4 in [1])
x = R + delta - Rc.*cotd(beta).^2 .* ...
    ((1 + (y.^2.*tand(beta).^2)./(Rc.^2)).^(1./2) - 1);

% convert such that body starts at x = 0, flow from left to right
x = -x;
x = R + x;