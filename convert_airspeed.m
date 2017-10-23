function v_out = convert_airspeed(v_in,type_in,type_out,p,T,varargin)
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
% CONVERT_AIRSPEED(V_IN, TYPE_IN, TYPE_OUT, P, T) converts the input
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
% T: Temperature (K)
%
% UNITS: String specifying units of airspeed
%
% Supported units are:
%   'SI' - Default
%   'knots'
%
% Note: Notwithstanding the units of airspeed specified by the string
% UNITS, P and T must be in Pa and K, respectively.
%
% Outputs
% -------
% V_OUT: Scalar or vector (same dimensions as V_IN) of airspeeds

% check input
if ~isvector(v_in)
    error('Input V_IN must be a vector.')
end

% check input, convert to SI as required
if nargin == 6
    units = varargin{1};
    if strcmpi(units,'knots')
        v_in = v_in .* .514444;
    end
end

% execute airspeed conversion
switch upper([type_in,type_out])
    case ['CAS','EAS']
        v_out = cas2eas(v_in,p,T);
        
    case ['CAS','TAS']
        v_out = cas2tas(v_in,p,T);
        
    case ['EAS','CAS']
        v_out = zeros(size(v_in));
        for i = 1:length(v_in)
            v_out(i) = eas2cas(v_in(i),p,T);
        end
        
    case ['EAS','TAS']
        v_out = eas2tas(v_in,p,T);
        
    case ['TAS','CAS']
        v_out = zeros(size(v_in));
        for i = 1:length(v_in)
            v_out(i) = tas2cas(v_in(i),p,T);
        end
        
    case ['TAS','EAS']
        v_out = tas2eas(v_in,p,T);
        
end

% check input, convert output as required
if nargin == 6
    units = varargin{1};
    if strcmpi(units,'knots')
        v_out = v_out .* 1.94384;
    end
end
