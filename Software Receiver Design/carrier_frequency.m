function f_c = carrier_frequency(f_if, f_s)
    while abs(f_if - f_s) < f_if
        f_if = abs(f_if - f_s);
    end
    
    f_c = f_if;
    % disp(['f_c: ', num2str(f_c)]);
end
