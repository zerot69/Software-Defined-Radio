function filtered_signal = pulse_matched_filter(signal, upsampling_ratio, SRRCLength, SRRCrolloff, f_s)
    
    disp(['upsampling_ratio: ', num2str(upsampling_ratio)]);
    disp(['SRRCLength: ', num2str(SRRCLength)]);

    % Create the pulse shape
    pulse_shape = custom_pulse_shape(SRRCLength, SRRCrolloff, upsampling_ratio);
    
    % Perform the filtering
    filtered_signal = conv(signal, pulse_shape, 'same');

    % Plot
    figure;
    plot_spectrum(filtered_signal, 1/f_s);
    title('Pulse Matched Filtered Signal Spectrum');
    savefig('pulse_matched_filtered_signal.fig');
end

function pulse_shape = custom_pulse_shape(SRRCLength, SRRCrolloff, upsampling_ratio)
    % Generate pulse shape using linear interpolation

    % Create the original pulse shape
    original_pulse = rcosdesign(SRRCrolloff, SRRCLength, 1, 'sqrt');

    % Upsample the pulse shape
    upsampled_pulse = interp1(1:SRRCLength, original_pulse, 1:1/upsampling_ratio:SRRCLength, 'linear');

    pulse_shape = upsampled_pulse / sum(upsampled_pulse); % Normalize the pulse shape
end
