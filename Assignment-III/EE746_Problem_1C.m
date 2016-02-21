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
%Modelling the 'Improved' Leaky Integrate and Fire Model
C=300e-12; %capacitance for the leaky integrate and fire
g_L=30e-9;  %Just a Constant Resistance Factor
V_T=20e-3; %Action Potential in the model
E_L=-70e-3;%Reset Potenntial
R_p=2e-3;  %Delay Time 
I_O=1e-12; %base Current
T_W=15e-3; %Time constant 1 
T_S=T_W/4;  %time Constant 2
I_A=50e-9;  %Input Amplitude
del_t=0.1e-3;
%defining Some Cell Arrays 
Spike_time= []; %When the neuron spikes 
Arrival_time=[];%When the spike arrives on the post synaptic neuron 
%Code for the Case 1 
I_app=[[],[],[],[],[]];
I_app{1}=zeros(1,5000);
I_app{5}=zeros(1,5000);
I_app{2}=zeros(1,5000);
I_app{2}(1,70:79)=I_A*ones(1,10);
I_app{3}=zeros(1,5000);
I_app{3}(30:39)=I_A*ones(1,10);
I_app{4}=zeros(1,5000);
I_app{4}(1:10)=I_A*ones(1,10);
V_Response=[[],[],[],[],[]];
I_syn=[[],[],[],[],[]];
for i =1 : 5
V_Response{i}=E_L*ones(1,5000);
I_syn{i}=zeros(1,5000);
end
m=[];
V_t=[E_L , E_L ,E_L , E_L ,E_L];
V_O=V_t;

for i=1:5
    j=1;
while (j<5000)
Input=[I_app{1}(1,j),I_app{2}(1,j),I_app{3}(1,j),I_app{4}(1,j),I_app{5}(1,j)];
V_tprevious=V_t(i);
D_EPrevious=(1/C).*(-g_L*(V_t(i)-V_O(i))+Input(i));
V_t(i)=V_t(i)+(1/C)*(-g_L*(V_t(i)-V_O(i))+Input(i))*del_t;
Input=[I_app{1}(1,j+1),I_app{2}(1,j+1),I_app{3}(1,j+1),I_app{4}(1,j+1),I_app{5}(1,j+1)];
D_ENew=(1/C)*((-g_L)*(V_t(i)-V_O(i))+Input(i));
V_t(i)=V_tprevious+((D_EPrevious+D_ENew)*del_t/2);

if V_t(i)>=V_T
m=[m,j];
j=j+20;
V_Response{i}(1,j:j+19)=V_t(i)*ones(1,20);
V_t(i)=E_L;
else
V_Response{i}(1,j)=V_t(i);
j=j+1;
end

end
end
