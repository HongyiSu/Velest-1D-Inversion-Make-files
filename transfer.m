close all
% combo    [51,53,-129,-121]  2005-06-01 to 2006-11-01
%AC = rdsac('CN.PHC..BHZ.D.2005.342.000000.SAC');
%cc = length(combo);
% combo(cc+1).network = AC.HEADER.KNETWK;
% combo(cc+1).station = AC.HEADER.KSTNM;
% combo(cc+1).channel = AC.HEADER.KCMPNM;
% combo(cc+1).data = AC.d;




chans = extractfield(combo,'channel');
stas  = unique(extractfield(combo,'station'));
nsta = length(stas);

z_ii = strmatch('BHZ',chans);
n_ii = strmatch('BHN',chans);
e_ii = strmatch('BHE',chans);

num_verts = length(z_ii);

chans = extractfield(combo,'channel');
ii = strmatch('BHZ',chans);

%for i = 1:9;

%x = combo((ii(i))).data;
% dt = 1/combo(ii(i)).sampleRate;   
% [loc(i), snr_db(i)] = PphasePicker(x,dt,'wm','y',0.01,0.7,1000,'full');  %auto pick data in loc
   
%close all
%end

%for i = 11:length(ii);
%
%   x = combo((ii(i))).data;
%  dt = 1/combo(ii(i)).sampleRate;
    
% [loc(i), snr_db(i)] = PphasePicker(x,dt,'wm','y',0.01,0.7,1000,'full');  %auto pick data in loc
%close all
%end

traces = zeros(10000,num_verts*3)*nan;

for i = 1:num_verts;
traces(1:length(combo(z_ii(i)-2).data),((i-1)*3)+1) = combo(z_ii(i)-2).data;
traces(1:length(combo(z_ii(i)-1).data),((i-1)*3)+2) = combo(z_ii(i)-1).data;
traces(1:length(combo(z_ii(i)).data),((i-1)*3)+3) = combo(z_ii(i)).data;
end

xxx = traces(1:7000,:);

window = tukeywin(length(xxx),0.05);
for i = 1:size(traces,2)
 detraces(:,i) = detrend(xxx(:,i));
 win_tras(:,i) = detraces(:,i).*window;
end

dt = 1/combo(3).sampleRate;

[pickmatrix] = seis_pick(win_tras,dt,3) % create matrix pickmatrix

%for i=1:length(ii)    %% write auto P arrive data to Pickmatrix data
%pickmatrix(i,2)=loc(1,i)
%end 
%save(['E:\Study\', filename], 'data')

%matrix_fname = input('Output pick matrix file name : ','s');
%save(strcat('Event_',matrix_fname),'pickmatrix','-ascii');  %% save including auto pick data to file, name is date 
                
%[pickmatrix] = seis_pick(win_tras,dt,3)  %repoen the hand pick platform 