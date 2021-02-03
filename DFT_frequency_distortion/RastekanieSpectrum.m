%number of periods of the signal are a whole number
t = 0:0.125:36;
f = 1/4;
analog = cos(2*pi*f*t);
figure
plot(t, analog)
hold on
%sampling1
N = 10;
tau1 = 1/(N*f);
times = 0 : tau1 : 36-tau1;
descrete1 = cos(2*pi*f*times);
stem(times, descrete1)
hold off
Wn = 2*pi*f*tau1;
counts = 0 : length(times)-1;
samples = cos(Wn*counts);
figure
stem(counts, samples)
%---fft
samples1 = samples(1:length(samples));
counts1 = counts(1:length(counts));
dft = abs(fft(samples1));
figure
stem(counts1, dft)
%sampling2
N2=10;
tau2 = 3/(N2*f);
counts2 = 0: 36/tau2 -1;
samples2 = cos(2*pi*f*tau2*counts2);
figure
stem(counts2, samples2)
%---fft
dft2 = abs(fft(samples2));
figure
stem(counts2, dft2)
