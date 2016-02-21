%nframe=1000;
%mov(1:nframe)= struct('cdata',[],'colormap',[]);
%set(gca,'nextplot','replacechildren')
%for k=1:500
%  plot(rastor{k});
%  mov(k:k+1)=getframe(gcf)
%end
%movie2avi(mov, '1moviename.avi', 'compression', 'None');
for i =1:500
    for j=1:10000
   if rastor{i}(1,j)==1
       s=j/10000;
   plot(s,i,'.')
   hold on 
   end
    
    
    
    
    
    end
end