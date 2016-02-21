%Defining Fanout in the Neuron with neuron named from 'a' to 'e' being numbered as 1 to 5 
Fanout=[ [] ,[] ,[] ,[], [] ,[]];
Fanout{1}=[2,3,4];
Fanout{2}=[];
Fanout{3}=[];
Fanout{4}=[];
Fanout{5}=[2,3,4];
%weight of each synapse coming on to the neuron 
Weights=[[3000,3000,3000],[],[],[],[3000,3000,3000]];
%Delay Matrix in the synaptic model
Delay=[[1e-3,5e-3,9e-3],[],[],[],[8e-3,5e-3,1e-3]];
