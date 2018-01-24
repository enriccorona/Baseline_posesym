sampleIndex = 1:size(symIdx,1);
sampleIndexSym = symIdx;


Xstart = V(sampleIndex,1);
Ystart = V(sampleIndex,2);
Zstart = V(sampleIndex,3);

Xend = V(sampleIndexSym,1);
Yend = V(sampleIndexSym,2);
Zend = V(sampleIndexSym,3);

valuesX = 0;
valuesY = 0;
valuesZ = 0;

for angle=1:0.1:359
    Rx = [ [1, 0, 0]; [0, cos(angle), -1*sin(angle)]; [0, sin(angle), cos(angle)] ];
    Ry = [ [ cos(angle), 0, sin(angle) ]; [0,1,0]; [-1*sin(angle), 0, cos(angle) ] ];
    Rz = [ [cos(angle), -1*sin(angle), 0]; [sin(angle), cos(angle), 0 ]; [0, 0, 1] ];

    start = [Xstart, Ystart, Zstart];
    ending = [Xend, Yend, Zend];

    convertedX = start*Rx;
    convertedY = start*Ry;
    convertedZ = start*Rz;

    distanceX = sum( (convertedX - ending).^2, 2);
    distanceY = sum( (convertedY - ending).^2, 2);
    distanceZ = sum( (convertedZ - ending).^2, 2);
    
    valuesX = valuesX + sum(distanceX < threshold);
    valuesY = valuesY + sum(distanceY < threshold);
    valuesZ = valuesZ + sum(distanceZ < threshold);
end

orderxinf = valuesX/359/size(distanceX,1) > threshold_symmetryInf;
orderyinf = valuesY/359/size(distanceY,1) > threshold_symmetryInf;
orderzinf = valuesZ/359/size(distanceZ,1) > threshold_symmetryInf;

valuesX = 0;
valuesY = 0;
valuesZ = 0;

for angle=90:90:359
    Rx = [ [1, 0, 0]; [0, cos(angle), -1*sin(angle)]; [0, sin(angle), cos(angle)] ];
    Ry = [ [ cos(angle), 0, sin(angle) ]; [0,1,0]; [-1*sin(angle), 0, cos(angle) ] ];
    Rz = [ [cos(angle), -1*sin(angle), 0]; [sin(angle), cos(angle), 0 ]; [0, 0, 1] ];

    start = [Xstart, Ystart, Zstart];
    ending = [Xend, Yend, Zend];

    convertedX = start*Rx;
    convertedY = start*Ry;
    convertedZ = start*Rz;

    distanceX = sum( (convertedX - ending).^2, 2);
    distanceY = sum( (convertedY - ending).^2, 2);
    distanceZ = sum( (convertedZ - ending).^2, 2);
    
    valuesX = valuesX + sum(distanceX < threshold);
    valuesY = valuesY + sum(distanceY < threshold);
    valuesZ = valuesZ + sum(distanceZ < threshold);
end

orderx4 = valuesX/3/size(distanceX,1) > threshold_symmetry4;
ordery4 = valuesY/3/size(distanceY,1) > threshold_symmetry4;
orderz4 = valuesZ/3/size(distanceZ,1) > threshold_symmetry4;


valuesX = 0;
valuesY = 0;
valuesZ = 0;

angle = 180;
Rx = [ [1, 0, 0]; [0, cos(angle), -1*sin(angle)]; [0, sin(angle), cos(angle)] ];
Ry = [ [ cos(angle), 0, sin(angle) ]; [0,1,0]; [-1*sin(angle), 0, cos(angle) ] ];
Rz = [ [cos(angle), -1*sin(angle), 0]; [sin(angle), cos(angle), 0 ]; [0, 0, 1] ];

start = [Xstart, Ystart, Zstart];
ending = [Xend, Yend, Zend];

convertedX = start*Rx;
convertedY = start*Ry;
convertedZ = start*Rz;

distanceX = sum( (convertedX - ending).^2, 2);
distanceY = sum( (convertedY - ending).^2, 2);
distanceZ = sum( (convertedZ - ending).^2, 2);

valuesX = valuesX + sum(distanceX < threshold);
valuesY = valuesY + sum(distanceY < threshold);
valuesZ = valuesZ + sum(distanceZ < threshold);

orderx2 = valuesX/1/size(distanceX,1) > threshold_symmetry2 ; 
ordery2 = valuesY/1/size(distanceY,1) > threshold_symmetry2 ;
orderz2 = valuesZ/1/size(distanceZ,1) > threshold_symmetry2 ; 

if orderxinf
    orderx = 8; % Inf
elseif orderx4
    orderx = 4;
elseif orderx2
    orderx = 2;
else
    orderx = 1;
end

if orderyinf
    ordery = 8; % Inf
elseif ordery4
    ordery = 4;
elseif ordery2
    ordery = 2;
else
    ordery = 1;
end
if orderzinf
    orderz = 8; % Inf
elseif orderz4
    orderz = 4;
elseif orderz2
    orderz = 2;
else
    orderz = 1;
end
    
new_symmetry = [orderx,ordery,orderz];