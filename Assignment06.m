% lecture08 given code

clear all; close all; clc;

Igray = imread('training.jpg');

BW = ~im2bw(Igray);

SE = strel('disk',2);
BW2 = imdilate(BW, SE);

labels = bwlabel(BW2);
Iprops = regionprops(labels);

Iprops( [Iprops.Area] < 1000 ) = [];
num = length( Iprops );

Ibox = floor( [Iprops.BoundingBox] );
Ibox = reshape(Ibox,[4 num]);


% imshow(Igray,'border','tight');
%
% hold on;
% for k = 1:num
%     rectangle('position',Ibox(:,k),'edgecolor','g','LineWidth',1);
%
%     col = Ibox(1,k);
%     row = Ibox(2,k);
%
%     text(col,row-50,sprintf('%2.2d',k), ...
%         'fontsize',16,'color','r','fontweight','bold');
% end
%
%
%
% break;

for k = 1:num
    col1 = Ibox(1,k);
    col2 = Ibox(1,k) + Ibox(3,k);
    row1 = Ibox(2,k);
    row2 = Ibox(2,k) + Ibox(4,k);
    subImage = BW2(row1:row2, col1:col2);
    
    subImageScaled = imresize(subImage, [24 12]);
    
    TPattern(k,:) = subImageScaled(:)';
end

%TTarget = eye(10)';

TTarget = zeros(100,10);

for row = 1:10
    for col = 1:10
        TTarget( 10*(row-1) + col, row ) = 1;
    end
end


TPattern = TPattern';
TTarget = TTarget';


mynet = newff([zeros(288,1) ones(288,1)], [24 10], {'logsig' 'logsig'}, 'traingdx');
mynet.trainParam.epochs = 500;
mynet = train(mynet,TPattern,TTarget);


% mynet = feedforwardnet(24,'traingdx');
% mynet.trainParam.epochs = 500;
% mynet = train(mynet,TPattern,TTarget)

%Read in Image 196128
Igray = imread('196128.jpg');

BW = ~im2bw(Igray);

SE = strel('disk',2);
BW2 = imdilate(BW, SE);

labels = bwlabel(BW2);
Iprops = regionprops(labels);

Iprops( [Iprops.Area] < 1000 ) = [];
num = length( Iprops );

Ibox = floor( [Iprops.BoundingBox] );
Ibox = reshape(Ibox,[4 num]);

correctDigits = 0;
incorrectDigits = 0;
correctDigitsArray = [];
incorrectDigitsArray = [];
correctDigits2 = 0;
incorrectDigits2 = 0;
correctDigits3 = 0;
incorrectDigits3 = 0;
correctDigits4 = 0;
incorrectDigits4 = 0;

%Finding the number of correct and incorrect digits
unknown1 = {1 9 6 1 2 8};
unknown2 = {4 8 0 0 0 0};
unknown3 = {4 8 0 0 9 6};
unknown4 = {6 0 3 0 3 2};


for k = 1:num
    col1 = Ibox(1,k);
    col2 = Ibox(1,k) + Ibox(3,k);
    row1 = Ibox(2,k);
    row2 = Ibox(2,k) + Ibox(4,k);
    
    subImage = BW2(row1:row2, col1:col2);
    subImageScaled = imresize(subImage, [24 12]);
    UPattern(k,:) = subImageScaled(:)';
end

UPattern = UPattern';


for k = 1:20
Y = sim(mynet, UPattern);
[value, index] = max(Y);

postcode = index-1;
for k = 1:6
    if (unknown1{k} == postcode(k))
        correctDigits = correctDigits +1;
        
    else
        incorrectDigits = incorrectDigits +1;
    end
    correctDigitsArray{1} = correctDigits;
    incorrectDigitsArray{1} = incorrectDigits;
end
end



%Read in Image 480000
Igray = imread('480000.jpg');

BW = ~im2bw(Igray);

SE = strel('disk',2);
BW2 = imdilate(BW, SE);

labels = bwlabel(BW2);
Iprops = regionprops(labels);

Iprops( [Iprops.Area] < 1000 ) = [];
num = length( Iprops );

Ibox = floor( [Iprops.BoundingBox] );
Ibox = reshape(Ibox,[4 num]);


