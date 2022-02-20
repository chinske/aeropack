function cd = dragwi(y,V,V_inf,c)
% DRAGWI Drag Coefficient by Wake Integration
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
% cd = dragwi(y,V,V_inf,c) computes the drag coefficient of a
% two-dimensional model (e.g., an airfoil) given a wake survey measurement.
% 
% INPUTS
% y:        Vector of survey locations
% V:        Vector of survey velocities
% V_inf:    Free stream velocity
% c:        Reference length

cd = 2.*trapz(y,V.*(V_inf - V))./(c.*V_inf.^2);