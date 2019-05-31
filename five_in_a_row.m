%% User input values
clearvars
nMarkers    = 50;      %% number of markers you want to throw
heightSize  = 7;       %% number of rows in game
widthSize   = 8;       %% number of columns in game
markerSize  = 1000;    
inRowWinner = 3;       %% no.'s of consecutive that decides winner
red         = 0;       
blue        = 1;
%% Create Random Game
markerThrow  = repmat(1:widthSize,1,heightSize)';   %% sequential throw of markers in each column
[~,d]        = sort(randi(3*heightSize*widthSize,[heightSize*widthSize 1]));         %% create random shuffle instead of sequential throw
markerThrow  = markerThrow(d(1:nMarkers));                        %% sort original sequential throwing

gameMatrix = arrayfun(@(x) rem(find(markerThrow'==x),2),1:widthSize,'UniformOutput',0); %find all markers of same column(width) and see if its odd or even -->for even = 1 = blue and odd = 0 = red 
gameMatrix = cell2mat(cellfun(@(x) [x';nan(heightSize-length(x),1)],gameMatrix,'UniformOutput',0)); %%convert to matrix of size = height and width by adding Nan's to columns having empty space at top

%% Plot game
[rowRed ,colRed ] = find(gameMatrix == red);
[rowBlue,colBlue] = find(gameMatrix == blue);

scatter(colRed,rowRed,'Sizedata',markerSize,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0]);
hold on;
scatter(colBlue,rowBlue,'Sizedata',markerSize,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1]);
hold on;
xlim([-1 widthSize+1])
ylim([-1 heightSize+1])

%% #inRow formation check
rowCheckLimit = heightSize + 1 - inRowWinner;
colCheckLimit = widthSize + 1 - inRowWinner;

% checkFormation = @(fill) ~isempty(find(diff([0 find(diff(fill)) length(fill)])>=inRowWinner, 1));    %%function to check consecutive same number and give result if inRowWinner found
checkFormation = @(fill) (diff([0 find(diff(fill)) length(fill)]));                                    %%function to check consecutive same number and give output of count

%horizontal check
horizontalIndex = arrayfun(@(y) arrayfun(@(x)  [y,x]  ,1:widthSize,'UniformOutput',0  ),1:heightSize,'UniformOutput',0);
horizontalCheck = cellfun(@(x)  checkFormation(cellfun(@(z) gameMatrix(z(1),z(2)) ,x))  ,horizontalIndex,'UniformOutput',0);

%Vertical check
verticalIndex = arrayfun(@(x) arrayfun(@(y)  [y,x]  ,1:heightSize,'UniformOutput',0  ),1:widthSize,'UniformOutput',0);
verticalCheck = cellfun(@(x) checkFormation(cellfun(@(z) gameMatrix(z(1),z(2)) ,x)),verticalIndex,'UniformOutput',0);

%%right diagnol check
rightDiagnolIndex = arrayfun(@(y,x) arrayfun(@(X,Y) [Y,X],x:x+min(heightSize-y+1,widthSize-x+1)-1,y:y+min(heightSize-y+1,widthSize-x+1)-1,'UniformOutput',0),[rowCheckLimit:-1:1 ones(1,colCheckLimit-1)],[ones(1,rowCheckLimit-1) 1:colCheckLimit],'UniformOutput',0);                                   
rightDiagnolCheck = cellfun(@(x) checkFormation(cellfun(@(z) gameMatrix(z(1),z(2)) ,x)),rightDiagnolIndex,'UniformOutput',0);

%%left diagnol array and check
leftDiagnolIndex = arrayfun(@(y,x) arrayfun(@(X,Y) [Y,X],x:-1:x-min(heightSize-y+1,x)+1,y:y+min(heightSize-y+1,x)-1,'UniformOutput',0),[rowCheckLimit:-1:1 ones(1,widthSize - inRowWinner)],[widthSize*ones(1,rowCheckLimit-1) widthSize:-1:inRowWinner],'UniformOutput',0);
leftDiagnolCheck = cellfun(@(x) checkFormation(cellfun(@(z) gameMatrix(z(1),z(2)) ,x)),leftDiagnolIndex,'UniformOutput',0);

%% Plot winner 
startEndIndex = @(array) [[1 cumsum(array(1:end-1))+1 ]  ;cumsum(array)] ;  %%function that gives start and end index's of consecutive values .for eg for [3 2 3] -> startindex is [1 4 6] and end index is [3 5 8]
linePlot = @(array) plot(array(:,2),array(:,1),'Color',[0 0 0] ,'LineWidth',3);
endValue = @(array) array(end);
findNth  = @(array,n) endValue(find(array,n,'first'));

if sum(cell2mat(verticalCheck)>=inRowWinner)>0  %%winner in vertical check 
   winVerticalCheck         = cellfun(@(x) (find(x>=inRowWinner)),verticalCheck,'UniformOutput',0);   %% find number of winner sets in each cell
   winVerticalIndex         = cellfun(@(x) ~isempty(x),winVerticalCheck) ;   %%index of all winner cells
   winVerticalstartEndIndex = cellfun(@(x) startEndIndex(x),verticalCheck(winVerticalIndex) ,'UniformOutput',0);   %% get the start and end index of all consecutive same member in winner array set
   cellfun(@(check,gameIndex,SEindex)   arrayfun(@(x) linePlot( [gameIndex{ SEindex(1,findNth(check>=inRowWinner,x))}; gameIndex{ SEindex(2,findNth(check>=inRowWinner,x))}]) ,1:length(find(check>=inRowWinner)))  , verticalCheck(winVerticalIndex) , verticalIndex(winVerticalIndex), winVerticalstartEndIndex  ,'UniformOutput',0);
end

if sum(cell2mat(horizontalCheck)>=inRowWinner)>0  %%winner in horizontal check 
   winhorizontalCheck         = cellfun(@(x) (find(x>=inRowWinner)),horizontalCheck,'UniformOutput',0);   %% find number of winner sets in each cell
   winhorizontalIndex         = cellfun(@(x) ~isempty(x),winhorizontalCheck) ;   %%index of all winner cells
   winhorizontalstartEndIndex = cellfun(@(x) startEndIndex(x),horizontalCheck(winhorizontalIndex) ,'UniformOutput',0);   %% get the start and end index of all consecutive same member in winner array set
   cellfun(@(check,gameIndex,SEindex)   arrayfun(@(x) linePlot( [gameIndex{ SEindex(1,findNth(check>=inRowWinner,x))}; gameIndex{ SEindex(2,findNth(check>=inRowWinner,x))}]) ,1:length(find(check>=inRowWinner)))  , horizontalCheck(winhorizontalIndex) , horizontalIndex(winhorizontalIndex), winhorizontalstartEndIndex  ,'UniformOutput',0);
end

if sum(cell2mat(rightDiagnolCheck)>=inRowWinner)>0  %%winner in rightDiagnol check 
   winrightDiagnolCheck         = cellfun(@(x) (find(x>=inRowWinner)),rightDiagnolCheck,'UniformOutput',0);   %% find number of winner sets in each cell
   winrightDiagnolIndex         = cellfun(@(x) ~isempty(x),winrightDiagnolCheck) ;   %%index of all winner cells
   winrightDiagnolstartEndIndex = cellfun(@(x) startEndIndex(x),rightDiagnolCheck(winrightDiagnolIndex) ,'UniformOutput',0);   %% get the start and end index of all consecutive same member in winner array set
   cellfun(@(check,gameIndex,SEindex)   arrayfun(@(x) linePlot( [gameIndex{ SEindex(1,findNth(check>=inRowWinner,x))}; gameIndex{ SEindex(2,findNth(check>=inRowWinner,x))}]) ,1:length(find(check>=inRowWinner)))  , rightDiagnolCheck(winrightDiagnolIndex) , rightDiagnolIndex(winrightDiagnolIndex), winrightDiagnolstartEndIndex  ,'UniformOutput',0);
end

if sum(cell2mat(leftDiagnolCheck)>=inRowWinner)>0  %%winner in leftDiagnol check 
   winleftDiagnolCheck         = cellfun(@(x) (find(x>=inRowWinner)),leftDiagnolCheck,'UniformOutput',0);   %% find number of winner sets in each cell
   winleftDiagnolIndex         = cellfun(@(x) ~isempty(x),winleftDiagnolCheck) ;   %%index of all winner cells
   winleftDiagnolstartEndIndex = cellfun(@(x) startEndIndex(x),leftDiagnolCheck(winleftDiagnolIndex) ,'UniformOutput',0);   %% get the start and end index of all consecutive same member in winner array set
   cellfun(@(check,gameIndex,SEindex)   arrayfun(@(x) linePlot( [gameIndex{ SEindex(1,findNth(check>=inRowWinner,x))}; gameIndex{ SEindex(2,findNth(check>=inRowWinner,x))}]) ,1:length(find(check>=inRowWinner)))  , leftDiagnolCheck(winleftDiagnolIndex) , leftDiagnolIndex(winleftDiagnolIndex), winleftDiagnolstartEndIndex  ,'UniformOutput',0);
end

