function x_corr = cross_correlation(signal, preamble, userDataLength)
    % Define variables
    header = string_to_pam(preamble);
    header_length = length(header);
    data_length = userDataLength * 4;
    frame_length = header_length + data_length; 

    % Cross-correlation
    cross_correlation = xcorr(header, signal);
    
    % Find header start index
    [~, index] = max(abs(cross_correlation));
    head_start = mod(length(signal) - index + 1, frame_length);

    % Trim the initial header part
    x = signal(head_start + header_length - 8:end);

    % Determine header direction
    z1 = 1:1:(length(x)/2) - (frame_length/2);
    c1 = xcorr(header, x(z1));
    
    % Check and flip the header if necessary
    if max(c1) < abs(min(c1))
        x(z1) = x(z1) * -1;  
    end

    % Extract frames
    frame_counter = 0;
    x_frames = zeros(1, floor(length(x) * data_length / frame_length));
    for i = 1:frame_length:length(x)
        if i < length(x)
            x_frames(i - (header_length * frame_counter):i + data_length - 1 - (header_length * frame_counter)) = x(i:i + data_length - 1);
        end
        frame_counter = frame_counter + 1;
    end
    x_corr = x_frames;

    % Plot
    figure;
    subplot(1, 1, 1), stem(header);
    title('Header');    
    savefig('header.fig');
    
    figure;
    subplot(2, 1, 1), stem(signal);
    title('Data with embedded header');    
    subplot(2, 1, 2), stem(cross_correlation);
    title('Correlation');
    savefig('cross_correlation.fig');
end
