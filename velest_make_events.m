clear all; close all
T = readtable('nrcan.txt');
A = readtable('output.txt');
B = readtable('mike.txt')
datei = A.Var1; datee = cell2mat(datei); datee(1,:)
sec = A.Var2
A_la = A.Var3
A_lo = A.Var4
A_de  = A.Var5

ev_t = T(:,2); 
ev_la = T(:,3);
ev_lo = T(:,4);
ev_d = T(:,5);
ev_m = T(:,7);
 
fid2 = fopen('new_list');
S = fscanf(fid2,'%s');
 
st_txt = strfind(S,'mag');
end_txt = strfind(S,'E');
n_events = length(st_txt);
txt_counter = 1;
 
fid = fopen('delete','w')
 for i_events = 1:n_events

    text_start = st_txt;
    text_stop = end_txt +17;
    T1 = readtable(S(text_start(i_events):text_stop(i_events)));
    TT = table2cell(T1);
    
    xxx = S(text_start(i_events):text_stop(i_events));
    
    d_st = strfind(xxx,'m');
    d_ed = strfind(xxx,'/');
    xx = xxx(d_st:d_ed);
    
    E_st = strfind(xxx,'E');
    E_time = xxx(E_st+3:E_st+16);
    
    dd = strcat(xx,'Event_',E_time);
    
    load(dd);
    a = struct2cell(combo);
    sta_num = strmatch('BHZ',a(4,:,:));
    S(text_start:text_stop)
    
    for j = 1:length(sta_num)
        
          ppp = cell2mat(a(2,:,sta_num(j)));
          
          if string(ppp) == "BBB"; ppp = 'BBB ';a(2,:,sta_num(j)) = mat2cell(ppp,1);
              elseif string(ppp) == "BS04M"; ppp = 'B04M'; a(2,:,sta_num(j)) = mat2cell(ppp,1);
              elseif string(ppp) == "BS12M"; ppp = 'B12M'; a(2,:,sta_num(j)) = mat2cell(ppp,1);
              elseif string(ppp) == "BS15A"; ppp = 'B15A'; a(2,:,sta_num(j)) = mat2cell(ppp,1);
         end;
         TT(j,1) = a(2,:,sta_num(j));
    end
    
    
    n = datenum(str2num(E_time(1:4)),str2num(E_time(5:6)),str2num(E_time(7:8)),str2num(E_time(9:10)),str2num(E_time(11:12)),str2num(E_time(13:14)));
    Ev_time = datestr(n,'yyyy-mm-ddTHH:MM:SS');
    
    yy = Ev_time(1:4);
    yyy = Ev_time(6:7);
    dd = Ev_time(9:10);
    MM = Ev_time(12:13);
    DD = Ev_time(15:16);
    SS = Ev_time(18:19);
    
    

    
    for k = 1:length(datee)
       aaa = datee(k,:)
       yy1 = '20'; yyy1 = aaa(3:4); mm1 = aaa(6:7); dd1 = aaa(9:10) 
    
    ttt =['grep ' Ev_time ' nrcan.txt']
    [status output] = system(ttt)  ;  
    inds = strfind(output,'|') ;
    
    T3 = [TT(:,1) TT(:,2)];
    
    T4 = cell2table(T3);
    T4.Properties.VariableNames ={'station','Ppick'};
    
   
    orig_lat = str2num(output(inds(2)+1:inds(3)-1))
    orig_lon = str2num(output(inds(3)+1:inds(4)-1))
    orig_depth = str2num(output(inds(4)+1:inds(5)-1))
    
    orig_mag = str2num(output(inds(6)+1:inds(7)-1))
   
fprintf(fid,'%8.4f%s %8.4f%s %7.2f %7.2f\n',abs(orig_lat),'N',abs(orig_lon),'W',orig_depth,orig_mag)
 
fii = isfinite(cell2mat(T3(:,2))); wii = find(fii == 1);
 
 for ii=1:length(wii)
    T4.Ppick(wii(ii));         
    fprintf(fid,'%s%d %5.2f',cell2mat(strcat(T3(wii(ii),1),'P')),0,cell2mat(T3(wii(ii),2)));
   if ii == 6 & length(wii)~= 6;  fprintf(fid,'\n');
      elseif ii == 12 & length(wii)~= 12;  fprintf(fid,'\n'); 
        elseif  ii == 18 & length(wii)~= 18;  fprintf(fid,'\n');
   end
   if ii == length(wii); fprintf(fid,'\n'); end
 end
 fprintf(fid,'\n');
 
end
 
fclose(fid);

 
end
