function output = string_to_pam(string)
    N = length(string);
    output = zeros(1, 4 * N);
    
    for k = 0 : N-1
        char_value = double(string(k + 1)); % Convert character to ASCII value
        base4_rep = 2 * (dec2base(char_value, 4, 4) - '0') - 1;
        output(4*k+1 : 4*k+4) = base4_rep; % Store 4-PAM coding
    end
end
