function [path_probability,best_path,max_cumulative_likelihood] = viterbi(observations,A_matrix,pdfs)

    [a_height,a_width] = size(A_matrix);
    Tot_time = length(observations);
    
    start_prob = A_matrix(1,:);
    
    start_prob = start_prob(2:(a_width-1));
    
    intermediary_prob = A_matrix(2:(a_width-1),2:(a_height-1));
    
    end_prob = A_matrix(:,a_width);
    end_prob = end_prob(2:(a_height-1));
    
    
    number_of_states = length(start_prob);
    
    delta_matrix = zeros(number_of_states,Tot_time);
    psi_matrix = zeros(number_of_states,Tot_time);
    
    for k = 1:number_of_states
       
        delta_matrix(k,1) = start_prob(k)*get_f_of_x(pdfs(k,:),observations(1));
        
        psi_matrix(k,1) = 0;
    end
    
    for time = 2:Tot_time
        for state = 1:number_of_states
            
            possible_max = zeros(1,number_of_states);
            for from = 1:number_of_states
                %state: current state
                %from: state signal arrived from.
                
                possible_max(from) = delta_matrix(from,time-1)...
                    *intermediary_prob(from,state);
            end
            
            [max_val,iterator] = max(possible_max);
            
            delta_matrix(state,time) = max_val*get_f_of_x(pdfs(state,:),observations(time));
            psi_matrix(state,time) = iterator;
        end
        
    end
    
    possible_path_prob = zeros(1,number_of_states);
    for state = 1:number_of_states
       
        possible_path_prob(state) = delta_matrix(state,Tot_time)*end_prob(state);       
    end
    
    [path_probability,end_point_iterator] = max(possible_path_prob);
    
    best_path = get_optimal_path(end_point_iterator,psi_matrix,Tot_time);
    
    mcl = zeros(1,Tot_time);
    for time = 1:Tot_time
        for state = 1:number_of_states
            mcl(time) = delta_matrix(best_path(time),time);
        end
    end
    max_cumulative_likelihood = mcl;
end

function optimal_path = get_optimal_path(end_point,psi_matrix,Tot_time)

    path = zeros(1,Tot_time);
    path(Tot_time) = end_point;
    
    for time = Tot_time-1:-1:1
        
        path(time) = psi_matrix(path(time+1),time+1);
    end
    
    optimal_path = path;
end