for k = 1:num
    col1 = Ibox(1,k);
    col2 = Ibox(1,k) + Ibox(3,k);
    row1 = Ibox(2,k);
    row2 = Ibox(2,k) + Ibox(4,k);
    
    subImage2 = BW2(row1:row2, col1:col2);
    subImageScaled2 = imresize(subImage2, [24 12]);
    UPattern2(k,:) = subImageScaled2(:)';
end

UPattern2 = UPattern2';

for k = 1:20
Y2 = sim(mynet, UPattern2);
[value2, index2] = max(Y2);

postcode2 = index2-1;

%disp(postcode2);
for k = 1:6
    if (unknown2{k} == postcode2(k))
        correctDigits2 = correctDigits2 +1;
        
    else
        incorrectDigits2 = incorrectDigits2 +1;
    end
    correctDigitsArray{2} = correctDigits2;
    incorrectDigitsArray{2} = incorrectDigits2;
end
end


%Read in Image 480096
Igray = imread('480096.jpg');

BW = ~im2bw(Igray);

SE = strel('disk',2);
BW2 = imdilate(BW, SE);

labels = bwlabel(BW2);
Iprops = regionprops(labels);

Iprops( [Iprops.Area] < 1000 ) = [];
num = length( Iprops );

Ibox = floor( [Iprops.BoundingBox] );
Ibox = reshape(Ibox,[4 num]);


for k = 1:num
    col1 = Ibox(1,k);
    col2 = Ibox(1,k) + Ibox(3,k);
    row1 = Ibox(2,k);
    row2 = Ibox(2,k) + Ibox(4,k);
    
    subImage3 = BW2(row1:row2, col1:col2);
    subImageScaled3 = imresize(subImage3, [24 12]);
    UPattern3(k,:) = subImageScaled3(:)';
end

UPattern3 = UPattern3';

for k = 1:20
Y3 = sim(mynet, UPattern3);
[value3, index3] = max(Y3);

postcode3 = index3-1;

%disp(postcode3);


for k = 1:6
    if (unknown3{k} == postcode3(k))
        correctDigits3 = correctDigits3 +1;
        
    else
        incorrectDigits3 = incorrectDigits3 +1;
    end
    correctDigitsArray{3} = correctDigits3;
    incorrectDigitsArray{3} = incorrectDigits3;
end
end


%Read in Image 603032
Igray = imread('603032.jpg');

BW = ~im2bw(Igray);

SE = strel('disk',2);
BW2 = imdilate(BW, SE);

labels = bwlabel(BW2);
Iprops = regionprops(labels);

Iprops( [Iprops.Area] < 1000 ) = [];
num = length( Iprops );

Ibox = floor( [Iprops.BoundingBox] );
Ibox = reshape(Ibox,[4 num]);


for k = 1:num
    col1 = Ibox(1,k);
    col2 = Ibox(1,k) + Ibox(3,k);
    row1 = Ibox(2,k);
    row2 = Ibox(2,k) + Ibox(4,k);
    
    subImage4 = BW2(row1:row2, col1:col2);
    subImageScaled4 = imresize(subImage4, [24 12]);
    UPattern4(k,:) = subImageScaled4(:)';
end

UPattern4 = UPattern4';

for k = 1:20
Y4 = sim(mynet, UPattern4);
[value4, index4] = max(Y4);

postcode4 = index4-1;

%disp(postcode4);

for k = 1:6
    if (unknown4{k} == postcode4(k))
        correctDigits4 = correctDigits4 +1;
    else
        incorrectDigits4 = incorrectDigits4 +1;
    end
    correctDigitsArray{4} = correctDigits4;
    incorrectDigitsArray{4} = incorrectDigits4;
end
end

incorrectDigitsArray = incorrectDigitsArray .';
correctDigitsArray = correctDigitsArray .';



%Create Table
UnknownImages = {196128; 480000; 480096; 603032};
TotalRuns = {20; 20; 20; 20};
correctPercent = {(correctDigitsArray{1}/120) * 100;...
    (correctDigitsArray{2}/120)*100;...
    (correctDigitsArray{3}/120)*100;...
    (correctDigitsArray{4}/120)*100;}
T = table(UnknownImages, TotalRuns, correctDigitsArray,...
    incorrectDigitsArray, correctPercent)



