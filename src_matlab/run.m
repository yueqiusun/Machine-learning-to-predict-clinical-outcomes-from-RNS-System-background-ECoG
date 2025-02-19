%%import data from the file NYU_ECoG_Catalog.csv to table Catalog
%%maybe change file name, change pat_id_list, if_le_list,
%%preprocess_time2int input


import_data;
% pat_id_list = {222};
% if_le_list = {0};
highcut = 90
    id = 201
    if_le = 0
    min_length = 45 * 250
    prepath = strcat('/Users/hp/GitHub/EEG/datdata/NY',num2str(id), '/NY',num2str(id),'_dat/');
    % convert convert the value in column 'RawLocalTimestamp' from str to
% integer
    Catalog = preprocess_time2int(Catalog_raw, 'RawLocalTimestamp', id);
    [T_power] = stitchall(Catalog,id, prepath, if_le, highcut, min_length);
    T_numi = get_numi(Catalog,id, prepath);
    %[stimulated, scheduled] = filter_scheduled(Catalog, id, prepath);
    [sche_dates, sti_dates, all_dates] = dummy2bool(Catalog, 'ECoGtrigger', 'Timestamp_int', 'Scheduled');
    T_S = get_sleep(Catalog, id);
    T_l = get_longepi(Catalog, if_le);
    
    features_1 = innerjoin(T_l, innerjoin(T_S, innerjoin(T_power, T_numi,'Keys','Var1'), 'Keys','Var1'), 'Keys','Var1');
    features_2 = table2array(features_1(:,[1,2,3,5,7,9]));
    features_3 = table2array(features_1(:,[2,3,5,7,9]));
    features = conv_dat2int(features_2, features_3);
    if if_le
        dates_filter = [sche_dates, t_le.'];
    else
        dates_filter = sche_dates;
    end
    T_arr_scheduled = features(ismember(features(:,2), dates_filter),:);
    save(strcat('/Users/hp/GitHub/EEG/data/features_', num2str(highcut), num2str(id)), 'T_arr_scheduled', '-v7.3');


a = Catalog.Timestamp_int(Catalog.Filename == "131222615481300000.dat");
B = sche_dates == a;
features(features(:,1) == 131222615481300000,:)
T_arr_scheduled(T_arr_scheduled(:,1) == 131222615481300000,:)
%check histogram of the long episodes
[idxs, file_le, t_le] = stim_firstns(Catalog, prepath);
a = idxs/250;
hist(a)
%plot bubble plot
pat_id_list = {226};
for i = 1:length(pat_id_list)
    id = pat_id_list{i};   
    Catalog = preprocess_time2int(Catalog_raw, 'RawLocalTimestamp', id);
    [sche_dates, sti_dates, all_dates] = dummy2bool(Catalog, 'ECoGtrigger', 'Timestamp_int', 'Scheduled');
    plot_schduled(sche_dates, sti_dates, id)
end
    

import_data;
highcut = 90;

ids = {239,225};

prepath = strcat('/Users/hp/GitHub/EEG/datdata/NY',num2str(id), '/NY',num2str(id),'_dat/');

for i = 1:length(ids)
    id = ids{i};
    Catalog = preprocess_time2int(Catalog_raw, 'RawLocalTimestamp', id);
    [sche_dates, sti_dates, all_dates] = dummy2bool(Catalog, 'ECoGtrigger', 'Timestamp_int', 'Scheduled');
    plot_schduled(sche_dates, sti_dates, all_dates, id);
end






%for patient 229

import_data;
pat_id_list = {229,222,231};

for i = 1:length(pat_id_list)
    id = pat_id_list{i}; 
    disp(id)
    id = 231;
    prepath = strcat('/Users/hp/GitHub/EEG/datdata/',num2str(id), '/');
    % convert convert the value in column 'RawLocalTimestamp' from str to
% integer
    Catalog = preprocess_time2int(Catalog_raw, 'RawLocalTimestamp', id);    
    
    T_power = stitchall(Catalog,id, prepath, 0);
    T_numi = get_numi(Catalog,id, prepath);
    %[stimulated, scheduled] = filter_scheduled(Catalog, id, prepath);
    [sche_dates, sti_dates, all_dates] = dummy2bool(Catalog, 'ECoGtrigger', 'Timestamp_int', 'Scheduled');
    T_S = get_sleep(Catalog);
    
    features_1 = join(T_S, join(T_power, T_numi,'Keys','Var1'), 'Keys','Var1');
    features_2 = table2array(features_1(:,[1,2,3,5,7]));
    features_3 = table2array(features_1(:,[2,3,5,7]));
    features = conv_dat2int(features_2, features_3);
    T_arr_scheduled = features(ismember(features(:,2), sche_dates),:);
    save(strcat('/Users/hp/GitHub/EEG/data/features_149', num2str(id)), 'T_arr_scheduled', '-v7.3');
end





