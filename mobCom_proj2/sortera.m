%% läs in xcelfilen
clear;
[num,txt,raw] = xlsread('2018-05-02_utanettor.xlsx');

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









