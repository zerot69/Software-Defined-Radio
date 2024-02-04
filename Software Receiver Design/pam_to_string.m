function string = pam_to_string(signal)
    sequence_length = length(signal);
    excess_symbols = mod(sequence_length, 4);
    
    if excess_symbols ~= 0
        signal = signal(1:sequence_length - excess_symbols);
        fprintf('Trimmed the last %i symbols\n', excess_symbols);
    end

    number_of_segments = length(signal) / 4;
    string = zeros(1, number_of_segments);

    for k = 0:number_of_segments - 1
        pam_segment = signal(4*k+1 : 4*k+4);
        decimal_value = base2dec(native2unicode((pam_segment + 99) / 2), 4);
        string(k + 1) = decimal_value;
    end

    string = native2unicode(string);

end
