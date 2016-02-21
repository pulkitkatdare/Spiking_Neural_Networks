%code for Problem 3C in assignment-I for EE746 
t=500e-3;
M=5000;
del_t=0.1e-3;
C=zeros(3,1);
C(1)=200e-12;
C(2)=130e-12;
C(3)=200e-12;
g_L=zeros(3,1);
g_L(1)=10e-9;
g_L(2)=18e-9;
g_L(3)=10e-9;
E_l=zeros(3,1);
E_l(1)=-70e-3;
E_l(2)=-58e-3;
E_l(3)=-58e-3;
V_T=zeros(3,1);
V_T(1)=-50e-3;
V_T(2)=-50e-3;
V_T(3)=-50e-3;
del_T=zeros(3,1);
del_T(1)=2e-3;
del_T(2)=2e-3;
del_T(3)=2e-3;
a=zeros(3,1);
a(1)=2e-9;
a(2)=4e-9;
a(3)=2e-9;
t_w=zeros(3,1);
t_w(1)=30e-3;
t_w(2)=150e-3;
t_w(3)=120e-3;
b=zeros(3,1);
b(1)=0;
b(2)=120e-12;
b(3)=100e-12;
V_r=zeros(3,1);
V_r(1)=-58e-3;
V_r(2)=-50e-3;
V_r(3)=-46e-3;
V_steady=zeros(3,1);
V_steady_previous=zeros(3,1);
U_steady=zeros(3,1);
for i=1:3
V_steady(i)=V_steady(i)-((g_L(i)*del_T(i)*exp((V_steady(i)-V_T(i))/del_T(i))-(g_L(i)+a(i))*(V_steady(i)-E_l(i)))/(g_L(i)*exp((V_steady(i)-V_T(i))/del_T(i))-(g_L(i)+a(i))));
    
while abs(V_steady(i)-V_steady_previous(i))>10e-6  
V_steady_previous(i)=V_steady(i);
V_steady(i)=V_steady(i)-((g_L(i)*del_T(i)*exp((V_steady(i)-V_T(i))/del_T(i))-(g_L(i)+a(i))*(V_steady(i)-E_l(i)))/(g_L(i)*exp((V_steady(i)-V_T(i))/del_T(i))-(g_L(i)+a(i))));
end
U_steady(i)=a(i)*(V_steady(i)-E_l(i));
end
prompt='number of neurons';
N=input(prompt);
%N=3;
C_inverse=zeros(N,1);
G_L=zeros(N,1);
E_L=zeros(N,1);
E_T=zeros(N,1);
delta_T=zeros(N,1);
inverse_delta_T=zeros(N,1);
A=zeros(N,1);
T_W=zeros(N,1);
B=zeros(N,1);
V_R=zeros(N,1);
V_t=zeros(N,1);
U_t=zeros(N,1);
I=zeros(N,1);
Output_V=zeros(N,M);
Output_U=zeros(N,M);
I_applied=zeros(3,1);
I_applied(1)=250e-12;
I_applied(2)=350e-12;
I_applied(3)=450e-12;
for j=1:N
prompt='input=';
type=input(prompt);
if type==1
C_inverse(j)=1/C(1);
G_L(j)=g_L(1);
E_L(j)=E_l(1);
E_T(j)=V_T(1);
delta_T(j)=del_T(1);
A(j)=a(1);
T_W(j)=1/t_w(1);
B(j)=b(1);
V_R(j)=V_r(1);
V_t(j)=V_steady(1);
U_t(j)=U_steady(1);
inverse_delta_T(j)=1/del_T(1);
end
if type==2
C_inverse(j)=1/C(2);
G_L(j)=g_L(2);
E_L(j)=E_l(2);
E_T(j)=V_T(2);
delta_T(j)=del_T(2);
inverse_delta_T(j)=1/del_T(2);
A(j)=a(2);
T_W(j)=1/t_w(2);
B(j)=b(2);
V_R(j)=V_r(2);
V_t(j)=V_steady(2);
U_t(j)=U_steady(2);
end
if type==3
C_inverse(j)=1/C(3);
G_L(j)=g_L(3);
E_L(j)=E_l(3);
E_T(j)=V_T(3);
delta_T(j)=del_T(3);
A(j)=a(3);
T_W(j)=1/t_w(3);
B(j)=b(3);
inverse_delta_T(j)=1/del_T(3);
V_R(j)=V_r(3);
V_t(j)=V_steady(3);
U_t(j)=U_steady(3);
end
end
for w=1:N
prompt='input current =';
I_type=input(prompt);
if I_type==1
I(w)=I_applied(1);
end
if I_type==2
I(w)=I_applied(2);
end
if I_type==3
I(w)=I_applied(3);
end
end
for i=1:M
del_V=(-G_L.*(V_t-E_L)+G_L.*delta_T.*exp((V_t-E_T).*inverse_delta_T)-U_t+I).*C_inverse;
del_U=(a.*(V_t-E_L)-U_t).*(T_W);
V_t=V_t+del_V.*del_t;
U_t=U_t+del_U.*del_t;
for m=1:N
if V_t(m)>=0
    V_t(m)=V_R(m);
    U_t(m)=U_t(m)+B(m);
end
Output_V(:,i)=V_t;
Output_U(:,i)=U_t;
end
end
T=linspace(1,M,M);
plot(T,Output_V(1,:))
figure
plot(T,Output_V(2,:))
figure
plot(T,Output_V(3,:))