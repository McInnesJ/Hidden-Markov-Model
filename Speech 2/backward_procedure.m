function probability = backward_procedure(observations,A_matrix,pdfs)

    [a_height,a_width] = size(A_matrix);
    Tot_time = length(observations);
    
    start_prob = A_matrix(1,:);
    
    start_prob = start_prob(2:(a_width-1));
    
    intermediary_prob = A_matrix(2:(a_width-1),2:(a_height-1));
    
    end_prob = A_matrix(:,a_width);
    end_prob = end_prob(2:(a_height-1));
    
    
    number_of_states = length(start_prob);
    
    beta_matrix = zeros(number_of_states,Tot_time);
    for k = 1:number_of_states
        
        beta_matrix(k,Tot_time) = end_prob(k);
    end
    
    for time = Tot_time-1:-1:1
        for state = 1:number_of_states
            
            beta_time_state = 0;
            
            for from = 1:number_of_states
                %state: current state
                %from: state signal arrived from.
                
                observation_prob = get_f_of_x(pdfs(from,:),observations(time+1));
                
                beta_time_state = beta_time_state + intermediary_prob(state,from)*observation_prob*beta_matrix(from,time+1); 
            end
            
            beta_matrix(state,time) = beta_time_state;
        end
    end
    
    value = 0;
    for state = 1:number_of_states
        
        value = value + beta_matrix(state,1)*start_prob(state)*get_f_of_x(pdfs(state,:),observations(1));
        
    end

    probability = value; 
end


