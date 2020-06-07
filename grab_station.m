close all; clear all;
sta = irisFetch.Stations('STATION','*','*','*','?HZ','boxcoordinates',[51,53,-129,-121],'starttime','2005-06-01','endtime','2006-11-1');

start_time = extractfield(sta,'StartDate');
end_time = extractfield(sta,'EndDate');
stations = extractfield(sta,'StationCode');
nets = extractfield(sta,'NetworkCode');


event_time = '2006-07-01';  % this is a stand-in variable corresponding to the actual time of the event we want to retrieve waveform data.

tra_end = datestr(datenum(event_time)+.05/24,31);

gotime = find(datenum(start_time) < datenum(event_time));
still_going = find(datenum(end_time(gotime)) > datenum(event_time));

combo = [];
for i = 1:length(still_going);
 combo = [combo,irisFetch.Traces(char(nets(gotime(still_going(i)))),char(stations(gotime(still_going(i)))),'*','?H?',event_time,tra_end)];
end

