function equalized_signal = equalizer(signal)
    % Parameters
    order = 9;
    f = [0 1 0 0 0 0 0 0 0]';
    step = .001;

    % Initialization
    index = 1;
    
    % Plot
    figure;
    subplot(2,1,1);
    plot(1:length(signal), signal, '.');
    title('Unequalized Constellation Diagram');

    % Adaptive Equalization using LMS algorithm
    for i = order + 1:length(signal)
        reversed = signal(i:-1:i - order + 1)';
        e = quantizer(f' * reversed, [-3 -1 1 3]) - f' * reversed;
        f = f + step * e * reversed;
        signal(index) = reversed' * f;
        index = index + 1;
    end

    % Output
    equalized_signal = signal;

    % Plot
    subplot(2,1,2);
    plot(1:length(equalized_signal), equalized_signal, '.');
    title('Equalized Constellation Diagram');
    savefig('equalized_constellation_diagram.fig');
end
