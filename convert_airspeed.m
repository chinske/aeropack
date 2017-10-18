function v_out = convert_airspeed(v_in,type_in,type_out,p,rho,varargin)
% CONVERT_AIRSPEED Convert Between CAS, EAS, and TAS
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
% CONVERT_AIRSPEED(V_IN, TYPE_IN, TYPE_OUT, P, RHO) converts the input
% airspeed V_IN from TYPE_IN to TYPE_OUT.
% 
% CONVERT_AIRSPEED(..., UNITS) converts between airspeeds expressed in
% units specified by the string UNITS.
% 
% This function assumes subsonic flow and constant ratio of specific heats.
% 
% Inputs
% ------
% V_IN: Scalar or vector of airspeeds
% 
% TYPE_IN: String specifying input airspeed type
% TYPE_OUT: String specifying output airspeed type
% 
% Supported airspeed types are:
%   'CAS' - Calibrated Airspeed
%   'EAS' - Equivalent Airspeed
%   'TAS' - True Airspeed
% 
% P: Static Pressure (Pa)
% RHO: Density (kg/m^3)
% 
% UNITS: String specifying units of airspeed
% 
% Supported units are:
%   'SI' - Default
%   'knots'
% 
% Note: Notwithstanding the units of airspeed specified by the string
% UNITS, P and RHO must be in Pa and kg/m^3, respectively.
% 
% Outputs
% -------
% V_OUT: Scalar or vector (same dimensions as V_IN) of airspeeds

