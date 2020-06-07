close all; clear all

fid = fopen('file_list'); 
S = fscanf(fid,'%s');
end_txt = strfind(S,'mat'); n_events = length(end_txt);
txt_counter = 1;

for i_events = 1:n_events
   text_stop = end_txt(i_events)+2;
   f_len = txt_counter:text_stop;
    txt_counter = text_stop+1

    dd = S(f_len);
    load(dd);
    
    dir_end = strfind(dd,'/');
    
Ev_time = datestr(combo(1).startTime,'yyyy-mm-ddTHH:MM:SS')
a = struct2cell(combo)
sta_nums = strmatch('BHZ',a(4,:,:))
xxx = ['grep ' Ev_time ' ' dd(1:dir_end) '/*txt']

[status output]= system(xxx)
inds = strfind(output,',');
orig_lat = str2num(output(inds(2)+1:inds(3)-1));
orig_lon = str2num(output(inds(3)+1:inds(4)-1));
orig_depth = str2num(output(inds(4)+1:inds(5)-1));

for i = 1:length(sta_nums)
[dist(i) az(i)] = distance(orig_lat,orig_lon,combo(sta_nums(i)).latitude,combo(sta_nums(i)).longitude);

total_distance(i) = sqrt(deg2km(dist(i))^2 + orig_depth^2)


end


x = [Ev_time(1:4) Ev_time(6:7) Ev_time(9:10) Ev_time(12:13) Ev_time(15:16) Ev_time(18:19)]
Event = strcat(dd(1:dir_end),'Ev_',x,'h')

xxx = load(string(Event));
pick_time = xxx(:,2)

length(strmatch(NaN,xxx(:,2)))

slowness = pick_time'./total_distance

velocity = 1./slowness
mean_vel = mean(velocity(isfinite(velocity)));
vel_limit = .08;

for i = 1:length(sta_nums)
    if velocity(i) ~= 0

    p1 = plot(orig_lon,orig_lat,'rp'); set(p1,'markersize',10);
    hold on
    plot(combo(sta_nums(i)).longitude,combo(sta_nums(i)).latitude,'bo')
    text(combo(sta_nums(i)).longitude,combo(sta_nums(i)).latitude,string(combo(sta_nums(i)).station))
    hold on
    
    l = line([orig_lon combo(sta_nums(i)).longitude] ,[orig_lat combo(sta_nums(i)).latitude])
    


    value(i) = (velocity(i) - mean_vel)/mean_vel;
    color_num = (abs(value(i)./vel_limit))./2;
    
    if color_num > 1; color_num = 1; end

    if value(i) >= 0;    set(l,'color',[1-color_num 1-color_num 1]); end
    if value(i) < 0;    set(l,'color',[1 1-color_num 1-color_num]); end

    
    
    hold on
end
end
velocity

S(f_len)
pause; clear combo total_distance;
clf

end

%Evt = strcat('Ev_',x,'_slowness')
%save(Evt,'slowness','velocity')

