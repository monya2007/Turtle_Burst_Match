function numTurtle=oneGame(turtle_pool,colorNum,luckyColor,dispMark)

% ----------------------------
% 第一次抽取9个
% grid=[1 1 1 3 1 3 4 2 1];
% grid=[1 1 1 3 1 3 4 4 1];
grid=randi([1, colorNum], 1, 9);
turtle_pool=turtle_pool-9;
numTurtle=0;

drawGrid_game(dispMark, grid,'',turtle_pool,numTurtle,luckyColor);



countRound=0; % 循环计数


% if turtle_pool
while turtle_pool>0 
    % -------------------------------------
    % 判断幸运色/三连/对碰/清台，更新乌龟池/乌龟框的数量，以及grid的状态
    [grid,turtle_pool,numTurtle]=addNum(dispMark, grid,luckyColor,turtle_pool,numTurtle);

    % -------------------------------------
    % 将空位补齐小乌龟
    indices = find(grid == 0);
    numEmpty=length(indices);
    if numEmpty<turtle_pool
        stringT=['拆包-' num2str( numEmpty )];
        drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);
        grid(indices)=randi([1, 7], 1, numEmpty); % 补齐空位处的0
        turtle_pool=turtle_pool-numEmpty;

    else
        stringT=['拆包-' num2str(turtle_pool)];
        drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);
        grid(indices(1:turtle_pool))=randi([1, 7], 1, turtle_pool);
        turtle_pool=0;
        drawGrid_game(dispMark, grid,'',turtle_pool,numTurtle,luckyColor);

        [grid,turtle_pool,numTurtle]=addNum(dispMark, grid,luckyColor,turtle_pool,numTurtle);

    end

    countRound=countRound+1;

    drawGrid_game(dispMark, grid,'',turtle_pool,numTurtle,luckyColor);

end

numTurtle=numTurtle+length(find(grid~=0)); % 最终grid里剩几只乌龟，拿进乌龟筐
grid=zeros(1,9);
drawGrid_game(dispMark, grid,'end',turtle_pool,numTurtle);

end


%% ===============================================================================
function [grid,turtle_pool,numTurtle]=addNum(dispMark, grid,luckyColor,turtle_pool,numTurtle)
% 计算幸运色/三连/成对后的乌龟池增加的乌龟数量，以及grid的状态，拿掉的位置加0

threeLineIndex=[1 2 3; 4 5 6; 7 8 9; 1 4 7; 2 5 8; 3 6 9; 1 5 9; 3 5 7]; %三连在的位置
% dispMark=1;
% gridFirst=grid;

% --------------------------------------------------------------
% 9个不一样颜色
if length(unique(grid))==9
    turtle_pool=turtle_pool+5;
    % show grid
    stringT='全部不同色+5';
    drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor)
end

% --------------------------------------------------------------
% 幸运色
luckyIdx=find(grid == luckyColor);
turtle_pool=turtle_pool+length( luckyIdx );
% show grid
if ~isempty(luckyIdx)
    stringT=['幸运色+' num2str(length( luckyIdx ))];
    drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor)
end


% --------------------------------------------------------------
% 三连的情况
% 使用 unique 函数找到数列中的唯一值
[unique_values, ~, idx] = unique(grid);
% 使用 histc 函数（或 histcounts 函数）计算每个唯一值的出现次数
counts = histc(idx, 1:numel(unique_values));


zeroIdx3=[]; % 三连的位置索引
if max(counts)>=3
    % 查找大于等于3的元素的索引
    indices = (counts >= 3);
    color3=unique_values(indices); % 找出哪个数字有大于3个

    for iN=color3
        if iN>0
            idx=find(grid==iN); % 大于3个的数字索引
            for iG=1:size(threeLineIndex,1) % 判断这3个数字是否是三连（三连有8中情况，每种都判断一下）
                A=threeLineIndex(iG,:);
                if all(ismember(A, idx)) % 如果A是idx的子集，则三连，加5只小乌龟
                    turtle_pool=turtle_pool+5;
                    zeroIdx3=union(zeroIdx3,A);

                    % show grid
                    stringT='三连+5';
                    drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor)


                end
            end
            grid(zeroIdx3)=0; % 三连处的数字置为0
            numTurtle=numTurtle+length(zeroIdx3); % 拆开了几包小乌龟

            % show grid
            stringT='';
            drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor)

        end
    end
end


% --------------------------------------------------------------
% 对碰
% 使用 unique 函数找到数列中的唯一值
[unique_values, ~, idx] = unique(grid);
% 使用 histc 函数（或 histcounts 函数）计算每个唯一值的出现次数
counts = histc(idx, 1:numel(unique_values));


indices = find(counts >= 2);
color2=unique_values(indices); % 找出哪个数字有大于2个

zeroIdx2=[];
for iN=color2
    if iN>0
        idx=find(grid==iN); % 大于3个的数字索引

        if mod(length(idx), 2) == 0 %偶数
            turtle_pool=turtle_pool+length(idx)/2;
            grid(idx)=0;
            zeroIdx2=[zeroIdx2,idx];
            numTurtle=numTurtle+length(idx); % 拆开了几包小乌龟
            % show grid
            stringT=['对碰+' num2str(length(idx)/2)];
            drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);



        else  % 奇数
            turtle_pool=turtle_pool+floor(length(idx)/2);
            grid(idx(1:end-1))=0;
            zeroIdx2=[zeroIdx2,idx(1:end-1)];
            numTurtle=numTurtle+length(idx)-1; % 拆开了几包小乌龟
            % show grid
            stringT=['对碰+' num2str(floor(length(idx)/2))];
            drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);
        end
    end
end

% --------------------------------------------------------------
% 收走幸运色
grid(luckyIdx)=0;
luckyIdx2=setdiff(luckyIdx,union(zeroIdx3,zeroIdx2));
numTurtle=numTurtle+length(luckyIdx2);
% show grid
if ~isempty(luckyIdx2)
    stringT='收走幸运色';
    drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);
end

% --------------------------------------------------------------
% 清台
if length(find(grid==0))==9  && turtle_pool>0
    turtle_pool=turtle_pool+5;
    % show grid
    stringT='清台+5';
    drawGrid_game(dispMark, grid,stringT,turtle_pool,numTurtle,luckyColor);

end


end