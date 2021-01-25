
clear all
close all
A = readtable('query_2005OctNNov.txt');
sta = irisFetch.Stations('STATION','*','*','*','?HZ','boxcoordinates',[51,53,-129,-121],'starttime','2005-06-01','endtime','2006-11-1');
start_time = extractfield(sta,'StartDate');
end_time = extractfield(sta,'EndDate');
stations = extractfield(sta,'StationCode');
nets = extractfield(sta,'NetworkCode');

for i = 1:length(A.Time);
   
event_time = A.Time(i); 
st = datestr(datenum(char(A.Time(i)),'yyyy-mm-ddTHH:MM:SS'),31);


tra_end = datestr(datenum(event_time,'yyyy-mm-ddTHH:MM:SS')+.05/24,31);

gotime = find(datenum(start_time) < datenum(event_time,'yyyy-mm-ddTHH:MM:SS'));
still_going = find(datenum(end_time(gotime)) > datenum(event_time,'yyyy-mm-ddTHH:MM:SS'));


combo = [];
for j = 1:length(still_going);
    
 combo = [combo,irisFetch.Traces(char(nets(gotime(still_going(j)))),char(stations(gotime(still_going(j)))),'*','?H?',st,tra_end)];

if datenum(datestr(datenum(char(A.Time(i)),'yyyy-mm-ddTHH:MM:SS'),31)) > min(datenum(start_time))
xxx = char(A.Time(i))
yy = xxx(1:4)
mm = xxx(6:7)
dd = xxx(9:10)
HH = xxx(12:13)
MM = xxx(15:16)
SS = xxx(18:19)

date = [yy mm dd HH MM SS ]
save(strcat('Event_',date),'combo')
end
end

end

