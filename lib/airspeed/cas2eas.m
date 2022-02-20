function eas = cas2eas(cas,p,T)
% CAS2EAS Convert CAS to EAS
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
% CAS2EAS(CAS,P,T) converts CAS to EAS.
% 
% Inputs
% CAS: Calibrated Airspeed (m/s)
% P: Static Pressure (Pa)
% T: Temperature (K)
% 
% Outputs
% EAS: Equivalent Airspeed (m/s)
% 
% This function assumes subsonic flow and constant ratio of specific heats.

% compute equivalent airspeed
% CAS -> TAS -> EAS
tas = cas2tas(cas,p,T);
eas = tas2eas(tas,p,T);