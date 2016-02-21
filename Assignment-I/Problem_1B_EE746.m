%Code for Problem 1 part B in Assignment of EE 746 
E_L=-70e-3;
V_to=20e-3;
Prompt='Number of Neurons to ba analysed simeltanously,N = ';
N=input(Prompt);
V_t=E_L*ones(N,1);
V_O=E_L*ones(N,1);
Prompt='Time when this needs to be analysed,t =  ';
t=input(Prompt);
Prompt='Number of Time Steps required ,M = ';
M=input(Prompt);
Prompt='Input Data for the currents ';
V_data=input(Prompt);
Output=zeros(N,M);
del_t=t/M;
C=300e-12;
g_L=30e-9;
for i=1:M-1
V_tPrevious=V_t;
D_EPrevious=(1/C)*(-g_L(V_t-V_O)+Input(:,i));
V_t=V_t+(1/C)*(-g_L*(V_t-V_O)+Input(:,i))*del_t;
D_ENew=(1/C)*-g_L*(V_t-V_O)+Input(:,i+1);
V_t=V_tPrevious+(D_EPrevious+D_ENew)*del_t/2;
Output(:,i)=V_t;
for j=1:N
if (V_t(j)>=V_to)
V_t(j)=E_L;
Output(j,i)=V_t(j);
end
end
end
Output(:,M)=V_t+(1/C)*(-g_L(V_t-V_O)+Input(:,M))*del_t;
V_t=Output(:,M);


