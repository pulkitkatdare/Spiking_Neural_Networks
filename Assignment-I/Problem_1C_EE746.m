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
%Prompt='Input Data for the currents ';
%V_data=input(Prompt);
Output=zeros(N,M);
del_t=t/M;
C=300e-12;
g_L=30e-9;
I_c=-g_L*E_L+g_L*V_to;
Input=zeros(N,M);

for j=1:N
Input(j,:)=I_c*(1+j*0.1)*ones(1,M);
end
for i=1:M-1
V_tPrevious=V_t;
D_EPrevious=(1/C)*(-g_L*(V_t-V_O)+Input(:,i));
V_t=V_t+(1/C)*(-g_L*(V_t-V_O)+Input(:,i))*del_t;
D_ENew=(1/C)*((-g_L)*(V_t-V_O)+Input(:,i+1));
V_t=V_tPrevious+((D_EPrevious+D_ENew)*del_t/2);
Output(:,i)=V_t;
for k=1:N
if Output(k,i)>=V_to
    Output(k,i)=E_L;
    V_t(k)=Output(k,i);


end
end
end
Output(:,M)=V_t+(1/C)*(-g_L*(V_t-V_O)+Input(:,M))*del_t;
V_t=Output(:,M);
T=linspace(1,M,M);
plot(T,Output(2,:))
figure
plot(T,Output(4,:))
figure
plot(T,Output(6,:))
figure
plot(T,Output(8,:))