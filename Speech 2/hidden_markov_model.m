
A_matrix = [0,0.92,0.08,0,0;
            0,0.83,0.12,0.05,0;
            0,0,0.87,0.07,0.06;
            0,0,0.11,0.85,0.04;
            0,0,0,0,0];

[~,width] = size(A_matrix);
number_of_states = width-2;

means = [1.1,4.0,5.7];
variances = [0.36,1.21,0.16];

observations = [0.7,1.3,2.3,5.0,5.6,6.9,5.9,2.8,3.3];
tot_time = length(observations);

range = 0:0.01:10;
pdfs = zeros(number_of_states,length(range));

output_p_d = zeros(number_of_states,tot_time);

for i = 1:number_of_states
    
    pd = makedist('Normal', 'mu', means(i), 'sigma', sqrt(variances(i)));
    
    prob_dist_func = pdf(pd,range);
    pdfs(i,:) = prob_dist_func;
    
    name = strcat('b', num2str(i));
    
    figure('Name', name);
    plot(range, prob_dist_func);
    
    hold on 
    for time = 1:length(observations)
       
        iterator = observations(time)/0.01 + 1;
        probability_value = prob_dist_func(round(iterator));
        output_p_d(i,time) = probability_value;
        
        disp(strcat('b',num2str(i),'(o',num2str(time),') = '));
        disp(probability_value);
        
        plot(observations(time),probability_value,'Marker','x','MarkerSize',10,'Color','g');   
    end
    hold off
    
    disp('******    ******    ******    ******    ******    ******    ******');
end

forward_prob = forward_procedure(observations,A_matrix,pdfs);
disp('Forward Procedure: ');
disp(forward_prob);

backward_prob = backward_procedure(observations,A_matrix,pdfs);
disp('Backwards Procedure: ');
disp(backward_prob);

disp('******    ******    ******    ******    ******    ******    ******');

[path_probability,optimal_path,mcl] = viterbi(observations,A_matrix,pdfs);
disp('Optimal Path: ');
disp(optimal_path);
disp('Path Probability ');
disp(path_probability);

disp('Maximum Cumulative Likelihood: ')
for i = 1:length(mcl)
    disp(mcl(i));
end

disp('******    ******    ******    ******    ******    ******    ******');

occupation_likelihoods = get_occupation_likelihood(observations,A_matrix,pdfs);

for time = 1:tot_time
    time_message = strcat('Time = ', num2str(time));
    disp(time_message);
    
    for state = 1:number_of_states
        state_message = strcat('Probability for state ', num2str(state));
        disp(state_message);
        
        disp(occupation_likelihoods(state,time));
        
    end
end

disp('******    ******    ******    ******    ******    ******    ******');

disp(state_alignment(observations,A_matrix,pdfs,optimal_path));




