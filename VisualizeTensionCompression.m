function gg=VisualizeTensionCompression(flist, rlist1, rlist2)
xxlim=xlim;
sc=.05*(max(xxlim)-min(xxlim));

[numbars,~]=size(flist);
for jj=1:numbars
rrn= (rlist2(jj,:)-rlist1(jj,:));
ffn=-flist(jj,:);
ffn=round(100*ffn/norm(ffn))/100; %unit vector of force
rrn=round(100*rrn/norm(rrn))/100; %unit vector of broken truss member away from point


compyes= sum((ffn==rrn))==3;
if compyes; cspec='r'; end
if compyes==0; cspec='g'; end

beamcenter=(rlist2(jj,:)+rlist1(jj,:))/2;

gg{1}=ForcePlot(.15*sc+beamcenter  -(1.2*sc*ffn)*(compyes)+sc*ffn*.1,ffn ,sc, cspec, 3, 0);
gg{2}=ForcePlot(.15*sc+beamcenter  +(1.2*sc*ffn)*(compyes)-sc*ffn*.1,-ffn ,sc, cspec, 3, 0);



end
