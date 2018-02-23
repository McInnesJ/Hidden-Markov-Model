function probability = state_alignment(observations,A_matrix,pdfs,most_likely_path)

    [a_height,a_width] = size(A_matrix);
    Tot_time = length(observations);
    
    start_prob = A_matrix(1,:);
    
    start_prob = start_prob(2:(a_width-1));
    
    intermediary_prob = A_matrix(2:(a_width-1),2:(a_height-1));
    
    end_prob = A_matrix(:,a_width);
    end_prob = end_prob(2:(a_height-1));
    
    
    x1 = most_likely_path(1);
    pre_factor = start_prob(x1)*get_f_of_x(pdfs(x1,:),observations(1));
    
    product = 1;
    x_t_minus_1 = x1;
    for time = 2:Tot_time
        
        x_t = most_likely_path(time);
        
        product = product*intermediary_prob(x_t_minus_1,x_t)*...
            get_f_of_x(pdfs(x_t,:),observations(time));
        
        x_t_minus_1 = x_t;
    end
    
    x_T = most_likely_path(Tot_time);
    post_factor = end_prob(x_T);
    
    probability = pre_factor*product*post_factor;
end

