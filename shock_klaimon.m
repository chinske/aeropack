function r_rt = shock_klaimon(gamma,M,x_rt)
% SHOCK_KLAIMON Klaimon's Correlation for Blunted Cone Shock Shapes
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
% R_RT = SHOCK_KLAIMON(GAMMA,M,X_RT) returns r/rt of the shock shape for
% the input x/rt as given by Klaimon's bow shock correlation for slightly
% blunted cones in hypersonic flow.  See [1] for details and depictions of
% the coordinate system.
% 
% Inputs
% ------
% GAMMA : Cone half-angle (deg)
% M     : Free stream Mach number
% X_RT  : Vector of x-coordinates normalized by nose tip radius rt
% 
% References
% ----------
% [1] Klaimon, Jerold H. 1963. “BOW SHOCK CORRELATION FOR SLIGHTLY BLUNTED
% CONES.” AIAA Journal 1 (2): 490–91. https://doi.org/10.2514/3.1581.

% modified Newtonian theory
CDT = 2 - cosd(gamma).^2;

% end of curved shock region
delta = asind((4 + 1.01.*(M.*sind(gamma) - 3.43))./M);
r_rtc_end = (0.984.*CDT.*((1./sind(delta).^2) - 1)).^0.426;

% Klaimon Eq. (2)
x_rtc = x_rt./cosd(gamma);
r_rtc = 1.424.*((CDT.^0.5).*x_rtc).^0.46;

% apply Klaimon criteria Eqs. (4) and (5)
i_end = 0;
i = 1;
while (i_end == 0) && (i <= length(r_rtc))
    if r_rtc(i) > r_rtc_end
        i_end = i - 1;
    end
    i = i+1;
end

r_rt = r_rtc.*cosd(gamma);

for i = i_end:length(r_rt) - 1
    r_rt(i+1) = r_rt(i) + (x_rt(i+1)-x_rt(i)).*tand(delta);
end