clear
close all
%Make a list of the positions for the points of force application
%First choose an origin
rA=[0 0 0];
rB=[5 0 0];
rC=[10 0 0];
rD=[0 5 0];
rE=[5 5 0];

%Make vectors for correspondin forces
syms Ax Ay Cy
Ey=-200*1e-3*9.81;
fA=[Ax Ay 0];
fB=[0 0 0];
fC=[0 Cy 0];
fD=[0 0 0];
fE=[0 Ey 0];

rrs=[rA; rB; rC; rE; rD; rA; rE; rB];
ffs=[fA; fB; fC;  fE; fD; 0*fA; 0*fE; 0*fB];

[mA,fA, VarSoln]=GenRigidBodyEquilibrium(ffs, rrs);
title('Whole Structure Reactions')



%Method of joints

%Isolate point C
%Specify placeholders for forces within each member

figure(2)
hold on
fC=[0 0.981 0];
syms fCBmag fCEmag
qCE=-45*pi/180;
fCEx=fCEmag*cos(qCE);
fCEy=fCEmag*sin(qCE);

qCB=pi;
fCBx=fCBmag*cos(qCB);
fCBy=fCBmag*sin(qCB);

fCB=[fCBx fCBy 0];
fCE=[fCEx fCEy 0];
rrs=[rC; rC; rC]*0;
ffs=[fC; fCB; fCE];
xlim([-1 1]*7)
ylim([-1 1]*7)

%[mA,fA, VarSoln]=GenRigidBodyEquilibrium(ffs, rrs)
[m_section,f_section, VarSoln_section, varlist, ffs_new]=GenRigidBodyEquilibrium(ffs, rrs);

%For two forces just name two locations at the origin
rlist1=[rC; rC  ]-rC;
%Next locate the the corresponding connection points for the truss members.
%subtract the point of interest
rlist2=[rA; rE  ]-rC;
flist=ffs_new(2:3,:);
axis equal

VisualizeTensionCompression(flist, rlist1, rlist2);
title('Method of Joints')


%Method of sections
%remove point C
figure(3)
hold on
syms BC EC Ay
rA=[0 0 0];
rB=[5 0 0];
rD=[0 5 0];
rE=[5 5 0];

Ax=0; 
Ay=0.981; %Fill in number we just found for Ax and Ay

fA=[Ax Ay 0];
%include new forces at point B corresponding to broken member BC
fB=[BC 0 0];
fD=[0 0 0];
fE=[0,  -200*1e-3*9.81, 0];


%include new forces at point E corresponding to broken member EC
%Note, we include a whole new definition of this force acting on E
%Do not add this force the previous force fE since we want to see how it
%acts separately from the applied load.

qE=(360-45)*pi/180;  %Angle of member pointing away from location of force application.  
ECx=EC*cos(qE);  %Regular projection in x direction
ECy=EC*sin(qE);   %Regular projection in x direction
fE2=[ECx,  ECy, 0];

%Make a list of the joint locations and corresponding forces.
%Note, I added rA again but with zero force just to visualize the whole
%truss.  This actually doesnt affect the answer.
rrs=[rA; rB; rE; rD; rA; rE ];
ffs=[fA; fB; fE; fD ; fA*0; fE2   ];

[m_section3,f_section3, VarSoln_section3, varlist3, ffs_new3]=GenRigidBodyEquilibrium(ffs, rrs);


%Select the forces in the new list  ffs_new corresponding to solved member forces
%Here we are picking out rows 2 through 3
fBC=ffs_new3(2,:);
fEC=ffs_new3(6,:);

flist=[fBC; fEC];
%Name the home locations of the cut members
rlist1=[rB; rE];

%Name the away locations of the cut members
rlist2=[rC; rC];

%Use the function to report compression and tension
%This works by comparing the direction of the force wrt the direction of
%the away point.  
VisualizeTensionCompression(flist, rlist1, rlist2);
title('Method of Sections')
