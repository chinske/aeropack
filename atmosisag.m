function [T, a, p, rho] = atmosisag(hg)
% ATMOSISAG International Standard Atmosphere Geometric
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
% [T, a, p, rho] = atmosisag(hg) returns International Standard
% Atmosphere values for: temperature (K), speed of sound (m/s), pressure
% (Pa), and density (kg/m^3).  Input geometric altitude (m).

h = geop(hg);
[T, a, p, rho] = atmosisa(h);
