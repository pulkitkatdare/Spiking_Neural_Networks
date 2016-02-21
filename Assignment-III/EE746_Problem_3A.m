fanout=cell(1,200);
rastor=cell(1,200);
fanin=cell(1,200);
weights=zeros(1,200);
axonal=zeros(1,200);
layer_1_input=cell(1,200);
layer_1_current=cell(1,200);
layer_input=cell(1,200);
layer_output=cell(1,200);
weights_matrix=cell(1,200);
V_Response=cell(1,200);
%neuronal
lambda=100;
sum=0;
I_O=1e-12;
w_e=3000;
C=300e-12; %capacitance for the leaky integrate and fire
g_L=30e-9;  %Just a Constant Resistance Factor
V_T=20e-3; %Action Potential in the model
E_L=-70e-3;%Reset Potenntial
R_p=2e-3;  %Delay Time 
I_O=1e-12; %base Current
T_W=15; %Time constant 1 
T_S=T_W/4;  %time Constant 2
I_A=50e-9;  %Input Amplitude
del_t=0.1e-3;
for i=1:200
    fanout{i}=randi([1 200],[1 20]);
    axonal(i)=randi([1 20]);
    weights(i)=3000;
    layer_1_current{i}=zeros(1,10000);
    layer_1_input{i}=zeros(1,10000);
    y=zeros(1,10000);
    sum=0;
    if i > 160
    fanout{i}=randi([1 160],[1 20]);
    weights(i)=-3000;
    axonal(i)=1;
    end
while sum<10000
    if i > 25
    break
    end
    
 sum=sum+poissrnd(lambda);
 sum=floor(sum);
    
if sum > 10000
   break
end
layer_1_input{i}(1,sum)=1;
for j=sum:10000

layer_1_current{i}(1,j)=layer_1_current{i}(1,j)+I_O*w_e*(exp(-(j-sum)/150)-exp(-(j-sum)/37.5));

end
end

end
for i =1 : 200
    R=[];
    W=[];
    for j=1:200
    for k=1:20
    if fanout{j}(1,k)==i
    W=[W weights(j)];
    R=[R , j];
    end
    end
    end
fanin{i}=R;
weights_matrix{i}=W;
end
%for h =1:5
for i =1 : 200
    rastor{i}=zeros(1,10000);
layer_output{i}=zeros(1,10000);
layer_input{i}=zeros(1,10000);

for k =1:size(fanin{i})
if fanin{i}(1,k)<i
layer_1_current{i}=layer_1_current{i}+layer_input{fanin{i}(1,k)};
end
j1=1;
V_t=E_L;
V_O=V_t;
while (j1<10000)
V_tprevious=V_t;
D_EPrevious=(1/C).*(-g_L*(V_t-V_O)+layer_1_current{i}(1,j1));
V_t=V_t+(1/C)*(-g_L*(V_t-V_O)+layer_1_current{i}(1,j1))*del_t;
%Input=[I_app{1}(1,j+1),I_app{2}(1,j+1),I_app{3}(1,j+1),I_app{4}(1,j+1),I_app{5}(1,j+1)];
D_ENew=(1/C)*((-g_L)*(V_t-V_O)+layer_1_current{i}(1,j1+1));
V_t=V_tprevious+((D_EPrevious+D_ENew)*del_t/2);
if V_t>=V_T
    for i1=j1:10000
    layer_input{i}(1,i1)=I_O*weights(i)*(exp(-(i1-j1-axonal(i))/150)-exp(-(i1-j1-axonal(i))/37.50))*heaviside(i1-j1-axonal(i))+layer_input{i}(1,i1);
    end
    rastor{i}(1,j1)=1;
j1=j1+20;
layer_output{i}(1,j1:j1+19)=V_t*ones(1,20);
V_t=E_L;
else
layer_output{i}(1,j1)=V_t;
j1=j1+1;
end
end
end
end
%end
for i =1:200
    for j=1:10000
   if rastor{i}(1,j)==1
       s=j/10000;
   plot(s,i,'.')
   hold on 
   end
    
    
    
    
    
    end
end
figure 
for i =1:200
    for j=1:10000
   if rastor{i}(1,j)==1
       s=j/10000;
   plot(s,i,'.')
   hold on 
   end
    
    
    
    
    
    end
end
figure 
for i =161:200
    for j=1:10000
   if rastor{i}(1,j)==1
       s=j/10000;
   plot(s,i,'.')
   hold on 
   end
    
    
    
    
    
    end
end