function gg=arcplot(position, qqs, rad, cspec)
qq=linspace(qqs(1), qqs(2), 30);


xx=rad*cos(qq)+position(1);
yy=rad*sin(qq)+position(2);


ghandle=plot(xx,yy,'color', cspec);
mystr=strcat(num2str(.1*round  ( 10* (qqs(2)-qqs(1) )*180/pi)), '\circ');
khandle=text(xx(end), yy(end), mystr, 'rotation', qqs(2)*180/pi, 'FontSize',16, 'color', [1 1 1]*.7, 'VerticalAlignment','bottom');

gg=[ghandle;khandle ];
