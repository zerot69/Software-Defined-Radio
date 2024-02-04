function demodulated_signal = demodulator(signal, f_s, f_cut, f_a)
    % Low-pass filter
    filter_order = 1000;
    filter_band = [0, f_cut, f_cut + 0.01, 1];
    filter_coefficients = firpm(filter_order, filter_band, f_a);

    % Apply the filter to the downconverted signal
    demodulated_signal = filtfilt(filter_coefficients, 1, signal);

    % Plot
    figure;
    plot_spectrum(demodulated_signal, 1/f_s);
    title('Demodulated Signal Spectrum');
    savefig('demodulated_signal.fig');
end
