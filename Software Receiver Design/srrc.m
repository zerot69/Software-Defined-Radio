function srrs_pulse = srrc(syms, beta, P, t_off)
    % Default value for t_off if not provided
    if nargin < 4
        t_off = 0;
    end
    
    % Avoid division by zero for beta = 0
    if beta == 0
        beta = 1e-8;
    end

    % Sampling indices as a multiple of T/P
    k = (-syms * P + 1e-8 + t_off):(syms * P + 1e-8 + t_off);

    % Calculation of SRRC pulse
    srrs_pulse = 4 * beta / sqrt(P) * (cos((1 + beta) * pi * k / P) + ...
        sin((1 - beta) * pi * k / P) ./ (4 * beta * k / P)) ./ ...
        (pi * (1 - 16 * (beta * k / P).^2));
end
