%% läs in xcelfilen
clear;
[num,txt,raw] = xlsread('2018-05-06_utanettor2.xlsx');

sumRSSCELL = sum(strcmp(raw(:,2),'RSSCELL'));
sumGPS = sum(strcmp(raw(:,2),'GPS'));

rsscell = cell(sumRSSCELL,8);
gps = cell(sumGPS,8);

%Delar upp raw i rsscell och gps.
for i=1:1:length(raw)
    if strcmp(raw(i,2),'RSSCELL')
        rsscell(i,:)=raw(i,:);
        
    else  %strcmp(raw(i,2),'GPS')
        gps(i,:)=raw(i,:);
        
    end
end

%tar bort NaN och höjd över havet i GPS.
gps(:,5:8) =[];

%Tar bort all alla onödiga mellanrum. 
rsscell(all(cellfun('isempty',rsscell),2),:)=[];
gps(all(cellfun('isempty',gps),2),:)=[];

gpstider = cell2mat(gps(:,1));
rsscelltider = cell2mat(rsscell(:,1));

for i=1:1:length(rsscell)
   dummy = 10000000;
    for j=1:1:length(gps)       
          if (abs(rsscelltider(i,1) - gpstider(j,1)) < dummy)
             dummy = abs(rsscelltider(i,1) - gpstider(j,1));
             rsscell(i,4) = gps(j,3);
             rsscell(i,5) = gps(j,4);
           
          end
    end
    
    
end

T = cell2table(rsscell);

writetable(T,'MA_long3.txt', 'Delimiter', '\t')


  


 


