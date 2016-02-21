%Assignment code for 2-C EE746 Neuromorphic Engineering
E_t=zeros(3,1);
E_r=zeros(3,1);
C=zeros(3,1);
k_z=zeros(3,1);
a=zeros(3,1);
b=zeros(3,1);
c=zeros(3,1);
d=zeros(3,1);
v_peak=zeros(3,1);
C(1)=100e-12;
k_z(1)=0.7e-6;
E_r(1)=-60e-3;
E_t(1)=-40e-3;
a(1)=0.03e3;
b(1)=-2e-9;
c(1)=-50e-3;
d(1)=100e-12;
v_peak(1)=35e-3;
C(2)=150e-12;
k_z(2)=1.2e-6;
E_r(2)=-75e-3;
E_t(2)=-45e-3;
a(2)=0.01e3;
b(2)=5e-9;
c(2)=-56e-3;
d(2)=130e-12;
v_peak(2)=50e-3;
C(3)=50e-12;
k_z(3)=1.5e-6;
E_r(3)=-60e-3;
E_t(3)=-40e-3;
a(3)=0.03e3;
b(3)=1e-9;
c(3)=-40e-3;
d(3)=150e-12;
v_peak(3)=25e-3;
prompt='Number of Neurons';
N=input(prompt);
%N=3;
Prompt='Time when this needs to be analysed,t =  ';
t=input(Prompt);
Prompt='Number of Time Steps required ,M = ';
M=input(Prompt);
Input=zeros(3,M);
%Input(1,:)=400e-12*ones(1,M);
%Input(2,:)=500e-12*ones(1,M);
%Input(3,:)=600e-12*ones(1,M);

%V_steady1=E_r;
%U_steady1=0;
%V_steady2=E_t+b/k_z;
%U_steady2=b*(V_steady2-E_r);
OutputV=zeros(N,M);
OutputU=zeros(N,M);
del_t=(t/M);
E_T=zeros(N,1);
E_R=zeros(N,1);
k_Z=zeros(N,1);
inverse_C=zeros(N,1);
A=zeros(N,1);
B=zeros(N,1);
C_reset=zeros(N,1);;
D=zeros(N,1);
V_peak=zeros(N,1);
I=zeros(N,1);
for w=1:N
prompt='input current';
current=input(prompt);
if current==1
I(w)=400e-12;
end
if current==2
I(w)=500e-12;
end
if current==3
I(w)=600e-12;
end
end
for j=1:N
prompt='input';
type=input(prompt);
if type==1
E_T(j)=E_t(1);
E_R(j)=E_r(1);
k_Z(j)=k_z(1);
inverse_C(j)=(1/C(1));
A(j)=a(1);
B(j)=b(1);
C_reset(j)=c(1);
D(j)=d(1);
V_peak(j)=v_peak(1);
end
if type==2
E_T(j)=E_t(2);
E_R(j)=E_r(2);
k_Z(j)=k_z(2);
inverse_C(j)=(1/C(2));
A(j)=a(2);
B(j)=b(2);
C_reset(j)=c(2);
D(j)=d(2);
V_peak(j)=v_peak(2);
end
if type==3
E_T(j)=E_t(3);
E_R(j)=E_r(3);
k_Z(j)=k_z(3);
inverse_C(j)=(1/C(3));
A(j)=a(3);
B(j)=b(3);
C_reset(j)=c(3);
D(j)=d(3);
V_peak(j)=v_peak(3);
end
end
V_steady1=zeros(N,1);
U_steady1=zeros(N,1);
V_steady2=zeros(N,1);
U_steady2=zeros(N,1);
V_steady=zeros(N,1);
U_steady=zeros(N,1);
%V_steady1=E_r;
%U_steady1=0;
%V_steady2=E_t+b/k_z;
%U_steady2=b*(V_steady2-E_r);
for k=1:N
V_steady1(k)=E_R(k);
U_steady1(k)=0;
V_steady2(k)=E_T(k)+B(k)/k_Z(k);
U_steady2(k)=B(k)*(V_steady2(k)-E_R(k));

if V_steady1(k)>=V_steady2(k)
V_steady(k)=V_steady1(k);
U_steady(k)=U_steady1(k);
else
V_steady(k)=V_steady2(k);
U_steady(k)=U_steady2(k);
end
end
V_t=zeros(N,1);
V_t=V_steady.*ones(N,1);
U_t=zeros(N,1);
U_t=U_steady.*ones(N,1);

for i=1:M
K1V=(k_Z.*(V_t-E_T).*(V_t-E_T)-U_t+I).*inverse_C;
K1U=A.*(B.*(V_t-E_R)-U_t);
K2V=(k_Z.*((V_t+K1V*del_t/2)-E_T).*((V_t+K1V*del_t/2)-E_R)-(U_t+K1U*del_t/2)+I).*inverse_C;
K2U=A.*(B.*((V_t+K1V*del_t/2)-E_R)-(U_t+K1U*del_t/2));
K3V=(k_Z.*((V_t+K2V*del_t/2)-E_T).*((V_t+K2V*del_t/2)-E_R)-(U_t+K2U*del_t/2)+I).*inverse_C;
K3U=A.*(B.*((V_t+K2V*del_t/2)-E_R)-(U_t+K2U*del_t/2));
K4V=(k_Z.*((V_t+K3V*del_t)-E_T).*((V_t+K3V*del_t)-E_R)-(U_t+K3U*del_t)+I).*inverse_C;
K4U=A.*(B.*((V_t+K3V*del_t)-E_R)-(U_t+K3U*del_t));
V_t=V_t+((K1V+2*K2V+2*K3V+K4V)/6)*del_t;
V_t=V_t+((K1V+2*K2V+2*K3V+K4V)/6)*del_t;
OutputV(:,i)=V_t;
OutputU(:,i)=U_t;
for j=1:N
if V_t(j)>=V_peak(j)
V_t(j)=C_reset(j);
U_t(j)=U_t(j)+D(j);
OutputV(:,i)=V_t;
OutputU(:,i)=U_t;
end

end

end
T=linspace(1,M,M);
plot(T,OutputV(1,:))
figure
plot(T,OutputV(2,:))
figure
plot(T,OutputV(3,:))