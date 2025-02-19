function plot_rmoutlier(pt_ID, sch, sti)
% convert convert the value in column 'RawLocalTimestamp' from str to
% integer


switch pt_ID
    case 222
        sched = [4/24, 16/24, 20/24];
        sched_names = {'04:00', '16:00', '20:00'};
        
    case 231
        sched = [4/24, 10/24, 16/24, 22/24];
        sched_names = {'04:00', '10:00', '16:00', '22:00'};
end

sti_date = floor(sti);
sti_4d = sti - sti_date;
sch_date = floor(sch);
sch_4d = sch - sch_date;
%length_4d = length(Catalog_Time_4d);
%x = linspace(1,length_4d, length_4d);
f_h = figure('OuterPosition', [50 50 800 600]);

scatter(sti_4d, sti_date, 'r')
hold on
scatter(sch_4d, sch_date, 'b')

set(gca, 'XTick', sched, 'XTickLabel', sched_names);
xlabel('Time during day');
ylabel('Date (MM/DD/YY)');
title(['Patient ID: ' num2str(pt_ID)])
hold off
%fig_name = ['/Users/hp/GitHub/EEG/fig/' num2str(pt_ID) '_DAT_time_date.png'];
%export_fig(fig_name, '-a1', '-nocrop');