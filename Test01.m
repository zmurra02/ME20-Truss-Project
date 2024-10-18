clear
close all

%Equilibrium for whole structure

rA=[0.625 1.25 0];
rB=[1.25 1.25 0];
rC=[1.875 1.25 0];
rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rF=[1.5625 0.625 0];
rG=[2.1875 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];
rJ=[1.875 0 0];
rK=[2.5 0 0];

Ay=-(0.1)*(9.81);
By=-(0.2)*(9.81);
syms Hx Hy Ky

fA=[0 Ay 0];
fB=[0 By 0];
fC=[0 0 0];
fD=[0 0 0];
fE=[0 0 0];
fF=[0 0 0];
fG=[0 0 0];
fH=[Hx Hy 0];
fI=[0 0 0];
fJ=[0 0 0];
fK=[0 Ky 0];

ffs=[fA;fB;fC;fG;fK;fJ;fF;fC*0;fJ*0;fG*0;fJ*0;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0;fB*0;fF*0];
rrs=[rA;rB;rC;rG;rK;rJ;rF;rC;rJ;rG;rJ;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE;rB;rF];
figure(1);
hold on;
[mH, fH, VarSoln, VarList, ffnew_ii]=GenRigidBodyEquilibrium(ffs, rrs)
title('Whole Structure Reactions')


%Method of Sections for K
figure(2)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];
rB=[1.25 1.25 0];
rC=[1.875 1.25 0];
rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rF=[1.5625 0.625 0];
rG=[2.1875 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];
rJ=[1.875 0 0];

syms fJK fGK
qK=120*pi/180;
fGKx=fGK*cos(qK);
fGKy=fGK*sin(qK);
fA=[0 Ay 0];
fB=[0 By 0];
fC=[0 0 0];
fD=[0 0 0];
fE=[0 0 0];
fF=[0 0 0];
fG=[fGKx fGKy 0];
fH=[Hx Hy 0];
fI=[0 0 0];
fJ=[fJK 0 0];

ffs=[fA;fB;fC;fG;fJ;fF;fC*0;fJ*0;fG*0;fJ*0;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0;fB*0;fF*0];
rrs=[rA;rB;rC;rG;rJ;rF;rC;rJ;rG;rJ;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE;rB;rF];

[mH2, fH2, VarSoln2, VarList2, ffnew_ii2]=GenRigidBodyEquilibrium(ffs, rrs)

GK=ffnew_ii2(4,:);
JK=ffnew_ii(5,:);

flist=[GK;JK];
rlist1=[rG;rJ];
rlist2=[rK;rK];

VisualizeTensionCompression(flist, rlist1, rlist2)
title('Method of Sections K')

%Method of Sections for G
figure(3)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];
rB=[1.25 1.25 0];
rC=[1.875 1.25 0];
rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rF=[1.5625 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];
rJ=[1.875 0 0];

syms fCG fJG
fCGx=fCG*cos(2*pi/3);
fCGy=fCG*sin(2*pi/3);
fJGx=fJG*cos(pi/3);
fJGy=fJG*sin(pi/3);
fA=[0 Ay 0];
fB=[0 By 0];
fC=[fCGx fCGy 0];
fD=[0 0 0];
fE=[0 0 0];
fF=[0 0 0];
fH=[Hx Hy 0];
fI=[0 0 0];
fJ=[fJGx fJGy 0];
fJ2=[0.708 0 0];

ffs=[fA;fB;fC;fJ;fJ2;fF;fC*0;fJ*0;fJ*0;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0;fB*0;fF*0];
rrs=[rA;rB;rC;rJ;rJ;rF;rC;rJ;rJ;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE;rB;rF];

[mH3, fH3, VarSoln3, VarList3, ffnew_ii3]=GenRigidBodyEquilibrium(ffs, rrs)

CG=ffnew_ii2(3,:);
JG=ffnew_ii(4,:);

flist2=[CG;JG];
rlist3=[rC;rJ];
rlist4=[rG;rG];

VisualizeTensionCompression(flist2, rlist3, rlist4)
title('Method of Sections G')

%Method of Sections for C
figure(4)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];
rB=[1.25 1.25 0];

rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rF=[1.5625 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];
rJ=[1.875 0 0];

syms fCJ fBC fFC
fFC=0;
fFCx=fFC*cos(pi/3);
fFCy=fFC*sin(pi/3);

fA=[0 Ay 0];
fB=[fBC 0 0];
fB2=[0 By 0];
fD=[0 0 0];
fE=[0 0 0];
fF=[fFCx fFCy 0];
fH=[Hx Hy 0];
fI=[0 0 0];
fJ=[0 fCJ 0];
fJ2=[0.708 0 0];

ffs=[fA;fB;fB2;fJ;fF;fJ2;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0;fB*0;fF*0];
rrs=[rA;rB;rB;rJ;rF;rJ;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE;rB;rF];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

CJ=ffnew_ii2(4,:);
BC=ffnew_ii(2,:);
FC=ffnew_ii(5,:);

