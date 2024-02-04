function downconverted_signal = downconverter(signal, carrier_estimate, f_s)
    % Downconversion to shift the signal back to baseband 
    downconverted_signal = signal .* carrier_estimate;
    
    % Plot
    figure;
    plot_spectrum(downconverted_signal, 1/f_s);
    title('Downconverted Signal Spectrum');
    savefig('downconverted_signal.fig');
end
