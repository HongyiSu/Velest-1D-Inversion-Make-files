 meager_tr = irisFetch.Traces('CN','LLLB','00','BHZ','2005-06-01 23:00:00',...
        '2006-11-30 23:59:55','includePZ');
  tr = meager_tr;
  %data = (tr.data - mean(tr.data)) ./ tr.sensitivity;
  sampletimes = linspace(tr.startTime,tr.endTime,tr.sampleCount);
  plot(sampletimes, data,'LineWidth',1);
  xt = get(gca,'XTick'); xtl = get(gca,'XTickLabel');
  xt = xt(1:2:end); xtl = xtl(1:2:end,:);
  set(gca,'XTick',xt,'XTickLabel',xtl);
  datetick
  set(gca,'YTick',[],'YTickLabel','','TickDir','out',...
 'TickLength',[.005 .015],'FontSize',12);
  ylabel([tr.network '.' tr.station])
  title( '2018-08-19 00:19:40.67','FontSize',14)
  