function [mB, fB, VarSoln, VarList, ffnew_ii]=GenRigidBodyEquilibrium(ffs, rrs)

%rrrs=[0 0 0; rrs];

%Visualize the points of load application
%figure(1)
hold on
grid on
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
view(2)
axis equal

plot3(rrs(:,1),rrs(:,2), rrs(:,3), 'color', [1 1 1]*.8, 'LineWidth',5)
plot3([0 1], [0 0], [0 0], 'r-')
plot3([0 0], [0 1], [0 0], 'g-')
plot3([0 0], [0 0], [0 1], 'b-')

fB=sum(ffs);
[numforces, ~]=size(ffs);


for ii=1:numforces
    mBs(ii,:)=cross(rrs(ii,:), ffs(ii,:));
    mAs(ii,:)=cross(rrs(ii,:)-rrs(end,:), ffs(ii,:));
end
mB=sum(mBs);
mA=sum(mAs);




[numforces, ~]=size(ffs);


view(2)


VarList=symvar(ffs);


%Build the matrix of coefficients for unknowns from the force relationships
iii=0;
for ii=1:3
    if fB(ii)~=0
        iii=iii+1;
        [cc,tt]=coeffs(fB(ii),VarList);


        if tt(end)==1; ddxy(iii)=-cc(end); end

        for jj=1:length(VarList)
            [cxy,txy]=coeffs(fB(ii),VarList(jj));

            if txy(1)==VarList(jj)
                
                ccxy(iii,jj)=cxy(1);
                
            else
                ccxy(iii,jj)=0;
            end
        end
    end
end

%Build the matrix of coefficients for unknowns from the moment relationships
if length(VarList)>2
Mms=1;
if Mms==1; mZ=mB; end
if Mms==2; mZ=mA; end

for ii=1:3
    if mZ(ii)~=0
        iii=iii+1;
        [cc,tt]=coeffs(mZ(ii),VarList);
        if tt(end)==1; ddxy(iii)=-cc(end); end

        for jj=1:length(VarList)
            [cxy,txy]=coeffs(mZ(ii),VarList(jj));

            if txy(1)==VarList(jj)
                ccxy(iii,jj)=cxy(1);
            else
                ccxy(iii,jj)=0;
            end
        end
    end
end


end

%If matrix is square we can invert it and solve for all unknowns

VarSoln=vpa([inv(ccxy)*ddxy']');    
VarSoln=vpa(round(1000*VarSoln)/1000);



xxlim=xlim;
ff_scale=max(abs(double(subs(ffs(:), VarList, VarSoln))));

scale=.2*abs(xxlim(2)-xxlim(1))/ff_scale;

for ii=1:numforces
    %ffs_ii=  double(ffs(ii,:)~=0);

    
    ffnew_ii(ii,:)=double(subs(ffs(ii,:), VarList, VarSoln));

    

    
    if norm(ffnew_ii(ii,:))~=0
        mycol='k';

        try double(ffs(ii,:)); catch ME; mycol='c'; end

        



    ForcePlot(rrs(ii,:), ffnew_ii(ii,:),scale, mycol, 3);

    end
    %ForcePlot(rrs(ii,:), [ffnew_ii(1) 0 0],scale, 'c', 1);
    %ForcePlot(rrs(ii,:), [0 ffnew_ii(2) 0],scale, 'c', 1);
    %ForcePlot(rrs(ii,:), [0 0 ffnew_ii(3) 0],scale, 'c', 1);

 
    %mytext=num2str(norm(ffnew_ii));

    % Fvalue=ffnew_ii*scale;
    % xx=rrs(ii,1)+ffnew_ii(1)*scale;
    % yy=rrs(ii,2)+ffnew_ii(2)*scale;
    % zz=rrs(ii,3)+ffnew_ii(3)*scale;
    % qq=atan2(ffnew_ii(2), ffnew_ii(1))*180/pi;
    % text(xx,yy, zz, mytext, 'color', 'b', 'rotation', qq)

end
