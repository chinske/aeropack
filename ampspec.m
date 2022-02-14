function [f,P1] = ampspec(t,x,plotflag)
% AMPSPEC Amplitude Spectrum
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
% [F,P1] = ampspec(T,X,PLOTFLAG) computes the single-sided amplitude
% spectrum of the signal X(T).  The function assumes a constant sample
% rate.
% 
% If PLOTFLAG == 1, the function plots the amplitude spectrum in the
% current figure window.

% compute the sampling frequency (i.e., sample rate)
n = length(t);
fs = (n-1)./(t(length(t)) - t(1));

% compute the FFT
y = fft(x);

% --------------------------------------------------
% compute the two-sided spectrum P2
% compute the single-sided spectrum P1 based on P2
% --------------------------------------------------
% magnitude of complex values
P2 = abs(y/n);

% P1 based on P2 values corresponding to positive frequencies
P1 = P2(1:floor(n/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

% compute discrete frequency domain
f = fs*(0:floor(n/2))/n;

% plot
if plotflag == 1
    plot(f,P1)
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
end