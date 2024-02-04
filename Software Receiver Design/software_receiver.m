%% Prompt user to select and load a mystery signal
clc;
close all;
selected = input('[1] mysteryA\n[2] mysteryB\n[3] mysteryC\nSelect mystery signal: ');
switch selected
    case 1
        load('mysteryA.mat');
    case 2
        load('mysteryB.mat');
    case 3
        load('mysteryC.mat');
    otherwise
        error('Error! Invalid selection. Please try again.');
end

% Signals params
SRRCLength = [4, 5, 3];
SRRCrolloff = [0.33, 0.4, 0.14];
T_t = [8.9e-6, 7.5e-6, 8.14e-6];
f_if = [1.6e6, 1.2e6, 2.2e6];
f_s = [700e3, 950e3, 819e3];

% Set params based on the selected signal
SRRCLength = SRRCLength(selected);
SRRCrolloff = SRRCrolloff(selected);
f_s = f_s(selected);
T_t = T_t(selected);
f_if = f_if(selected);

% Additional params
preamble = '0x0 This is is the Frame Header 1y1';
userDataLength = 125;
upsampling_ratio = f_s * T_t;
N_freq = f_s / 2;
f_a = [1, 1, 0.5 , 0];

% Transpose the received signal
signal = r;
signal = signal';

% Plot
figure;
plot_spectrum(signal, 1/f_s);
savefig('received_signal.fig');

% Calculate Carrier Frequency
f_c = carrier_frequency(f_if, f_s);

%% Bandpass Filtering
filtered_signal = bandpass_filter(signal, f_s, f_c);

%% Carrier Recovery  
carrier_estimate = costas_loop(signal, f_s, f_c, f_a);

%% Downconversion
downconverted_signal = downconverter(filtered_signal, carrier_estimate, f_s);

%% Demodulation
f_cut = 0.2;
demodulated_signal = demodulator(downconverted_signal, f_s, f_cut, f_a);

%% Timing Recovery
timing_recovered_signal = timing_recovery(demodulated_signal, upsampling_ratio, SRRCLength, SRRCrolloff);

%% Header Correlation
header_correlated_signal = cross_correlation(timing_recovered_signal, preamble, userDataLength);

%% Equalization
equalized_signal = equalizer(header_correlated_signal);

%% Quantization
quantized_signal = quantizer(equalized_signal, [-3, -1, 1, 3])';

% Plot
figure;
plot_spectrum(quantized_signal, 1/f_s);
savefig('quantized_signal.fig');

%% Message Reconstruction
reconstructed_signal = pam_to_string(quantized_signal);

%% Display Reconstructed Message
fprintf('\n===========================================================================\n');
disp(reconstructed_signal);