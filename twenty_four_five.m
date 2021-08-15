%Appendix: The Developed Matlab Monte Carlo Simulation Code
%with just one power system 

clear, clc,

global lambda MTTR


N = 64; % number of components
%Failure rates for each component in (events/y)
Gf=0.1704+zeros(6,1);
Ff = 0.1805+zeros(31,1);
Lf = 0.05195+zeros(27,1);

lambda = [Gf; Ff; Lf];

% Mean time to repair for each component (h/yr)
Gm = 7.07562205+zeros(6,1);
Fm = 7.10365672+zeros(31,1);
Lm = 7.21010526+zeros(27,1);

MTTR = [Gm; Fm; Lm];

% Power not supplied for by each component (MW/y)
Gp = 56234.63832+zeros(6,1);
Fp = 59569.2762+zeros(37,1);
Lp = 13590.42835+zeros(27,1);

power = [Gp; Fp; Lp];

users = ceil(power/2)-1;
%% failure history
duration = 1000; % years
interruption = 0;
outage_time = 0;
maxT = 0;
for i = 1:N
    [downT{i},upT{i}] = failure_history1(lambda(i),MTTR(i),duration);
    cur = max(upT{i}(1:end));
    if (maxT < cur)
        maxT = cur;
    end
    interruption = interruption + length(downT{i})-1;
    outage_time = outage_time + sum(upT{i}-downT{i});
    % figure;
    line(1:length(downT{i}),downT{i});
    line(1:length(downT{i}),upT{i},'color','g','Marker','.');
end

% INDEXES calculation
average_interuption = interruption/duration;
average_outage_time = outage_time/duration;
customers_num = sum(users);
total_power = sum(power);
SAIFI = average_interuption*customers_num/customers_num;
SAIDI = average_outage_time*customers_num/customers_num;
CAIDI = SAIDI/SAIFI;
ASAI = (customers_num*8760 - average_outage_time*customers_num)/...
    (customers_num*8760);
EUE = average_outage_time*total_power; % mW*hour
disp('-------------------------------');
disp('For 2024&2025');
disp(['SAIFI ' num2str(SAIFI)]);
disp(['SAIDI ' num2str(SAIDI)]);
disp(['CAIDI ' num2str(CAIDI)]);
disp(['ASAI ' num2str(ASAI)]);
disp(['EUE ' num2str(EUE)]);





