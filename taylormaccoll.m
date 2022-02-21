function [eps,pcp1,rcr1] = taylormaccoll(gam,M1,deltac)
% TAYLORMACCOLL Taylor-Maccoll Supersonic Flow Around a Cone
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
% [EPS,PCP1,RCR1] = TAYLORMACCOLL(GAMMA,M1,DELTAC) solves the
% Taylor-Maccoll problem of supersonic flow around an infinite axisymmetric
% cone at zero angle of attack, assuming perfect gas.
% 
% Inputs
% ------
% GAM : Ratio of specific heats
% M1 : Free stream Mach number
% DELTAC : Cone half-angle (deg)
% 
% Outputs
% -------
% EPS : Shock wave angle (deg)
% PCP1 : Ratio of cone surface pressure to free-stream static pressure
% RCR1 : Ratio of cone surface density to free-stream density
% 
% References
% ----------
% [1] Zucrow, Maurice J., and Joe D. Hoffmann. 1977. Gas Dynamics. 2:
% Multidimensional Flow. New York: Wiley.

% --------------------------------------------------
% Naming Conventions
% ------------------
% In reference [1], variables may be barred, subscripted, or starred.
% Barred notation represents variables in the spherical coordinate system.
% Starred variables are dimensionless.  The following subscripts are
% conventional.
% 
%   1: free-stream
%   s: immediately downstream of shock
%   c: surface of cone
%   0: stagnation (downstream of shock)
% 
% In the source code, variables are written as exemplified below.
% 
%   ubs_star
% 
% u => the variable u
% b => barred
% s => subscript s (i.e., immediately downstream of shock)
% _star => starred
% 
% In some functions, portions of the notation are omitted to declutter the
% code (e.g., in the function tm_integration, the b and _star notation is
% dropped), but the meaning should be obvious from reference [1].

% --------------------------------------------------
% convert deltac to radians
deltac = deltac.*pi./180;

% find the shock wave angle corresponding to input deltac
% slowly approach input M1 from above, updating optimization bounds
eps_min = deltac;
M1_domain = logspace(M1,10*M1);
M1_domain = log10(M1_domain);
M1_domain = fliplr(M1_domain);
for i = 1:length(M1_domain)
    eps = fminbnd(@(eps) tm_objfun(eps,gam,M1_domain(i),deltac), ...
        eps_min,80*pi/180);
    eps_min = eps;
end

% --------------------------------------------------
% use converged shock wave angle to compute properties at surface of cone
[velbs_star,p2p1,r1r2] = tm_shock(eps,gam,M1);
[psi,velb_star] = tm_integration_ha(eps,gam,velbs_star);

% transform velocity into 2-D components
u_star = velb_star(:,1).*cos(psi) - velb_star(:,2).*sin(psi);
v_star = velb_star(:,1).*sin(psi) + velb_star(:,2).*cos(psi);

% get components immediately downstream of shock
us_star = u_star(1);
vs_star = v_star(1);
Ms_star = sqrt(us_star.^2 + vs_star.^2);

% get components at surface of cone
n = length(psi);
u_star = u_star(n);
v_star = v_star(n);
M_star = sqrt(u_star.^2 + v_star.^2);

% compute property ratios
pcp0 = (1 - (M_star.^2).*(gam-1)./(gam+1)).^(gam./(gam-1));
rcr0 = (1 - (M_star.^2).*(gam-1)./(gam+1)).^(1./(gam-1));

p2p0 = (1 - (Ms_star.^2).*(gam-1)./(gam+1)).^(gam./(gam-1));
r2r0 = (1 - (Ms_star.^2).*(gam-1)./(gam+1)).^(1./(gam-1));

pcp1 = pcp0.*(1./p2p0).*p2p1;
rcr1 = rcr0.*(1./r2r0).*(1./r1r2);

% convert shock wave angle to degrees
eps = eps.*180./pi;

end

function [velbs_star,p2p1,r1r2] = tm_shock(eps,gam,M1)
% TM_SHOCK Taylor-Maccoll Properties Across Shock

% compute property ratios across the shock
p2p1 = (2.*gam./(gam+1)).*(M1.^2 .* sin(eps).^2 - (gam-1)./(2.*gam));
r1r2 = (2./(gam+1)).*((1./(M1.^2 .* sin(eps).^2)) + ((gam-1)./2));

beta = atan(r1r2.*tan(eps));

M1_star = (((gam+1).*M1.^2)./(2+(gam-1).*M1.^2)).^(1./2);
M2_star = M1_star.*(sin(eps)./sin(beta)).* ...
    (2./((gam+1).*M1.^2.*sin(eps).^2) + (gam-1)./(gam+1));

% ubs_star: u-bar* immediately downstream of shock
% vbs_star: v-bar* immediately downstream of shock
ubs_star = M2_star.*cos(beta);
vbs_star = -M2_star.*sin(beta);

velbs_star = [ubs_star,vbs_star];

end

function deltac_abserr = tm_objfun(eps,gam,M1,deltac)
% TM_OBJFUN Taylor-Maccoll Objective Function

% compute u-bar* and v-bar* immediately downstream of shock
[velbs_star,p2p1,r1r2] = tm_shock(eps,gam,M1);

% integrate from shock to surface of cone (v-bar* = 0)
[psi,velb_star] = tm_integration(eps,gam,velbs_star);

% determine absolute error between calculated and desired deltac
n = length(psi);
deltac_calc = psi(n);
deltac_abserr = abs(deltac_calc - deltac);

end

function [psi,vel] = tm_integration(eps,gam,vels)
% TM_INTEGRATION Taylor-Maccoll Integration
options = odeset('Events',@tm_cone_surface_event);
[psi,vel] = ode23tb(@(psi,vel) tm_odefun(psi,vel,gam), ...
    [eps 0], vels, options);
end

function [psi,vel] = tm_integration_ha(eps,gam,vels)
% TM_INTEGRATION_HA Taylor-Maccoll Integration High Accuracy
options = odeset('Events',@tm_cone_surface_event);
if exist('ode78')==2
    [psi,vel] = ode78(@(psi,vel) tm_odefun(psi,vel,gam), ...
        [eps 0], vels, options);
else
    disp('ODE78 does not exist; using ODE45.  Accuracy may be reduced.')
    [psi,vel] = ode45(@(psi,vel) tm_odefun(psi,vel,gam), ...
        [eps 0], vels, options);
end
end

function dvel_dpsi = tm_odefun(psi,vel,gam)
% TM_ODEFUN Taylor-Maccoll ODE Function
ub_star = vel(1);
vb_star = vel(2);

M_star_sq = ub_star.^2 + vb_star.^2;
aa_star_sq = (gam+1)./2 - M_star_sq.*(gam-1)./2;

dvel_dpsi(1,1) = vb_star;
dvel_dpsi(2,1) = -ub_star + ...
    (aa_star_sq.*(ub_star + vb_star.*cot(psi)))./ ...
    (vb_star.^2 - aa_star_sq);

end

function [value,isterminal,direction] = tm_cone_surface_event(psi,vel)
% TM_CONE_SURFACE_EVENT Taylor-Maccoll Cone Surface Event
value = vel(2);
isterminal = 1;
direction = 0;
end