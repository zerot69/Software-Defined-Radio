function quantized_signal = quantizer(signal, alphabet)
    % Input validation
    assert(isvector(signal) && isvector(alphabet), 'Input vectors must be 1-dimensional.');
    assert(issorted(alphabet), 'Alphabet vector must be sorted in ascending order.');

    % Reshape input vectors
    alphabet = alphabet(:);
    signal = signal(:);

    % Preallocate memory
    % dist = zeros(numel(x), numel(alphabet));
    % y = zeros(size(x));

    % Calculate squared Euclidean distance matrix
    dist = (signal - alphabet').^2;

    % Find indices and values of minimum distances
    [~, i] = min(dist, [], 2);

    % Construct quantized vector
    quantized_signal = alphabet(i);    
end
