clear;clc;close all;

turtle_pool=19; % 初始未拆的乌龟池
colorNum=9; % 乌龟颜色的种类
luckyColor=1; % 幸运乌龟的颜色

% -----------------------
% 是否窗口显示过程：
% 显示dispMark=1;
% 不显示dispMark=0;
dispMark=1;
if dispMark==1
    figure;
    hold on; % 保持当前图形
end


% -----------------------
% 运行游戏
numTurtle=oneGame(turtle_pool,colorNum,luckyColor,dispMark);

