function probability = forward_procedure(observations,A_matrix,pdfs)

    [a_height,a_width] = size(A_matrix);
    Tot_time = length(observations);
    
    start_prob = A_matrix(1,:);
    
    start_prob = start_prob(2:(a_width-1));
    
    intermediary_prob = A_matrix(2:(a_width-1),2:(a_height-1));
    
    end_prob = A_matrix(:,a_width);
    end_prob = end_prob(2:(a_height-1));
    
    
    number_of_states = length(start_prob);
    
    alpha_matrix = zeros(number_of_states,Tot_time);
    for k = 1:number_of_states
       
        alpha_1k = start_prob(k)*get_f_of_x(pdfs(k,:),observations(1));
        
        alpha_matrix(k,1) = alpha_1k;
    end
    
    for time = 2:Tot_time
        for state = 1:number_of_states
            observation_prob = get_f_of_x(pdfs(state,:),observations(time));
            
            alpha_time_state = 0;
            
            for from = 1:number_of_states
                %state: current state
                %from: state signal arrived from.
                
                alpha_time_state = alpha_time_state + intermediary_prob(from,state)*observation_prob*alpha_matrix(from,time-1); 
            end
            
            alpha_matrix(state,time) = alpha_time_state;
        end
    end
    
    value = 0;
    for state = 1:number_of_states
        
        value = value + alpha_matrix(state,Tot_time)*end_prob(state);
        
    end

    probability = value; 
end


