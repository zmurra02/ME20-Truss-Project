function ghandles=ForcePlot(rA, fA,sc, cspec,  LW, golabel)
if nargin<6; golabel=1; end
if nargin<5; LW=1; end
if nargin<4; cspec='c'; end
xxlim=xlim;
sc2=.05*(xxlim(2)-xxlim(1));




LL=norm(fA)*sc;
qA=mod(atan2(fA(2),fA(1)), 2*pi);
%quiver3(rA(1),rA(2), rA(3), sc*fA(1), sc*fA(2), sc*fA(3) , 'color', cspec, 'LineWidth',LW);

if length(rA)==2
    arrow(rA(1),rA(2),sc2/3,LL, qA*180/pi, cspec, LW);
    arcplot(rA, [0 qA], sc2, 'k--');
    
end

[Xcc,Ycc,Zcc]=cylinder([0 1],10);

if length(rA)==3
    %arrow(rA(1),rA(2),sc2/3,LL, qA*180/pi, cspec, LW);
    %arcplot(rA, [0 qA], sc2, 'k--')
    xdata= [rA(1), rA(1)+fA(1)*sc];
    ydata= [rA(2), rA(2)+fA(2)*sc];
    zdata= [rA(3), rA(3)+fA(3)*sc];
    fA_mag=norm(fA);
    sc2=fA_mag*(1/8)*sc;
    pp=plot3(xdata, ydata, zdata, 'color', cspec, 'linewidth', LW );
    gg=surf(Xcc*sc2+rA(1), Ycc*sc2+rA(2), Zcc*sc2*2+rA(3), 'edgecolor', 'none', 'FaceColor', cspec);


    LL=norm(fA);
    THETA=mod(atan2(fA(2),fA(1)), 2*pi)*180/pi+90;
    PHI=acos(fA(3)/ LL)*180/pi+180;

    rotate(gg,[1 0 0],PHI, rA);
    rotate(gg,[0 0 1],THETA, rA);

    xx=get(gg, 'XData');
    yy=get(gg, 'YData');
    zz=get(gg, 'ZData');

    set(gg, 'XData', xx+fA(1)*sc);
    set(gg, 'YData', yy+fA(2)*sc);
    set(gg, 'ZData', zz+fA(3)*sc);

    %%Text label
    mytext=num2str(round(1000*norm(fA))/1000);


    if (THETA-90)==180; THETA=90; end
    hh=[];
    jj=[];
    if golabel
        hh=text(rA(1)+fA(1)*sc,rA(2)+fA(2)*sc, rA(3)+fA(3)*sc, mytext, 'color', cspec, 'rotation', THETA-90, 'FontSize', 20);
        qq=mod(atan2(fA(2),fA(1)), 2*pi);
       jj=arcplot(rA, [0 qq], sc2*2, cspec);
    end


end

ghandles=[gg; pp; hh; jj];
