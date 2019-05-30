clearvars
nMarkers    = 37;
heightSize  = 6;
widthSize   = 7;
markerSize  = 1000;
inRowWinner = 4;
red         = 0;
blue        = 1;

markerThrow  = repmat(1:widthSize,1,heightSize)';   %% sequential throw of markers in each column
[~,d]        = sort(randi(3*heightSize*widthSize,[heightSize*widthSize 1]));         %% create random shuffle instead of sequential throw
markerThrow  = markerThrow(d(1:nMarkers));                        %% sort original sequential throwing

gameMatrix = arrayfun(@(x) rem(find(markerThrow'==x),2),1:widthSize,'UniformOutput',0); % 10 = red 20 = Blue
gameMatrix = cell2mat(cellfun(@(x) [x';nan(heightSize-length(x),1)],gameMatrix,'UniformOutput',0)); %%convert to matrix of size = height and width

%% plot game
[rowRed ,colRed ] = find(gameMatrix == red);
[rowBlue,colBlue] = find(gameMatrix == blue);

scatter(colRed,rowRed,'Sizedata',markerSize,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0]);
hold on;
scatter(colBlue,rowBlue,'Sizedata',markerSize,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1]);


%% wcheck
directionMatrix = [1 0;0 1 ;1 1 ;-1 1];  %% [horizontal vertical]

% checkFormation = @(fill,inRow) find(diff([0 find(diff(fill)) length(fill)])>=inRow);
checkFormation = @(fill) (diff([0 find(diff(fill)) length(fill)]));

%horizontal check
horizontalCheck = arrayfun(@(x) checkFormation(gameMatrix(x,:)),1:heightSize,'UniformOutput',0);
%Vertical check
verticalCheck = arrayfun(@(x) checkFormation(gameMatrix(:,x)'),1:widthSize,'UniformOutput',0);

%%right diagnol check
rowCheckLimit = heightSize + 1 - inRowWinner;
colCheckLimit = widthSize + 1 - inRowWinner;
rightDiagnolCheck = arrayfun(@(y,x) checkFormation(arrayfun(@(X,Y) gameMatrix(Y,X),x:x+min(heightSize-y+1,widthSize-x+1)-1,y:y+min(heightSize-y+1,widthSize-x+1)-1)),[rowCheckLimit:-1:1 ones(1,colCheckLimit-1)],[ones(1,rowCheckLimit-1) 1:colCheckLimit],'UniformOutput',0);                                   

%%left diagnol check
% colCheckLimit = inRowWinner;
leftDiagnolCheck = arrayfun(@(y,x) checkFormation(arrayfun(@(X,Y) gameMatrix(Y,X),x:-1:x-min(heightSize-y+1,x)+1,y:y+min(heightSize-y+1,x)-1)),[rowCheckLimit:-1:1 ones(1,widthSize - inRowWinner)],[widthSize*ones(1,rowCheckLimit-1) widthSize:-1:inRowWinner],'UniformOutput',0);                                    





