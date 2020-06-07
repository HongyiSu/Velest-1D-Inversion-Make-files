close all;
%sta = irisFetch.Stations('STATION','*','*','*','?HZ','boxcoordinates',[51,53,-129,-121],'starttime','2005-06-01','endtime','2006-11-1');

%start_time = extractfield(sta,'StartDate');
%end_time = extractfield(sta,'EndDate');
%stations = extractfield(sta,'StationCode');
%nets = extractfield(sta,'NetworkCode');


%event_time = '2006-04-11 14:47:48';  % this is a stand-in variable corresponding to the actual time of the event we want to retrieve waveform data.

%tra_end = datestr(datenum(event_time)+.05/24,31);

%gotime = find(datenum(start_time) < datenum(event_time));
%still_going = find(datenum(end_time(gotime)) > datenum(event_time));

%combo = [];
%for i = 1:length(still_going);
% combo = [combo,irisFetch.Traces(char(nets(gotime(still_going(i)))),char(stations(gotime(still_going(i)))),'*','?H?',event_time,tra_end)];
%end

chans = extractfield(combo,'channel');
stas  = unique(extractfield(combo,'station'));
nsta = length(stas);

z_ii = strmatch('BHZ',chans);
n_ii = strmatch('BHN',chans);
e_ii = strmatch('BHE',chans);

num_verts = length(z_ii);

xxx = datestr(combo(1).startTime,31)
yy = xxx(1:4); mm = xxx(6:7); dd = xxx(9:10);
HH = xxx(12:13); MM = xxx(15:16); SS = xxx(18:19);

for i = 1:num_verts;
 subplot(3,ceil(num_verts/3),i)
 plot(combo(z_ii(i)).data)
 title(combo(z_ii(i)).station)
end

traces = zeros(10000,num_verts*3)*nan;

for i = 1:num_verts;
traces(1:length(combo(z_ii(i)-2).data),((i-1)*3)+1) = combo(z_ii(i)-2).data;
traces(1:length(combo(z_ii(i)-1).data),((i-1)*3)+2) = combo(z_ii(i)-1).data;
traces(1:length(combo(z_ii(i)).data),((i-1)*3)+3) = combo(z_ii(i)).data;
end

xxx = traces(1:7000,:);

window = tukeywin(length(xxx),0.05); % make taper to force edges of data to zero

for i = 1:size(traces,2)
 detraces(:,i) = detrend(xxx(:,i));
 win_tras(:,i) = detraces(:,i).*window;
end

dt = 1/combo(3).sampleRate;
[pickmatrix] = seis_pick(win_tras,dt,3)



