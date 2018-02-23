function value = get_f_of_x(pdf,x)

    iterator = x/0.01 + 1;
    value = pdf(round(iterator));
    
end

