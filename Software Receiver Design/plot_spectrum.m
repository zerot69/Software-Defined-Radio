function plot_spectrum(signal, T_s)
    N = length(signal);
    t = T_s * (1 : N);
    ssf = (-N/2 : N/2-1) / (T_s * N);
    fx = fft(signal(1 : N));
    fxs = fftshift(fx);

    % Plot
    subplot(2, 1, 1);
    plot(t, signal);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('Waveform');
    subplot(2, 1, 2);
    plot(ssf, abs(fxs));
    xlabel('Frequency');
    ylabel('Magnitude');
    title('Magnitude Spectrum');
end
