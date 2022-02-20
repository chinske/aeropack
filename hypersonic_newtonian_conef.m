function [CN,CA] = hypersonic_newtonian_conef(delta,L,Rn,Rb,S,alpha)
% HYPERSONIC_NEWTONIAN_CONEF Hypersonic Cone Frustum
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
% [CN,CA] = HYPERSONIC_NEWTONIAN_CONEF(DELTA,L,RN,RB,S,ALPHA) returns the
% hypersonic aerodynamic characteristics of a cone frustum by the Newtonian
% theory.
% 
% INPUTS
% DELTA:    Conical half angle (deg)
% L:        Length
% RN:       Nose radius
% RB:       Base radius
% S:        Reference area
% ALPHA:    Angle of attack (deg)
% 
% OUTPUTS
% CN:       Normal force coefficient
% CA:       Axial force coefficient
% 
% REFERENCES
% [1] Clark, E L, and L L Trimmer. n.d. “Equations and Charts for the
% Evaluation of the Hypersonic Aerodynamic Characteristics of Lifting
% Configurations by the Newtonian Theory,” 90.



% ratio of nose radius to base radius
xi = Rn./Rb;

% convert input angles to radians
delta = delta.*pi./180;
alpha = alpha.*pi./180;

% common term
term0 = 2.*L.*Rb.*(1+xi)./S;



if (0 <= alpha) && (alpha <= delta) % no shielding

    % normal force coefficient (Clark and Trimmer Eq. 133)
    CN = term0.*pi.*cos(alpha).*sin(alpha).*sin(delta).*cos(delta);

    % axial force coefficient (Clark and Trimmer Eq. 139)
    term1 = pi.*tan(delta)./2;
    term2 = 2 .* cos(alpha).^2 .* sin(delta).^2 + ...
        sin(alpha).^2 .* cos(delta).^2;

    CA = term0.*term1.*term2;

elseif (delta < alpha) && (alpha <= (pi-delta)) % shielding

    % normal force coefficient (Clark and Trimmer Eq. 135)
    term1 = cos(alpha).*sin(alpha).*sin(delta).*cos(delta);
    term2 = pi./2 + asin(tan(delta)./tan(alpha));
    term3 = 2 .* sin(alpha).^2 .* cos(delta).^2 + ...
        sin(delta).^2 .* cos(alpha).^2;
    term4 = 3 .* sin(alpha) .* cos(delta);
    term5 = sqrt(sin(alpha).^2 - sin(delta).^2);

    CN = term0.*(term1.*term2 + (term3./term4).*term5);

    % axial force coefficient (Clark and Trimmer Eq. 141)
    term1 = tan(delta)./2;
    term2 = 2 .* cos(alpha).^2 .* sin(delta).^2 + ...
        sin(alpha).^2 .* cos(delta).^2;
    term3 = pi./2 + asin(tan(delta)./tan(alpha));
    term4 = 3 .* cos(alpha) .* sin(delta);
    term5 = sqrt(sin(alpha).^2 - sin(delta).^2);

    CA = term0.*term1.*(term2.*term3 + term4.*term5);

else
    error('ALPHA out of range, 0 <= ALPHA <= 180-DELTA')
end