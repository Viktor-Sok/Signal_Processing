%----recovering DTMT signal from the noise and interference ---%
%----Given singal consists of pulses with duration 45ms-------%
%----and time between pulses 40ms with noise and interference---%

%loading data
NoisySignal = load('signal.txt');
plot(NoisySignal, 'b');
%finding period of the power of the signal
signalPower = NoisySignal.*NoisySignal;
powerSpectrum = abs(fft(signalPower)); % using FFT
figure
plot(powerSpectrum);
%finding dominant frequency of the power changing in the signal
[amplitude,powerFrequency] = max (powerSpectrum(2:length(powerSpectrum)/2));
%period of the power
powerPeriod = length(NoisySignal)/powerFrequency
%sampling frequency (it is known that pulse duration equals 45ms and 
% the time between pulses is 40ms, that means period is 85ms )
samplingRate_kHz = powerPeriod/85
%deleting samples which corresponds to the time between pulsesfragments
signalReshape = reshape(NoisySignal, powerPeriod,[]);
samplesInPulse = samplingRate_kHz*40;
pulsesFragments = signalReshape(1:samplesInPulse,:);
%DFT of the each pulse fragment in the signal
DFTpulsesFragments = abs(fft(pulsesFragments)); % fft() calculates FFT for each column in the matrix
figure
plot(DFTpulsesFragments) % spectrum of the each pulse
%finding visually approximate DFT harmonics from the plot of the pulse spectrum
lowFreq1 = 28;
lowFreq2 = 31;
lowFreq3 = 34;
lowFreq4 = 38;
highFreq1 = 48;
highFreq2 = 53;
highFreq3 = 59;
%calculating numbers of DFT harmonics from the known DTMT signal frequencies
%and verifying that the DFT harmonic numbers above have been found correctly
nLow1 = samplesInPulse/samplingRate_kHz *0.697
nLow2 = samplesInPulse/samplingRate_kHz *0.770
nLow3 = samplesInPulse/samplingRate_kHz *0.852
nLow4 = samplesInPulse/samplingRate_kHz *0.941
nHigh1 = samplesInPulse/samplingRate_kHz *1.209
nHigh2 = samplesInPulse/samplingRate_kHz *1.336
nHigh3 = samplesInPulse/samplingRate_kHz *1.477
%extracting the rows from the DFTpulsesFragments assotiated with DFT harmonic numbers
DFTlowFreq = DFTpulsesFragments([28 31 34 38]+1,:);
DFThighFreq = DFTpulsesFragments([48 53 59]+1,:);
%decoding DFT frequencies to the dialed numbers on the phone
[amplitudeLowFreq, numberLowFreq] = max(DFTlowFreq);
[amplitudeHighFreq, numberHighFreq] = max(DFThighFreq);
decodingTable = [numberLowFreq; numberHighFreq]
