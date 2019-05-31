clearvars
nMarkers    = 41;
heightSize  = 6;
widthSize   = 7;
markerSize  = 1000;
inRowWinner = 4;
red         = 0;
blue        = 1;
%% Create Random Game
markerThrow  = repmat(1:widthSize,1,heightSize)';   %% sequential throw of markers in each column
[~,d]        = sort(randi(3*heightSize*widthSize,[heightSize*widthSize 1]));         %% create random shuffle instead of sequential throw
markerThrow  = markerThrow(d(1:nMarkers));                        %% sort original sequential throwing

gameMatrix = arrayfun(@(x) rem(find(markerThrow'==x),2),1:widthSize,'UniformOutput',0); % 10 = red 20 = Blue
gameMatrix = cell2mat(cellfun(@(x) [x';nan(heightSize-length(x),1)],gameMatrix,'UniformOutput',0)); %%convert to matrix of size = height and width by adding Nan's to columns having empty space at top

%% Plot game
[rowRed ,colRed ] = find(gameMatrix == red);
[rowBlue,colBlue] = find(gameMatrix == blue);

% scatter(colRed,rowRed,'Sizedata',markerSize,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0]);
% hold on;
% scatter(colBlue,rowBlue,'Sizedata',markerSize,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1]);

%% #inRow formation check
rowCheckLimit = heightSize + 1 - inRowWinner;
colCheckLimit = widthSize + 1 - inRowWinner;

% checkFormation = @(fill) ~isempty(find(diff([0 find(diff(fill)) length(fill)])>=inRowWinner, 1));    %%function to check consecutive same number and give result if inRowWinner found
checkFormation = @(fill) (diff([0 find(diff(fill)) length(fill)]));                                    %%function to check consecutive same number and give output of count

%horizontal check
horizontalIndex = arrayfun(@(y) arrayfun(@(x)  [y,x]  ,1:widthSize,'UniformOutput',0  ),1:heightSize,'UniformOutput',0);
% horizontalArray = arrayfun(@(x) gameMatrix(x,:),1:heightSize,'UniformOutput',0);
horizontalCheck = cellfun(@(x) checkFormation(x),horizontalArray,'UniformOutput',0);

%Vertical check
verticalIndex = arrayfun(@(x) arrayfun(@(y)  [y,x]  ,1:heightSize,'UniformOutput',0  ),1:widthSize,'UniformOutput',0);
% verticalArray = arrayfun(@(x) gameMatrix(:,x)',1:widthSize,'UniformOutput',0);
verticalCheck = cellfun(@(x) checkFormation(x),verticalArray,'UniformOutput',0);

%%right diagnol check
rightDiagnolIndex = arrayfun(@(y,x) arrayfun(@(X,Y) [Y,X],x:x+min(heightSize-y+1,widthSize-x+1)-1,y:y+min(heightSize-y+1,widthSize-x+1)-1,'UniformOutput',0),[rowCheckLimit:-1:1 ones(1,colCheckLimit-1)],[ones(1,rowCheckLimit-1) 1:colCheckLimit],'UniformOutput',0);                                   
% rightDiagnolArray = arrayfun(@(y,x) arrayfun(@(X,Y) gameMatrix(Y,X),x:x+min(heightSize-y+1,widthSize-x+1)-1,y:y+min(heightSize-y+1,widthSize-x+1)-1),[rowCheckLimit:-1:1 ones(1,colCheckLimit-1)],[ones(1,rowCheckLimit-1) 1:colCheckLimit],'UniformOutput',0);                                   
rightDiagnolCheck = cellfun(@(x) checkFormation(x),rightDiagnolArray,'UniformOutput',0);

%%left diagnol array and check
leftDiagnolIndex = arrayfun(@(y,x) arrayfun(@(X,Y) [Y,X],x:-1:x-min(heightSize-y+1,x)+1,y:y+min(heightSize-y+1,x)-1,'UniformOutput',0),[rowCheckLimit:-1:1 ones(1,widthSize - inRowWinner)],[widthSize*ones(1,rowCheckLimit-1) widthSize:-1:inRowWinner],'UniformOutput',0);
% leftDiagnolArray = arrayfun(@(y,x) arrayfun(@(X,Y) gameMatrix(Y,X),x:-1:x-min(heightSize-y+1,x)+1,y:y+min(heightSize-y+1,x)-1),[rowCheckLimit:-1:1 ones(1,widthSize - inRowWinner)],[widthSize*ones(1,rowCheckLimit-1) widthSize:-1:inRowWinner],'UniformOutput',0);
leftDiagnolCheck = cellfun(@(x) checkFormation(x),leftDiagnolArray,'UniformOutput',0);

%% Plot winner 

if sum(cell2mat(verticalCheck)>=inRowWinner)>0  %%winner in vertical check 
%    cellfun(@(x) )
    
end
