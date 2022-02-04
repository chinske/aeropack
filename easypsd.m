function [pxx,f] = easypsd(t,x,plotflag)
% EASYPSD Easy Power Spectral Density
% Copyright 2022 Christopher Chinske
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
% Requires: Signal Processing Toolbox
% 
% [PXX,F] = EASYPSD(T,X,PLOTFLAG) uses PWELCH to compute the power spectral
% density (PSD) estimate of the signal X(T).  The function assumes a
% constant sample rate.  The function returns the PSD estimate PXX (dB/Hz)
% and a frequency vector F (Hz).
% 
% If PLOTFLAG == 1, the function plots the PSD in the current figure
% window.

% compute the sampling frequency (i.e., sample rate)
n = length(t);
fs = (n-1)./(t(length(t)) - t(1));

% use PWELCH
[pxx,f] = pwelch(x,[],[],[],fs);
pxx = 10*log10(pxx);

% plot
if plotflag == 1
    plot(f,pxx);
    xlabel('Frequency (Hz)')
    ylabel('PSD (dB/Hz)')
end