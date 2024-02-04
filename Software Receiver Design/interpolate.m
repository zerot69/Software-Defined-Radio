function y = interpolate(signal, t, l, beta)
    if nargin == 3
        beta = 0;
    end
    t_now = round(t);
    tau = t - t_now;

    % Interpolate sinc at offset tau
    sinc_tau = srrc(l, beta, 1, tau);

    % Interpolate the signal
    signal_tau = conv(signal(t_now - l : t_now + l), sinc_tau);

    % Extract the new sample
    y = signal_tau(2 * l + 1);
end
