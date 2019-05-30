clearvars
nMarkers   = 37;
heightSize    = 6;
widhtSize = 7;
markerSize = 6000;
inRowWinner = 4;
enable = false;

if enable
figure1 = figure;%('WindowState','maximized');
axes1 = axes('Parent',figure1,'Position',[0.13 0.11 0.556979166666667 0.815]);
hold(axes1,'on');xlim(axes1,[0 8]);ylim(axes1,[0 7]);
set(axes1,'XGrid','on','XTick',[0 1 2 3 4 5 6 7 8],'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'YGrid','on','YTick',[0 1 2 3 4 5 6 7],'YTickLabel',{'0','1','2','3','4','5','6','7'});
end

markerThrow  = repmat(1:widhtSize,1,heightSize)';   %% sequential throw of markers in each column
[~,d]        = sort(randi(3*heightSize*widhtSize,[heightSize*widhtSize 1]));         %% create random shuffle instead of sequential throw
markerThrow  = markerThrow(d(1:nMarkers));                        %% sort original sequential throwing
gameMatrix = zeros(heightSize,widhtSize);

fillStatus.Column1=0;fillStatus.Column2=0;fillStatus.Column3=0;fillStatus.Column4=0;fillStatus.Column5=0;fillStatus.Column6=0;fillStatus.Column7=0;
for iMarker = 1:nMarkers
    fillStatus.(['Column',num2str(markerThrow(iMarker,1))]) = fillStatus.(['Column',num2str(markerThrow(iMarker,1))]) + 1 ;
    
    if rem(iMarker,2)~=0    %if even then red
        markerColor = [1 0 0 ];
        gameMatrix(heightSize+1- fillStatus.(['Column',num2str(markerThrow(iMarker,1))]),markerThrow(iMarker,1)) = 10;
    else                    %or if odd then blue
        markerColor = [0 0 1];
        gameMatrix(heightSize+1- fillStatus.(['Column',num2str(markerThrow(iMarker,1))]),markerThrow(iMarker,1)) = 20;
    end
    if enable
    scatter(markerThrow(iMarker,1), fillStatus.(['Column',num2str(markerThrow(iMarker,1))]) ,'Sizedata',markerSize,'MarkerFaceColor',markerColor,'MarkerEdgeColor',markerColor);
    end
end

%% wcheck
sizeGame = [6 7];
% directionMatrix = [reshape(meshgrid(-3:3:3,-3:3:3),[9 1]) reshape(meshgrid(-3:3:3,-3:3:3)',[9 1])];
directionMatrix = [1 0;0 1 ;1 1 ;-1 1];  %% [horizontal vertical]

Game = num2cell(randi([0 1],[6 7]));

indexGameY = flipud(num2cell(repmat((1:sizeGame(1))',[1 sizeGame(2) ])));
indexGameX = num2cell(repmat((1:sizeGame(2)) ,[ sizeGame(1) 1]));

result = cellfun(@(X,Y)  arrayfun(@(dx,dy) Game{X,Y}) ,indexGameX,indexGameY,'UniformOutput',0);
%%
% function Result = directionCheck(value)
% sweep()
% end

% b = [ 1 2 3 ];
% c = [ 2 3 1];
% d = arrayfun(@(x,y) a(x,y),b,c)';
% d = arrayfun(@(x) x*2,directionMatrix);
