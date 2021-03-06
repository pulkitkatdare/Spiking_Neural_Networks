%code for checking out the varition of code with variations in I_ext
M=50000;
C=1e-6;
E_Na=50e-3;
E_K=-77e-3;
E_l=-55e-3;
g_Na=120e-3;%cm square look into it 
g_K=36e-3;%cm square look into it 
g_l=0.3e-3;%cm square look into it 
V_t=75;
Output=zeros(1,50000);
n_Output=zeros(1,50000);
h_Output=zeros(1,50000);
m_Output=zeros(1,50000);
I_o=1e-6;%cm square look into it 
del_t=0.00001e-3;
I_ext=zeros(1,50000);
I_ext(1:10000)=zeros(1,10000);
I_ext(40001:50000)=zeros(1,10000);
I_ext(10001:40000)=I_o*ones(1,30000);
h=1;
m=0;
n=0;
for i=1:M
del_V=(-g_Na*(m^3)*h*(V_t*10^-3-E_Na)-g_K*n^4*(V_t*10^-3-E_K)-g_l*(V_t*10^-3-E_l)+I_ext(i))*(1/C);
del_n=(0.01*((V_t*10^3)+55)/(1-exp(-((V_t*10^3)+55)/10)))*(1-n)-(0.125*exp(-((V_t*10^3)+65)/80))*n;
del_m=(0.1*((V_t*10^3)+40)/(1-exp(-((V_t*10^3)+40)/10)))*(1-m)-(4*exp(-0.0556*(((V_t*10^3)+65))))*m;
del_h=(0.07*exp(-0.05*((V_t*10^3)+65)))*(1-h)-(1/(1+exp(-0.1*((V_t*10^3)+35))))*h;
V_t=V_t+del_V*del_t;
n=n+del_n*del_t;
m=m+del_m*del_t;
h=h+del_h*del_t;
Output(i)=V_t;
n_Output(i)=n;
m_Output(i)=m;
h_Output(i)=h;
end
T=linspace(1,50000,50000);
plot(T,Output,'o');

