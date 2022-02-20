function f = compfact(p,qc)
% COMPFACT Compressibility Factor
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
% COMPFACT(P,QC) returns the compressibility factor given static pressure P
% (Pa) and measured impact pressure QC (Pa).

gam = 1.4;

f = sqrt( (gam./(gam-1)) .* (p./qc) .* ...
    ((qc./p + 1).^((gam-1)./gam) - 1));