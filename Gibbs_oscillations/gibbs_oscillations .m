%---------------------------------------------%
%--------------signal parameters--------------%
%voltage, V
u1 = 3; 
u2 = 6; 
u3 = 0;
u4 = -4;
%time, ms
t1 = 3;
t2=5;
%sampling frequency(sample rate), kHz
Fd = 8;
%---------------------------------------------%
%----------plotting descrete signal-----------%

tau = 1 /Fd; %sampling period
timesOfSamples = 0 : tau : t2;

%parts of the function samples
u1 = u1 + ((u2 - u1)/u1)*timesOfSamples(1:(t1/tau+1));
u2 = u4/(t2-t1)*timesOfSamples((t1/tau+2): end);
%all samples 
samples = [[u1] [u2]];
%plotting descrete signal
stem(timesOfSamples, samples, '.')
hold on
%-------------------------------------------------------%
%-------Some of the characteristics of the signal-------%
fprintf('Number of Samples: ')
numberOfSamples = length(samples)
fprintf('DTFT at zero frequency: ')
DTFTatZeroFrequency = sum(samples)
fprintf('DTFT at nyquist frequency: ')
DTFTatNyquistFrequency = sum(samples(1:2:end)) - sum(samples(2:2:end))
fprintf('Energy of the signal: ')
Energy = sum(samples.^2)
%-----------------------------------------------%
%---Recovering the original analog signal via---%
%-------Nyquist–Shannon sampling theorem--------%
t = -5*tau : tau/10 : t2+ 5*tau; % analog time
recoveredSignal = zeros(size(t));% vector for storing recovered signal
for k = 1 : length(samples)
    %using Nyquist–Shannon theorem to recover the signal
    recoveredSignal = recoveredSignal + sinc((t - (k-1)*tau)/tau)*samples(k);
end
%plotting recoverd signal
plot(t, recoveredSignal, 'r')
hold off


