function recovered_signal = timing_recovery(signal, upsampling_ratio, SRRCLength, SRRCrolloff)
    % Timing Recovery by Output-Power Maximization 
    % Initialize variables
    n = round(length(signal) / upsampling_ratio);
    t_now = SRRCLength * upsampling_ratio + 1;
    tau = 0.01;
    xs = zeros(1, n);
    tau_save = zeros(1, n);
    tau_save(1) = tau;
    i = 0;
    step = 0.002;
    delta = 0.1;

    while t_now < length(signal) - 2 * SRRCLength * upsampling_ratio
        i = i + 1;
        
        % Interpolate signal at current time + timing offset
        xs(i) = interpolate(signal, t_now + tau, SRRCLength, SRRCrolloff);
        
        % Calculate numerical derivative
        right = interpolate(signal, t_now + tau + delta, SRRCLength, SRRCrolloff);
        left = interpolate(signal, t_now + tau - delta, SRRCLength, SRRCrolloff);
        derivative = right - left;
        
        % Update timing offset using the algorithm
        tau = tau + step * derivative * xs(i);
        
        t_now = t_now + upsampling_ratio;
        tau_save(i) = tau;
    end  
    
    % Calculate the scaling factor    
    sampling_factor = max(abs(xs(1:i)));
    scaling_factor = upsampling_ratio / sampling_factor;
    % disp(['scaling_factor: ', num2str(scaling_factor)]);
    
    % Adjust the output signal
    recovered_signal = scaling_factor * xs(1:i);

    % Plot
    figure;
    subplot(2, 1, 1);
    plot(recovered_signal(1:i - 2), 'b.');
    title('Timing Recovery Constellation');
    ylabel('Estimated Symbols');
    subplot(2, 1, 2);
    plot(tau_save(1:i - 2));
    ylabel('Timing Offset');
    xlabel('Iterations');
    savefig('timing_recovery_constellation.fig');
end