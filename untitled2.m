close all;

chans = extractfield(combo,'channel');
ii = strmatch('BHZ',chans);

for i = 1:length(ii);
    subplot(3,ceil(length(ii)/3),i) 
    plot(combo((ii(i))).data)
    title(combo(ii(i)).station)
end 

for i = 1:length(ii);

    x = combo((ii(i))).data;
    dt = 1/combo(ii(i)).sampleRate;
    
    [loc(i), snr_db(i)] = PphasePicker(x,dt,'wm','y',0.01,0.7,1000,'full');
    title(combo(ii(i)).station)
    combo(ii(i)).station
    pause
end
    
    
