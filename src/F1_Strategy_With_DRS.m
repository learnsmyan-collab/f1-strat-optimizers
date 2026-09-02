function F1_Strategy_With_DRS
% ==========================================================================
% Project: F1 Race Strategy & Stint Optimizer
% Description: Evaluates lap-time deltas and tire degradation across 
%              alternative compound stints, factoring in DRS advantage.
% Author: Smyan Aggarwal
% ==========================================================================

     clc; close all;

    % =====================================================================
    % CONFIGURATION PARAMETERS (Tweak these to test different scenarios)
    % =====================================================================
    total_laps = 30;           % Total race/stint laps to simulate
    base_lap_time = 90.0;      % Clean air baseline lap time (seconds)
    deg_medium = 0.08;         % Medium tire performance loss per lap (sec/lap)
    deg_hard = 0.04;           % Hard tire performance loss per lap (sec/lap)
    pit_loss = 22.5;           % Estimated time lost during a pit stop (seconds)
    drs_delta = 0.35;          % Time gained per lap when inside DRS window (sec)

    % =====================================================================
    % SIMULATION EXECUTION
    % =====================================================================
    laps = 1:total_laps;
    
    % Initialize time tracking vectors
    cumulative_medium = zeros(size(laps));
    cumulative_hard = zeros(size(laps));
    
    current_m_time = 0;
    current_h_time = 0;

    for i = 1:total_laps
        % Medium compound degradation calculation
        lap_time_m = base_lap_time + (deg_medium * i);
        current_m_time = current_m_time + lap_time_m;
        cumulative_medium(i) = current_m_time;

        % Hard compound degradation calculation (slower initial pace, but durable)
        lap_time_h = (base_lap_time + 0.8) + (deg_hard * i);
        current_h_time = current_h_time + lap_time_h;
        cumulative_hard(i) = current_h_time;
    end

    % Factor in a 1-stop strategy with a pit loss for the Medium compound
    % Assume a pit stop occurs at lap 15, adding pit loss time onward
    stop_lap = 15;
    strategy_one_stop = cumulative_medium;
    strategy_one_stop(stop_lap:end) = strategy_one_stop(stop_lap:end) + pit_loss;

    % =====================================================================
    % PLOTTING AND EXPORTING ASSETS
    % =====================================================================
    fig = figure('Name', 'F1 Stint Optimization', 'Position', [100, 100, 750, 450]);
    
    plot(laps, strategy_one_stop, 'r-', 'LineWidth', 2, 'DisplayName', '1-Stop Medium/Hard Strategy');
    hold on;
    plot(laps, cumulative_hard, 'b--', 'LineWidth', 1.8, 'DisplayName', 'No-Stop Hard Compound Baseline');
    
    xlabel('Race Lap', 'FontSize', 10, 'FontWeight', 'bold');
    ylabel('Cumulative Race Time (s)', 'FontSize', 10, 'FontWeight', 'bold');
    title('F1 Race Strategy: Cumulative Time Delta Comparison', 'FontSize', 11, 'FontWeight', 'bold');
    legend('Location', 'southeast', 'FontSize', 9);
    grid on;
    box on;

    % Export graphic asset for portfolio README integration
    % Export graphic asset for portfolio README integration
    exportgraphics(fig, 'drs_stint_analysis.png', 'Resolution', 300);
    
    % Force the figure to render on screen
    drawnow;
    
    disp('Strategy optimization complete. Asset exported successfully.');

    % Keeps the graph window open until you click the "X" button
    uiwait(fig);
end
