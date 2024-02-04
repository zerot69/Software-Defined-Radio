function carrier_estimate = costas_loop(signal, f_s, f_0, f_a)
    % Time vector
    t = (0:length(signal) - 1) / f_s;
    
    % LPF characteristics for the Costas loops
    f_l = 100;
    f_f = [0, .001, .002, 1];
    h = firpm(f_l, f_f, f_a);
    
    % Algorithm stepsize
    step_1 = .04;
    step_2 = .0002;    
    theta_1 = zeros(size(signal));
    theta_2 = zeros(size(signal));
    zs_1 = zeros(1, f_l + 1);
    zc_1 = zeros(1, f_l + 1);
    zs_2 = zeros(1, f_l + 1);
    zc_2 = zeros(1, f_l + 1);
    t_term = 2 * pi * f_0 * t;
    
    % Carrier estimate vector
    carrier_estimate = zeros(size(signal));
    
    % Loop processing
    for k = 1:length(signal)-1
        % Frequency tracking loop
        zs_1 = [2 * signal(k) * sin(t_term(k) + theta_1(k)), zs_1(1:f_l)];
        zc_1 = [2 * signal(k) * cos(t_term(k) + theta_1(k)), zc_1(1:f_l)];
        lpfs_1 = fliplr(h) * zs_1';
        lpfc_1 = fliplr(h) * zc_1';
        theta_1(k+1) = theta_1(k) - step_1 * lpfs_1 * lpfc_1;

        % Phase tracking loop
        zs_2 = [2 * signal(k) * sin(t_term(k) + theta_1(k) + theta_2(k)), zs_2(1:f_l)];
        zc_2 = [2 * signal(k) * cos(t_term(k) + theta_1(k) + theta_2(k)), zc_2(1:f_l)];
        lpfs_2 = fliplr(h) * zs_2';
        lpfc_2 = fliplr(h) * zc_2';
        theta_2(k+1) = theta_2(k) - step_2 * lpfs_2 * lpfc_2;
        
        % Carrier estimate update
        carrier_estimate(k) = cos(t_term(k) + theta_1(k) + theta_2(k));
    end
    
    % Plot
    figure;
    subplot(2, 1, 1);
    plot(t, theta_1);
    title('Frequency');
    ylabel('\theta_{freq}');
    subplot(2, 1, 2);
    plot(t, theta_2);
    title('Phase');
    ylabel('\theta_{phase}');
    savefig('costas_loop.fig');
