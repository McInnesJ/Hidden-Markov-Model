# Hidden-Markov-Model
A Hidden Markov Model implemented in MATLAB

probability_density_function

This is the top-level script, from which all other functions are called. It is mostly
responsible for formatting of results and subsequent output. In addition, the
probability density functions are calculated and plotted in this script. As briefly
mentioned in the abstract, makedist() and pdf() were used to achieve this. makedist()
takes the mean and variance as inputs and produces a normal probability distribution.
This probability distribution is passed into pdf(), along with a range. A range of 0 to
10 was selected, as this adequately covers the range of observations (0.7-6.9). In
theory, this function would be continuous, however this is not practically realisable.
Instead, a continuous function must be approximated a closely as reasonable. In order
to achieve this an increment of 0.01 is used.


get_f_of_x

This function takes a ‘pdf’ and an ‘x’ value and returns the corresponding probability.
This is achieved by dividing the input value, x, by 0.01 and adding 1. By doing this
the value of the iterator corresponding to ‘x’ has been calculated. This iterator can
then be used to access the corresponding probability from the ‘pdf’ vector.
forward_procedure
Here, the forwards procedure is carried out. The equations are implemented from the
equations defined in the lecture notes.
backward_procedure
Here, the backwards procedure is carried out. The equations are implemented from
the equations defined in the lecture notes.


viterbi

In this function, the Viterbi algorithm is used to calculate maximum cumulative
likelihoods, the best path (X*) and the joint likelihood. A sub function,
get_optimal_path is also defined, and simply calculates and returns the optimal path
(i.e. the most likely states for each time, 1 to T). Once again, all equations are
implemented from the equations defined in the lecture notes. 

get_occupation_likelihood


This function calculates and returns the occupation likelihoods. In order to achieve
this the function required information obtained during the working of the forwards
and backwards procedure. As this is the only function that requires this information, it
is important that only this function has access to it, i.e. that the information is
correctly encapsulated.
As such, this function also includes a copy of the forwards and backwards procedure
functions as private sub-functions. While the public functions, mentioned above,
return only their respective likelihoods, the two private functions return both the
overall likelihoods and the matrices containing the individual likelihoods for each
time-state combination. 
