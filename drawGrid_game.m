function drawGrid_game(disMark,grid,stringT,turtle_pool,numTurtle,luckyNum)
% 如果disMark=1，则进行下面的画图，否则不绘画，下面程序不运行

% disp(stringT); % 是否在命令窗口显示stringT：幸运色+/对碰+/三连+/拆包-/拿走幸运色
if disMark==1
    disp(stringT);

    colormap=cbrewer('qual', 'Set1', 9);
    cla; % 清空当前figure

    % --------------------------------------------------------------------
    % 绘制九宫格布局，先画一个矩形框，然后再画
    for iRow=1:3
        for iCol = 1:3
            % --------------------
            % 计算子图的位置为[iCol 3-iRow],由于是从上往下画，所以行索引为3-iRow
            % 在相应位置绘制边框
            rectangle('Position', [iCol 3-iRow 1 1], 'EdgeColor', 'k', 'LineWidth', 1);
            % --------------------
            % 在矩形框的中心显示数字
            showNum=grid((iRow-1)*3+iCol); % 需要绘出的数字
            if showNum>0 % 如果时0，则表示这个位置没有，所以不显示
                if showNum==luckyNum
                    % 显示幸运色
                    text(iCol+0.5, 3-iRow + 0.5, '\circ', 'Interpreter', 'tex', ...
                        'FontSize', 50, 'Color', colormap(showNum,:), ...
                        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                else
                    % 显示心形图案
                    text(iCol+0.5, 3-iRow + 0.5, '\heartsuit', 'Interpreter', 'tex', ...
                        'FontSize', 50, 'Color', colormap(showNum,:), ...
                        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

                    % 显示数字
%                     text(iCol+0.5, 3-iRow+0.5, num2str(showNum), ...
%                         'FontSize', 20, 'Color', colormap(showNum,:), ...
%                         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                end
            end
        end
    end



    % --------------------------------------------------------------------
    % number of open 乌龟筐，拆开后收走的乌龟数量
    rectangle('Position', [5 2 1 1], 'EdgeColor', 'k', 'LineWidth', 1);
    text(5+0.5, 3 + 0.15, 'turtle number', 'Interpreter', 'tex', ...
        'FontSize', 10, 'Color', 'black', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    text(5+0.5, 2 + 0.5, num2str(numTurtle), 'Interpreter', 'tex', ...
        'FontSize', 30, 'Color', 'black', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

    % --------------------------------------------------------------------
    % 显示stringT：幸运色+/对碰+/三连+/拆包-/拿走幸运色
    text( 5+1.5/2, 1 , stringT, 'Interpreter', 'tex', ...
        'FontSize', 20, 'Color', 'red', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    % pause(1);
    % --------------------
    % turtle pool 乌龟池
    rectangle('Position',[5 0 1.5 0.75],'Curvature',[0.5,1],'LineStyle','--','EdgeColor', '#0072BD')
    text( 5+1.5/2, 0.75/2 , num2str(turtle_pool), 'Interpreter', 'tex', ...
        'FontSize', 30, 'Color', '#0072BD', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

    % 设置坐标轴范围和比例
    axis equal;
    axis([1 7 0 4]);
    axis off; % 关闭坐标轴刻度

    pause(1); % 间隔时间，这里可以调整
end
end