flist3=[CJ;BC;FC];
rlist5=[rJ;rB;rF];
rlist6=[rC;rC;rC];

VisualizeTensionCompression(flist3, rlist5, rlist6)
title('Method of Sections C')

%Method of Sections for J
figure(5)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];
rB=[1.25 1.25 0];

rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];

syms fBJ fIJ
fBJx=fBJ*cos(2*pi/3);
fBJy=fBJ*sin(2*pi/3);

fA=[0 Ay 0];
fB=[-0.708 0 0];
fB3=[0 By 0];
fB2=[fBJx fBJy 0];
fD=[0 0 0];
fE=[0 0 0];
fH=[Hx Hy 0];
fI=[fIJ 0 0];

ffs=[fA;fB;fB2;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0;fB*0; fB3];
rrs=[rA;rB;rB;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE;rB;rB];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

BJ=ffnew_ii2(3,:);
IJ=ffnew_ii(4,:);

flist4=[BJ;IJ];
rlist7=[rB;rI];
rlist8=[rJ;rJ];

VisualizeTensionCompression(flist4, rlist7, rlist8)
title('Method of Sections J')

%Method of Sections for B
figure(6)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];

rD=[0.3125 0.625 0];
rE=[0.9375 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];

syms fAB fBE

fBEx=fBE*cos(pi/3);
fBEy=fBE*sin(pi/3);

fA=[0 Ay 0];
fA2=[fAB 0 0];

fD=[0 0 0];
fE=[fBEx fBEy 0];
fH=[Hx Hy 0];
fI=[1.416 0 0];

ffs=[fA;fA2;fI;fH;fD;fI*0;fD*0;fA*0;fI*0;fE;fA*0;fE*0];
rrs=[rA;rA;rI;rH;rD;rI;rD;rA;rI;rE;rA;rE];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

AB=ffnew_ii2(2,:);
BE=ffnew_ii(10,:);

flist5=[AB;BE];
rlist9=[rA;rE];
rlist10=[rB;rB];

VisualizeTensionCompression(flist5, rlist9, rlist10)
title('Method of Sections B')

%Method of Sections for E
figure(7)
hold on

Hx=0;
Hy=1.717;

rA=[0.625 1.25 0];

rD=[0.3125 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];

syms fAE fEI

fAEx=fAE*cos(2*pi/3);
fAEy=fAE*sin(2*pi/3);

fEIx=fEI*cos(pi/3);
fEIy=fEI*sin(pi/3);

fA=[0 Ay 0];
fA2=[-0.991 0 0];
fA3=[fAEx fAEy 0];

fD=[0 0 0];

fH=[Hx Hy 0];
fI=[1.416 0 0];
fI2=[fEIx fEIy 0];

ffs=[fA;fA2;fA3;fI;fI2;fH;fD;fI*0;fD*0;fA*0;fI*0;fA*0];
rrs=[rA;rA;rA;rI;rI;rH;rD;rI;rD;rA;rI;rA];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

AE=ffnew_ii2(3,:);
EI=ffnew_ii(5,:);

flist6=[AE;EI];
rlist11=[rA;rI];
rlist12=[rE;rE];

VisualizeTensionCompression(flist6, rlist11, rlist12)
title('Method of Sections E')

%Method of Sections for A
figure(8)
hold on

Hx=0;
Hy=1.717;

rD=[0.3125 0.625 0];
rH=[0 0 0];
rI=[0.625 0 0];

syms fAD fAI

fADx=fAD*cos(pi/3);
fADy=fAD*sin(pi/3);

fD=[fADx fADy 0];

fH=[Hx Hy 0];
fI=[1.416 0 0];
fI2=[-0.425 -0.7361 0];
fI3=[0 fAI 0];

ffs=[fI;fI2;fI3;fH;fD;fI*0;fD*0;fI*0];
rrs=[rI;rI;rI;rH;rD;rI;rD;rI];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

AD=ffnew_ii2(5,:);
AI=ffnew_ii(3,:);

flist7=[AD;AI];
rlist13=[rD;rI];
rlist14=[rA;rA];

VisualizeTensionCompression(flist7, rlist13, rlist14)
title('Method of Sections A')

%Method of Sections for I
figure(9)
hold on

Hx=0;
Hy=1.717;

rD=[0.3125 0.625 0];
rH=[0 0 0];


syms fDI fHI

fDIx=fDI*cos(2*pi/3);
fDIy=fDI*sin(2*pi/3);

fD=[-0.991 -1.7165 0];
fD2=[fDIx fDIy 0];

fH=[Hx Hy 0];
fH2=[fHI 0 0];


ffs=[fH;fH2;fD;fD2];
rrs=[rH;rH;rD;rD];

[mH4, fH4, VarSoln4, VarList4, ffnew_ii4]=GenRigidBodyEquilibrium(ffs, rrs)

DI=ffnew_ii2(4,:);
HI=ffnew_ii(2,:);

flist8=[DI;HI];
rlist15=[rD;rH];
rlist16=[rI;rI];

VisualizeTensionCompression(flist8, rlist15, rlist16)
title('Method of Sections I')