function cas = eas2cas(eas,p,T)
% EAS2CAS Convert EAS to CAS
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
% EAS2CAS(EAS,P,T) converts EAS to CAS.
% 
% Inputs
% EAS: Equivalent Airspeed (m/s)
% P: Static Pressure (Pa)
% T: Temperature (K)
% 
% Outputs
% CAS: Calibrated Airspeed (m/s)
% 
% This function assumes subsonic flow and constant ratio of specific heats.
% 
% This function only accepts scalar inputs.

% compute calibrated airspeed
% EAS -> TAS -> CAS
tas = eas2tas(eas,T);
cas = tas2cas(tas,p,T);