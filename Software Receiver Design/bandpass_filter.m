function bpf_signal = bandpass_filter(signal, f_s, f_c)
    % Calculate normalized center frequency
    f_center = f_c / (f_s / 2);

    % Define band edges for the bandpass filter
    f_1 = f_center - 0.31;
    f_2 = f_center - 0.30;
    f_3 = f_center + 0.30;
    f_4 = f_center + 0.31;

    % Define filter characteristics
    f_l = 1000;
    f_f = [0, f_1, f_2, f_3, f_4, 1];
    f_a = [0, 0, 1, 1, 0, 0];

    % Design bandpass filter using Parks-McClellan algorithm
    filter_coefficients = firpm(f_l, f_f, f_a);

    % Apply filtering
    bpf_signal = filtfilt(filter_coefficients, 1, signal);
    
    % Plot
    figure;
    subplot(2,1,1);
    plot_spectrum(bpf_signal, 1/f_s);
    title('Bandpass Filtered Signal Spectrum');
    savefig('bandpass_filtered_signal.fig');
end
