% % Import Data
% TITLE= 'Select the file with the data you want to bring into MATLAB';
% [filename,filepath] = uigetfile('*.*', TITLE); %Prompts the user to select a data file
% full_filename = fullfile( filepath, filename );
% 
% [~,SheetNames] = xlsfinfo(full_filename);
% nSheets = length(SheetNames);
% Data = [];
% for ii=1:nSheets
%     Name =  SheetNames{ii};
%     Data = [Data, xlsread(full_filename, Name)];
% end
% 
% 
% forward_voltage_V577 = Data(:,1);
% forward_current_A577 = Data(:,2);
% reverse_voltage_V577 = Data(:,4);
% reverse_current_A577 = Data(:,5);
% 
% forward_voltage_V546 = Data(:,6);
% forward_current_A546 = Data(:,7);
% reverse_voltage_V546 = Data(:,9);
% reverse_current_A546 = Data(:,10);
% 
% forward_voltage_V436 = Data(:,11);
% forward_current_A436 = Data(:,12);
% reverse_voltage_V436 = Data(:,14);
% reverse_current_A436 = Data(:,15);
% 
% forward_voltage_V405 = Data(:,16);
% forward_current_A405 = Data(:,17);
% reverse_voltage_V405 = Data(:,19);
% reverse_current_A405 = Data(:,20);
% 
% forward_voltage_V365 = Data(:,21);
% forward_current_A365 = Data(:,22);
% reverse_voltage_V365 = Data(:,24);
% reverse_current_A365 = Data(:,25);
% 
% 
% 
% 
% 
% %%%%% 577 analysis
% 
% %%% FORWARD
% 
% % Calculate average of three runs
% firstrun577 = forward_current_A577(1:301);
% secondrun577 = forward_current_A577(302:602);
% thirdrun577 = forward_current_A577(603:903);
% 
% averagecurrent577 = [];
% current_standard_dev_577 = [];
% for i = 1:301;
%     averagecurrent577i = (firstrun577(i) + secondrun577(i) + thirdrun577(i))/3;
%     current_standard_dev_577(i) = std([firstrun577(i); secondrun577(i); thirdrun577(i)]);
%     averagecurrent577(i) =  averagecurrent577i;
% end
% voltagetouse577 = forward_voltage_V577(1:301);
% 
% % Uncertainty in Voltage
% voltage_unc_577 = 0.001*ones(size(voltagetouse577));
% 
% % Uncertainty in Current
% current_standard_error_577 = current_standard_dev_577/ sqrt(3);
% 
% % Find imax
% figure
% fitop_577 = fitoptions('Method','NonlinearLeastSquares','StartPoint',[4e-8 8e-10 0.08]);
% imax_fittype_577 = fittype('a-b*exp(-c*x)','options',fitop_577);
% imax_577_fit = fit(voltagetouse577,averagecurrent577',imax_fittype_577);
% imax_577_fit_coeff = coeffvalues(imax_577_fit);
% errorbar(voltagetouse577, averagecurrent577',current_standard_error_577,current_standard_error_577,voltage_unc_577,voltage_unc_577);
% hold on;
% plot(imax_577_fit);
% grid on;
% imax_577 = imax_577_fit_coeff(1);
% i_max_fit_confint = confint(imax_577_fit, 0.68);
% imax_577_unc = (i_max_fit_confint(2,1)-i_max_fit_confint(1,1))/2;
% title("Fitted Exponential Curve to Forward Bias Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% 
% 
% %%% REVERSE
% 
% % Calculate average of three runs 
% firstrun_reverse_577 = reverse_current_A577(1:41);
% secondrun_reverse_577 = reverse_current_A577(42:82);
% thirdrun_reverse_577 = reverse_current_A577(83:123);
% 
% averagecurrent_reverse_577 =[];
% current_reverse_standard_dev_577 = [];
% for i = 1:41;
%     averagecurrent_reverse_577i = (firstrun_reverse_577(i) + secondrun_reverse_577(i) + thirdrun_reverse_577(i)) / 3;
%     current_reverse_standard_dev_577(i) = std([firstrun577(i); secondrun577(i); thirdrun577(i)]);
%     averagecurrent_reverse_577(i) = averagecurrent_reverse_577i;
% end
% voltagetouse_reverse_577 = reverse_voltage_V577(1:41);
% voltagetouse_reverse_577 = -voltagetouse_reverse_577;
% 
% % Uncertainty in Voltage
% voltage_unc_reverse_577 = 0.001*ones(size(voltagetouse_reverse_577));
% 
% % Uncertainty in Current
% current_reverse_standard_error_577 = current_reverse_standard_dev_577/ sqrt(3);
% 
% % Plot a figure with both data sets on one graph
% figure
% errorbar(voltagetouse577, averagecurrent577',current_standard_error_577,current_standard_error_577,voltage_unc_577,voltage_unc_577);
% hold on;
% errorbar(voltagetouse_reverse_577, averagecurrent_reverse_577,current_reverse_standard_error_577,current_reverse_standard_error_577,voltage_unc_reverse_577,voltage_unc_reverse_577)
% plot(voltagetouse577, averagecurrent577');
% plot(voltagetouse_reverse_577, averagecurrent_reverse_577);
% grid on;
% title("Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the forward bias
% figure
% errorbar(voltagetouse577, averagecurrent577',current_standard_error_577,current_standard_error_577,voltage_unc_577,voltage_unc_577);
% title("Forward Bias Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the reverse bias 
% figure
% errorbar(voltagetouse_reverse_577, averagecurrent_reverse_577,current_reverse_standard_error_577,current_reverse_standard_error_577,voltage_unc_reverse_577,voltage_unc_reverse_577)
% title("Reverse Bias Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Find knee using plateau uncertaities and deviation from that value
% 
% % Calculate aveage data point
% running_total_577 = 0;
% h577 = averagecurrent_reverse_577(20:35);
% for i = 1:6;
%     running_total_577 = h577(i) + running_total_577;
% end
% average_threshold_point_577 = running_total_577 / 6;
% 
% % Calculate average error bar size
% running_total_577 = 0;
% g577 = current_reverse_standard_error_577(20:35);
% for i = 1:6;
%     running_total_577 = g577(i)^2 + running_total_577;
% end
% uncertainty_mean_577 = sqrt(running_total_577)/6;
% 
% % Calculate standard deviation
% standard_dev_577 = std(current_reverse_standard_error_577(20:35));
% 
% % Calculate threshold bar
% threshold_bar_577 = sqrt(uncertainty_mean_577^2 + standard_dev_577^2);
% 
% % Calculate threshold
% threshold_577 = threshold_bar_577 + average_threshold_point_577;
% 
% % Plot the threshold line
% figure
% errorbar(voltagetouse_reverse_577, averagecurrent_reverse_577,current_reverse_standard_error_577,current_reverse_standard_error_577,voltage_unc_reverse_577,voltage_unc_reverse_577)
% title("Threshold Value for Reverse Bias Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% x = [-2 : 0.5 : 0];
% Z = threshold_577 * ones(1, length(x));
% plot(x, Z)
% grid on;
% 
% % Find knee using intersection of flat slopes
% 
% % Calculating slope of top line
% k577 = averagecurrent_reverse_577(1:9);
% j577 = voltagetouse_reverse_577(1:9);
% 
% % Plot intersection of lines
% figure
% errorbar(voltagetouse_reverse_577, averagecurrent_reverse_577,current_reverse_standard_error_577,current_reverse_standard_error_577,voltage_unc_reverse_577,voltage_unc_reverse_577)
% title("Slope Intersection for Reverse Bias Current vs. Voltage (577nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% 
% % Plot top line
% c_577 = polyfit(j577,k577',1);
% xFit_577 = linspace(-2, 0, 100);
% yFit_577 = polyval(c_577, xFit_577);
% hold on;
% plot(xFit_577, yFit_577);
% grid on;
% 
% % Plot bottom line
% x = [-2 : 0.5 : 0];
% % Use already calculated value for average_threshold_point to get bottom
% % line
% Z_577 = average_threshold_point_577 * ones(1, length(x));
% plot(x, Z_577)
% grid on;
% 
% 
% 
% 
% 
% %%%%% 546 analysis
% 
% %%% FORWARD
% 
% % Calculate average of three runs
% firstrun546 = forward_current_A546(1:301);
% secondrun546 = forward_current_A546(302:602);
% thirdrun546 = forward_current_A546(603:903);
% 
% averagecurrent546 = [];
% current_standard_dev_546 = [];
% for i = 1:301;
%     averagecurrent546i = (firstrun546(i) + secondrun546(i) + thirdrun546(i))/3;
%     current_standard_dev_546(i) = std([firstrun546(i); secondrun546(i); thirdrun546(i)]);
%     averagecurrent546(i) =  averagecurrent546i;
% end
% voltagetouse546 = forward_voltage_V546(1:301);
% 
% % Uncertainty in Voltage
% voltage_unc_546 = 0.001*ones(size(voltagetouse546));
% 
% % Uncertainty in Current
% current_standard_error_546 = current_standard_dev_546/ sqrt(3);
% 
% % Find imax
% figure
% fitop_546 = fitoptions('Method','NonlinearLeastSquares','StartPoint',[6e-8 1e-10 0.06]);
% imax_fittype_546 = fittype('a-b*exp(-c*x)','options',fitop_546);
% imax_546_fit = fit(voltagetouse546,averagecurrent546',imax_fittype_546);
% imax_546_fit_coeff = coeffvalues(imax_546_fit);
% errorbar(voltagetouse546, averagecurrent546',current_standard_error_546,current_standard_error_546,voltage_unc_546,voltage_unc_546);
% hold on;
% plot(imax_546_fit);
% grid on;
% imax_546 = imax_546_fit_coeff(1);
% i_max_fit_confint = confint(imax_546_fit, 0.68);
% imax_546_unc = (i_max_fit_confint(2,1)-i_max_fit_confint(1,1))/2;
% title("Fitted Exponential Curve to Forward Bias Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% 
% 
% %%% REVERSE
% 
% % Calculate average of three runs 
% firstrun_reverse_546 = reverse_current_A546(1:41);
% secondrun_reverse_546 = reverse_current_A546(42:82);
% thirdrun_reverse_546 = reverse_current_A546(83:123);
% 
% averagecurrent_reverse_546 =[];
% current_reverse_standard_dev_546 = [];
% for i = 1:41;
%     averagecurrent_reverse_546i = (firstrun_reverse_546(i) + secondrun_reverse_546(i) + thirdrun_reverse_546(i)) / 3;
%     current_reverse_standard_dev_546(i) = std([firstrun546(i); secondrun546(i); thirdrun546(i)]);
%     averagecurrent_reverse_546(i) = averagecurrent_reverse_546i;
% end
% voltagetouse_reverse_546 = reverse_voltage_V546(1:41);
% voltagetouse_reverse_546 = -voltagetouse_reverse_546;
% 
% % Uncertainty in Voltage
% voltage_unc_reverse_546 = 0.001*ones(size(voltagetouse_reverse_546));
% 
% % Uncertainty in Current
% current_reverse_standard_error_546 = current_reverse_standard_dev_546/ sqrt(3);
% 
% % Plot a figure with both data sets on one graph
% figure
% errorbar(voltagetouse546, averagecurrent546',current_standard_error_546,current_standard_error_546,voltage_unc_546,voltage_unc_546);
% hold on;
% errorbar(voltagetouse_reverse_546, averagecurrent_reverse_546,current_reverse_standard_error_546,current_reverse_standard_error_546,voltage_unc_reverse_546,voltage_unc_reverse_546)
% plot(voltagetouse546, averagecurrent546');
% grid on;
% plot(voltagetouse_reverse_546, averagecurrent_reverse_546);
% title("Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the forward bias
% figure
% errorbar(voltagetouse546, averagecurrent546',current_standard_error_546,current_standard_error_546,voltage_unc_546,voltage_unc_546);
% title("Forward Bias Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the reverse bias 
% figure
% errorbar(voltagetouse_reverse_546, averagecurrent_reverse_546,current_reverse_standard_error_546,current_reverse_standard_error_546,voltage_unc_reverse_546,voltage_unc_reverse_546)
% title("Reverse Bias Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Find knee using plateau uncertaities and deviation from that value
% 
% % Calculate aveage data point
% running_total_546 = 0;
% h546 = averagecurrent_reverse_546(35:40);
% for i = 1:6;
%     running_total_546 = h546(i) + running_total_546;
% end
% average_threshold_point_546 = running_total_546 / 6;
% 
% % Calculate average error bar size
% running_total_546 = 0;
% g546 = current_reverse_standard_error_546(35:40);
% for i = 1:6;
%     running_total_546 = g546(i)^2 + running_total_546;
% end
% uncertainty_mean_546 = sqrt(running_total_546)/6;
% 
% % Calculate standard deviation
% standard_dev_546 = std(current_reverse_standard_error_546(35:40));
% 
% % Calculate threshold bar
% threshold_bar_546 = sqrt(uncertainty_mean_546^2 + standard_dev_546^2);
% 
% % Calculate threshold
% threshold_546 = threshold_bar_546 + average_threshold_point_546;
% 
% % Plot the threshold line
% figure
% errorbar(voltagetouse_reverse_546, averagecurrent_reverse_546,current_reverse_standard_error_546,current_reverse_standard_error_546,voltage_unc_reverse_546,voltage_unc_reverse_546)
% title("Threshold Value for Reverse Bias Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% x = [-2 : 0.5 : 0];
% Z = threshold_546 * ones(1, length(x));
% plot(x, Z)
% grid on;
% 
% % Find knee using intersection of flat slopes
% 
% % Calculating slope of top line
% k546 = averagecurrent_reverse_546(1:8);
% j546 = voltagetouse_reverse_546(1:8);
% 
% % Plot intersection of lines
% figure
% errorbar(voltagetouse_reverse_546, averagecurrent_reverse_546,current_reverse_standard_error_546,current_reverse_standard_error_546,voltage_unc_reverse_546,voltage_unc_reverse_546)
% title("Slope Intersection for Reverse Bias Current vs. Voltage (546nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% 
% % Plot top line
% c_546 = polyfit(j546,k546',1);
% xFit_546 = linspace(-2, 0, 100);
% yFit_546 = polyval(c_546, xFit_546);
% hold on;
% plot(xFit_546, yFit_546);
% grid on;
% 
% % Plot bottom line
% x = [-2 : 0.5 : 0];
% % Use already calculated value for average_threshold_point to get bottom
% % line
% Z_546 = average_threshold_point_546 * ones(1, length(x));
% plot(x, Z_546)
% grid on;
% 
% 
% 
% 
% %%%%% 436 analysis
% 
% %%% FORWARD
% 
% % Calculate average of three runs
% firstrun436 = forward_current_A436(1:301);
% secondrun436 = forward_current_A436(302:602);
% thirdrun436 = forward_current_A436(603:903);
% 
% averagecurrent436 = [];
% current_standard_dev_436 = [];
% for i = 1:301;
%     averagecurrent436i = (firstrun436(i) + secondrun436(i) + thirdrun436(i))/3;
%     current_standard_dev_436(i) = std([firstrun436(i); secondrun436(i); thirdrun436(i)]);
%     averagecurrent436(i) =  averagecurrent436i;
% end
% voltagetouse436 = forward_voltage_V436(1:301);
% 
% % Uncertainty in Voltage
% voltage_unc_436 = 0.001*ones(size(voltagetouse436));
% 
% % Uncertainty in Current
% current_standard_error_436 = current_standard_dev_436/ sqrt(3);
% 
% % Find imax
% figure
% fitop_436 = fitoptions('Method','NonlinearLeastSquares','StartPoint',[8e-8 1e-10 0.045]);
% imax_fittype_436 = fittype('a-b*exp(-c*x)','options',fitop_436);
% imax_436_fit = fit(voltagetouse436,averagecurrent436',imax_fittype_436);
% imax_436_fit_coeff = coeffvalues(imax_436_fit);
% errorbar(voltagetouse436, averagecurrent436',current_standard_error_436,current_standard_error_436,voltage_unc_436,voltage_unc_436);
% hold on;
% plot(imax_436_fit);
% grid on;
% imax_436 = imax_436_fit_coeff(1);
% i_max_fit_confint = confint(imax_436_fit, 0.68);
% imax_436_unc = (i_max_fit_confint(2,1)-i_max_fit_confint(1,1))/2;
% title("Fitted Exponential Curve to Forward Bias Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% 
% 
% %%% REVERSE
% 
% % Calculate average of three runs 
% firstrun_reverse_436 = reverse_current_A436(1:41);
% secondrun_reverse_436 = reverse_current_A436(42:82);
% thirdrun_reverse_436 = reverse_current_A436(83:123);
% 
% averagecurrent_reverse_436 =[];
% current_reverse_standard_dev_436 = [];
% for i = 1:41;
%     averagecurrent_reverse_436i = (firstrun_reverse_436(i) + secondrun_reverse_436(i) + thirdrun_reverse_436(i)) / 3;
%     current_reverse_standard_dev_436(i) = std([firstrun436(i); secondrun436(i); thirdrun436(i)]);
%     averagecurrent_reverse_436(i) = averagecurrent_reverse_436i;
% end
% voltagetouse_reverse_436 = reverse_voltage_V436(1:41);
% voltagetouse_reverse_436 = -voltagetouse_reverse_436;
% 
% % Uncertainty in Voltage
% voltage_unc_reverse_436 = 0.001*ones(size(voltagetouse_reverse_436));
% 
% % Uncertainty in Current
% current_reverse_standard_error_436 = current_reverse_standard_dev_436/ sqrt(3);
% 
% % Plot a figure with both data sets on one graph
% figure
% errorbar(voltagetouse436, averagecurrent436',current_standard_error_436,current_standard_error_436,voltage_unc_436,voltage_unc_436);
% hold on;
% errorbar(voltagetouse_reverse_436, averagecurrent_reverse_436,current_reverse_standard_error_436,current_reverse_standard_error_436,voltage_unc_reverse_436,voltage_unc_reverse_436)
% plot(voltagetouse436, averagecurrent436');
% plot(voltagetouse_reverse_436, averagecurrent_reverse_436);
% grid on;
% title("Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the forward bias
% figure
% errorbar(voltagetouse436, averagecurrent436',current_standard_error_436,current_standard_error_436,voltage_unc_436,voltage_unc_436);
% title("Forward Bias Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the reverse bias 
% figure
% errorbar(voltagetouse_reverse_436, averagecurrent_reverse_436,current_reverse_standard_error_436,current_reverse_standard_error_436,voltage_unc_reverse_436,voltage_unc_reverse_436)
% title("Reverse Bias Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Find knee using plateau uncertaities and deviation from that value
% 
% % Calculate aveage data point
% running_total_436 = 0;
% h436 = averagecurrent_reverse_436(35:40);
% for i = 1:6;
%     running_total_436 = h436(i) + running_total_436;
% end
% average_threshold_point_436 = running_total_436 / 6;
% 
% % Calculate average error bar size
% running_total_436 = 0;
% g436 = current_reverse_standard_error_436(35:40);
% for i = 1:6;
%     running_total_436 = g436(i)^2 + running_total_436;
% end
% uncertainty_mean_436 = sqrt(running_total_436)/6;
% 
% % Calculate standard deviation
% standard_dev_436 = std(current_reverse_standard_error_436(35:40));
% 
% % Calculate threshold bar
% threshold_bar_436 = sqrt(uncertainty_mean_436^2 + standard_dev_436^2);
% 
% % Calculate threshold
% threshold_436 = threshold_bar_436 + average_threshold_point_436;
% 
% % Plot the threshold line
% figure
% errorbar(voltagetouse_reverse_436, averagecurrent_reverse_436,current_reverse_standard_error_436,current_reverse_standard_error_436,voltage_unc_reverse_436,voltage_unc_reverse_436)
% title("Threshold Value for Reverse Bias Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% x = [-2 : 0.5 : 0];
% Z = threshold_436 * ones(1, length(x));
% plot(x, Z)
% grid on;
% 
% % Find knee using intersection of flat slopes
% 
% % Calculating slope of top line
% k436 = averagecurrent_reverse_436(1:11);
% j436 = voltagetouse_reverse_436(1:11);
% 
% % Plot intersection of lines
% figure
% errorbar(voltagetouse_reverse_436, averagecurrent_reverse_436,current_reverse_standard_error_436,current_reverse_standard_error_436,voltage_unc_reverse_436,voltage_unc_reverse_436)
% title("Slope Intersection for Reverse Bias Current vs. Voltage (436nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% 
% % Plot top line
% c_436 = polyfit(j436,k436',1);
% xFit_436 = linspace(-2, 0, 100);
% yFit_436 = polyval(c_436, xFit_436);
% hold on;
% plot(xFit_436, yFit_436);
% grid on;
% 
% % Plot bottom line
% x = [-2 : 0.5 : 0];
% % Use already calculated value for average_threshold_point to get bottom
% % line
% Z_436 = average_threshold_point_436 * ones(1, length(x));
% plot(x, Z_436)
% grid on;
% 
% 
% 
% 
% %%%%% 405 analysis
% 
% %%% FORWARD
% 
% % Calculate average of three runs
% firstrun405 = forward_current_A405(1:301);
% secondrun405 = forward_current_A405(302:602);
% thirdrun405 = forward_current_A405(603:903);
% 
% averagecurrent405 = [];
% current_standard_dev_405 = [];
% for i = 1:301;
%     averagecurrent405i = (firstrun405(i) + secondrun405(i) + thirdrun405(i))/3;
%     current_standard_dev_405(i) = std([firstrun405(i); secondrun405(i); thirdrun405(i)]);
%     averagecurrent405(i) =  averagecurrent405i;
% end
% voltagetouse405 = forward_voltage_V405(1:301);
% 
% % Uncertainty in Voltage
% voltage_unc_405 = 0.001*ones(size(voltagetouse405));
% 
% % Uncertainty in Current
% current_standard_error_405 = current_standard_dev_405/ sqrt(3);
% 
% % Find imax
% figure
% fitop_405 = fitoptions('Method','NonlinearLeastSquares','StartPoint',[4e-8 4e-10 0.04]);
% imax_fittype_405 = fittype('a-b*exp(-c*x)','options',fitop_405);
% imax_405_fit = fit(voltagetouse405,averagecurrent405',imax_fittype_405);
% imax_405_fit_coeff = coeffvalues(imax_405_fit);
% errorbar(voltagetouse405, averagecurrent405',current_standard_error_405,current_standard_error_405,voltage_unc_405,voltage_unc_405);
% hold on;
% plot(imax_405_fit);
% grid on;
% imax_405 = imax_405_fit_coeff(1);
% i_max_fit_confint = confint(imax_405_fit, 0.68);
% imax_405_unc = (i_max_fit_confint(2,1)-i_max_fit_confint(1,1))/2;
% title("Fitted Exponential Curve to Forward Bias Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% 
% 
% %%% REVERSE
% 
% % Calculate average of three runs 
% firstrun_reverse_405 = reverse_current_A405(1:41);
% secondrun_reverse_405 = reverse_current_A405(42:82);
% thirdrun_reverse_405 = reverse_current_A405(83:123);
% 
% averagecurrent_reverse_405 =[];
% current_reverse_standard_dev_405 = [];
% for i = 1:41;
%     averagecurrent_reverse_405i = (firstrun_reverse_405(i) + secondrun_reverse_405(i) + thirdrun_reverse_405(i)) / 3;
%     current_reverse_standard_dev_405(i) = std([firstrun405(i); secondrun405(i); thirdrun405(i)]);
%     averagecurrent_reverse_405(i) = averagecurrent_reverse_405i;
% end
% voltagetouse_reverse_405 = reverse_voltage_V405(1:41);
% voltagetouse_reverse_405 = -voltagetouse_reverse_405;
% 
% % Uncertainty in Voltage
% voltage_unc_reverse_405 = 0.001*ones(size(voltagetouse_reverse_405));
% 
% % Uncertainty in Current
% current_reverse_standard_error_405 = current_reverse_standard_dev_405/ sqrt(3);
% 
% % Plot a figure with both data sets on one graph
% figure
% errorbar(voltagetouse405, averagecurrent405',current_standard_error_405,current_standard_error_405,voltage_unc_405,voltage_unc_405);
% hold on;
% errorbar(voltagetouse_reverse_405, averagecurrent_reverse_405,current_reverse_standard_error_405,current_reverse_standard_error_405,voltage_unc_reverse_405,voltage_unc_reverse_405)
% plot(voltagetouse405, averagecurrent405');
% plot(voltagetouse_reverse_405, averagecurrent_reverse_405);
% grid on;
% title("Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the forward bias
% figure
% errorbar(voltagetouse405, averagecurrent405',current_standard_error_405,current_standard_error_405,voltage_unc_405,voltage_unc_405);
% title("Forward Bias Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the reverse bias 
% figure
% errorbar(voltagetouse_reverse_405, averagecurrent_reverse_405,current_reverse_standard_error_405,current_reverse_standard_error_405,voltage_unc_reverse_405,voltage_unc_reverse_405)
% title("Reverse Bias Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Find knee using plateau uncertaities and deviation from that value
% 
% % Calculate aveage data point
% running_total_405 = 0;
% h405 = averagecurrent_reverse_405(35:40);
% for i = 1:6;
%     running_total_405 = h405(i) + running_total_405;
% end
% average_threshold_point_405 = running_total_405 / 6;
% 
% % Calculate average error bar size
% running_total_405 = 0;
% g405 = current_reverse_standard_error_405(35:40);
% for i = 1:6;
%     running_total_405 = g405(i)^2 + running_total_405;
% end
% uncertainty_mean_405 = sqrt(running_total_405)/6;
% 
% % Calculate standard deviation
% standard_dev_405 = std(current_reverse_standard_error_405(35:40));
% 
% % Calculate threshold bar
% threshold_bar_405 = sqrt(uncertainty_mean_405^2 + standard_dev_405^2);
% 
% % Calculate threshold
% threshold_405 = threshold_bar_405 + average_threshold_point_405;
% 
% % Plot the threshold line
% figure
% errorbar(voltagetouse_reverse_405, averagecurrent_reverse_405,current_reverse_standard_error_405,current_reverse_standard_error_405,voltage_unc_reverse_405,voltage_unc_reverse_405)
% title("Threshold Value for Reverse Bias Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% x = [-2 : 0.5 : 0];
% Z = threshold_405 * ones(1, length(x));
% plot(x, Z)
% grid on;
% 
% % Find knee using intersection of flat slopes
% 
% % Calculating slope of top line
% k405 = averagecurrent_reverse_405(3:16);
% j405 = voltagetouse_reverse_405(3:16);
% 
% % Plot intersection of lines
% figure
% errorbar(voltagetouse_reverse_405, averagecurrent_reverse_405,current_reverse_standard_error_405,current_reverse_standard_error_405,voltage_unc_reverse_405,voltage_unc_reverse_405)
% title("Slope Intersection for Reverse Bias Current vs. Voltage (405nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% 
% % Plot top line
% c_405 = polyfit(j405,k405',1);
% xFit_405 = linspace(-2, 0, 100);
% yFit_405 = polyval(c_405, xFit_405);
% hold on;
% plot(xFit_405, yFit_405);
% grid on;
% 
% % Plot bottom line
% x = [-2 : 0.5 : 0];
% % Use already calculated value for average_threshold_point to get bottom
% % line
% Z_405 = average_threshold_point_405 * ones(1, length(x));
% plot(x, Z_405)
% grid on;
% 
% 
% 
% 
% 
% %%%%% 365 analysis
% 
% %%% FORWARD
% 
% % Calculate average of three runs
% firstrun365 = forward_current_A365(1:301);
% secondrun365 = forward_current_A365(302:602);
% thirdrun365 = forward_current_A365(603:903);
% 
% averagecurrent365 = [];
% current_standard_dev_365 = [];
% for i = 1:301;
%     averagecurrent365i = (firstrun365(i) + secondrun365(i) + thirdrun365(i))/3;
%     current_standard_dev_365(i) = std([firstrun365(i); secondrun365(i); thirdrun365(i)]);
%     averagecurrent365(i) =  averagecurrent365i;
% end
% voltagetouse365 = forward_voltage_V365(1:301);
% 
% % Uncertainty in Voltage
% voltage_unc_365 = 0.001*ones(size(voltagetouse365));
% 
% % Uncertainty in Current
% current_standard_error_365 = current_standard_dev_365/ sqrt(3);
% 
% % Find imax
% figure
% fitop_365 = fitoptions('Method','NonlinearLeastSquares','StartPoint',[1e-8 4e-10 0.04]);
% imax_fittype_365 = fittype('a-b*exp(-c*x)','options',fitop_365);
% imax_365_fit = fit(voltagetouse365,averagecurrent365',imax_fittype_365);
% imax_365_fit_coeff = coeffvalues(imax_365_fit);
% errorbar(voltagetouse365, averagecurrent365',current_standard_error_365,current_standard_error_365,voltage_unc_365,voltage_unc_365);
% hold on;
% plot(imax_365_fit);
% grid on;
% imax_365 = imax_365_fit_coeff(1);
% i_max_fit_confint = confint(imax_365_fit, 0.68);
% imax_365_unc = (i_max_fit_confint(2,1)-i_max_fit_confint(1,1))/2;
% title("Fitted Exponential Curve to Forward Bias Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% 
% 
% %%% REVERSE
% 
% % Calculate average of three runs 
% firstrun_reverse_365 = reverse_current_A365(1:41);
% secondrun_reverse_365 = reverse_current_A365(42:82);
% thirdrun_reverse_365 = reverse_current_A365(83:123);
% 
% averagecurrent_reverse_365 =[];
% current_reverse_standard_dev_365 = [];
% for i = 1:41;
%     averagecurrent_reverse_365i = (firstrun_reverse_365(i) + secondrun_reverse_365(i) + thirdrun_reverse_365(i)) / 3;
%     current_reverse_standard_dev_365(i) = std([firstrun365(i); secondrun365(i); thirdrun365(i)]);
%     averagecurrent_reverse_365(i) = averagecurrent_reverse_365i;
% end
% voltagetouse_reverse_365 = reverse_voltage_V365(1:41);
% voltagetouse_reverse_365 = -voltagetouse_reverse_365;
% 
% % Uncertainty in Voltage
% voltage_unc_reverse_365 = 0.001*ones(size(voltagetouse_reverse_365));
% 
% % Uncertainty in Current
% current_reverse_standard_error_365 = current_reverse_standard_dev_365/ sqrt(3);
% 
% % Plot a figure with both data sets on one graph
% figure
% errorbar(voltagetouse365, averagecurrent365',current_standard_error_365,current_standard_error_365,voltage_unc_365,voltage_unc_365);
% hold on;
% errorbar(voltagetouse_reverse_365, averagecurrent_reverse_365,current_reverse_standard_error_365,current_reverse_standard_error_365,voltage_unc_reverse_365,voltage_unc_reverse_365)
% plot(voltagetouse365, averagecurrent365');
% plot(voltagetouse_reverse_365, averagecurrent_reverse_365);
% grid on;
% title("Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the forward bias
% figure
% errorbar(voltagetouse365, averagecurrent365',current_standard_error_365,current_standard_error_365,voltage_unc_365,voltage_unc_365);
% title("Forward Bias Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Plot just the reverse bias 
% figure
% errorbar(voltagetouse_reverse_365, averagecurrent_reverse_365,current_reverse_standard_error_365,current_reverse_standard_error_365,voltage_unc_reverse_365,voltage_unc_reverse_365)
% title("Reverse Bias Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% 
% % Find knee using plateau uncertaities and deviation from that value
% 
% % Calculate aveage data point
% running_total_365 = 0;
% h365 = averagecurrent_reverse_365(35:40);
% for i = 1:6;
%     running_total_365 = h365(i) + running_total_365;
% end
% average_threshold_point_365 = running_total_365 / 6;
% 
% % Calculate average error bar size
% running_total_365 = 0;
% g365 = current_reverse_standard_error_365(35:40);
% for i = 1:6;
%     running_total_365 = g365(i)^2 + running_total_365;
% end
% uncertainty_mean_365 = sqrt(running_total_365)/6;
% 
% % Calculate standard deviation
% standard_dev_365 = std(current_reverse_standard_error_365(35:40));
% 
% % Calculate threshold bar
% threshold_bar_365 = sqrt(uncertainty_mean_365^2 + standard_dev_365^2);
% 
% % Calculate threshold
% threshold_365 = threshold_bar_365 + average_threshold_point_365;
% 
% % Plot the threshold line
% figure
% errorbar(voltagetouse_reverse_365, averagecurrent_reverse_365,current_reverse_standard_error_365,current_reverse_standard_error_365,voltage_unc_reverse_365,voltage_unc_reverse_365)
% title("Threshold Value for Reverse Bias Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% x = [-2 : 0.5 : 0];
% Z = threshold_365 * ones(1, length(x));
% plot(x, Z)
% grid on;
% 
% % Find knee using intersection of flat slopes
% 
% % Calculating slope of top line
% k365 = averagecurrent_reverse_365(5:21);
% j365 = voltagetouse_reverse_365(5:21);
% 
% % Plot intersection of lines
% figure
% errorbar(voltagetouse_reverse_365, averagecurrent_reverse_365,current_reverse_standard_error_365,current_reverse_standard_error_365,voltage_unc_reverse_365,voltage_unc_reverse_365)
% title("Slope Intersection for Reverse Bias Current vs. Voltage (365nm Filter)")
% xlabel('Voltage (V)') 
% ylabel('Current (A)')
% hold on;
% 
% % Plot top line
% c_365 = polyfit(j365,k365',1);
% xFit_365 = linspace(-2, 0, 100);
% yFit_365 = polyval(c_365, xFit_365);
% hold on;
% plot(xFit_365, yFit_365);
% grid on;
% 
% % Plot bottom line
% x = [-2 : 0.5 : 0];
% % Use already calculated value for average_threshold_point to get bottom
% % line
% Z_365 = average_threshold_point_365 * ones(1, length(x));
% plot(x, Z_365)
% grid on;
% 






%%%%% Stopping voltage vs. frequency analysis

two_line_stop_V = [0.47, 0.50, 0.85, 1.08, 1.26];
one_line_stop_V = [0.5, 0.5, 0.9, 1.1, 1.35];
voltage_unc = [.05, .05, .05, .05, .05]
average_voltage_unc = [.035, .035, .035, .035, .035]
frequency_unc = [0, 0, 0, 0, 0]


% Average values from both methods
avg_stop_V = [0.485, 0.50, 0.875, 1.09, 1.305];
avg_stop_V_top_big_bottom_small = [0.535, 1.255];
avg_stop_V_bottom_big_top_small = [0.435, 1.355];

frequency = [5.20*10^14, 5.49*10^14, 6.88*10^14, 7.41*10^14, 8.22*10^14];
frequency_extremes = [5.20*10^14, 8.22*10^14];

figure
errorbar(frequency, avg_stop_V, average_voltage_unc, average_voltage_unc, frequency_unc, frequency_unc, 'o')
grid on;
hold on;
fit1 = polyfit(frequency,avg_stop_V,1);
yFit1 = polyval(fit1, frequency);
plot(frequency,yFit1)
title("Averaged Stopping Voltage vs. Light Frequency")
xlabel("Light Frequency (Hz)")
ylabel("Stopping Voltage (V)")
legend('Average Data', 'Fit of Average Data')



figure
errorbar(frequency, avg_stop_V, voltage_unc, voltage_unc, frequency_unc, frequency_unc, 'o')
grid on;
hold on;
fit1 = polyfit(frequency,avg_stop_V,1);
yFit1 = polyval(fit1, frequency);
plot(frequency,yFit1)

fit2 = polyfit(frequency_extremes,avg_stop_V_top_big_bottom_small,1);
yFit2 = polyval(fit2, frequency_extremes);
plot(frequency_extremes,yFit2)
fit3 = polyfit(frequency_extremes,avg_stop_V_bottom_big_top_small,1);
yFit3 = polyval(fit3, frequency_extremes);
plot(frequency_extremes,yFit3)

title("Averaged Stopping Voltage vs. Light Frequency with Minimum and Maximum Linear Fits")
xlabel("Light Frequency (Hz)")
ylabel("Stopping Voltage (V)")
legend('Average Data', 'Fit of Average Data', 'Smallest Work Function Fit', 'Largest Work Function Fit')
avg_work_func = -fit1(2)
avg_slope = fit1(1)
large_work_func = -fit3(2)
small_slope = fit3(1)
small_work_func = -fit2(2)
large_slope = fit2(1)
hold off;

figure
errorbar(frequency, two_line_stop_V, average_voltage_unc, average_voltage_unc, frequency_unc, frequency_unc, 'ro')
grid on;
hold on;
fit1 = polyfit(frequency,two_line_stop_V,1);
xFit = linspace(0, 8.5e14, 100);
yFit1 = polyval(fit1, frequency);
plot(frequency,yFit1,'r')
xlabel("Light Frequency (Hz)")
ylabel("Stopping Voltage (V)")
errorbar(frequency, one_line_stop_V, voltage_unc, voltage_unc, frequency_unc, frequency_unc, 'b*')
hold on;
fit2 = polyfit(frequency,one_line_stop_V,1);
xFit2 = linspace(0, 8.5e14, 100);
yFit2 = polyval(fit2, frequency);
plot(frequency,yFit2,'b')
title("Stopping Voltage vs. Light Frequency with Both Methods")
legend('Intersection Method Data','Intersection Method Fit','Threashold Method Data','Threashold Method Fit')
grid on;


% Plot a figure with both data sets on one graph for forward bias
figure
errorbar(voltagetouse405, averagecurrent405',current_standard_error_405,current_standard_error_405,voltage_unc_405,voltage_unc_405);
hold on;
plot(voltagetouse405, averagecurrent405');
errorbar(voltagetouse365, averagecurrent365',current_standard_error_365,current_standard_error_365,voltage_unc_365,voltage_unc_365);
hold on;
plot(voltagetouse405, averagecurrent365');
errorbar(voltagetouse436, averagecurrent436',current_standard_error_436,current_standard_error_436,voltage_unc_436,voltage_unc_436);
hold on;
plot(voltagetouse405, averagecurrent436');
errorbar(voltagetouse546, averagecurrent546',current_standard_error_546,current_standard_error_546,voltage_unc_546,voltage_unc_546);
hold on;
plot(voltagetouse405, averagecurrent546');
errorbar(voltagetouse577, averagecurrent577',current_standard_error_577,current_standard_error_577,voltage_unc_577,voltage_unc_577);
hold on;
plot(voltagetouse405, averagecurrent577');
grid on;
title("Current vs. Voltage Forward Bias (All Filters)")
xlabel('Voltage (V)') 
ylabel('Current (A)')


%Plot a figure with both data sets on one graph for reverse bias
figure
errorbar(voltagetouse_reverse_405, averagecurrent_reverse_405,current_reverse_standard_error_405,current_reverse_standard_error_405,voltage_unc_reverse_405,voltage_unc_reverse_405)
hold on;
plot(voltagetouse_reverse_405, averagecurrent_reverse_405);
errorbar(voltagetouse_reverse_365, averagecurrent_reverse_365,current_reverse_standard_error_365,current_reverse_standard_error_365,voltage_unc_reverse_365,voltage_unc_reverse_365)
plot(voltagetouse_reverse_365, averagecurrent_reverse_365);
errorbar(voltagetouse_reverse_436, averagecurrent_reverse_436,current_reverse_standard_error_436,current_reverse_standard_error_436,voltage_unc_reverse_436,voltage_unc_reverse_436)
plot(voltagetouse_reverse_436, averagecurrent_reverse_436);
errorbar(voltagetouse_reverse_546, averagecurrent_reverse_546,current_reverse_standard_error_546,current_reverse_standard_error_546,voltage_unc_reverse_546,voltage_unc_reverse_546)
plot(voltagetouse_reverse_546, averagecurrent_reverse_546);
errorbar(voltagetouse_reverse_577, averagecurrent_reverse_577,current_reverse_standard_error_577,current_reverse_standard_error_577,voltage_unc_reverse_577,voltage_unc_reverse_577)
plot(voltagetouse_reverse_577, averagecurrent_reverse_577);
title("Current vs. Voltage Reverse Bias (All Filters)")
xlabel('Voltage (V)') 
ylabel('Current (A)')
grid on;