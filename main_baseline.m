
clear;
clc;
close all;

objects = [ 0:16, 134,2922,135,5481,223,224,2960,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4014,4015,4016,4017,4018,4019,5009,5010,5011];

symmetries = [[1,1,1]; [1,2,1]; [1,1,1]; [1,8,1]; [2,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,8]; [1,1,1]; [1,1,1]; [1,1,1]; [1,1,1];[2,2,2];[1,1,1];[1,8,1];[1,1,1];[1,1,1];[1,8,1]; [2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];[2,2,8];  ; [1,1,8]; [1,1,8]; [1,1,8] ];


inds = [22, 33, 43,  7, 28, 30, 13, 16, 17, 37, 10, 14, 34,  1, 19, 44,  0, 23, 36, 27, 20, 35, 18, 42,  2,  8, 39, 26, 21, 32, 29,  3, 15,  4,  5, 25, 40, 38, 11, 41, 12, 31,  9,  6, 24];

objects = objects(inds + 1 ) ;
symmetries = symmetries(inds + 1 , : ) ;

% TEST:
objects = objects(36:end);
symmetries = symmetries(36:end,:);

recall_den_0 = 0;
precision_num_0 = 0;
precision_den_0 = 0;

recall_den_1 = 0;
precision_num_1 = 0;
precision_den_1 = 0;

recall_den_2 = 0;
precision_num_2 = 0;
precision_den_2 = 0;

recall_den_3 = 0;
precision_num_3 = 0;
precision_den_3 = 0;

recall_den_4 = 0;
precision_num_4 = 0;
precision_den_4 = 0;


threshold = 0.05;
threshold_symmetry2 = 0.015;
threshold_symmetry4 = 0.5; % 0.25 %HIGH BECAUSE NO 4 orders in train/val/test sets - to be fair with our models
threshold_symmetryInf = 0.19;

for index_obj=1:1:size(objects,2)
    object = objects(index_obj);
    %Read mesh
    obj_file = loadawobj( strcat('../Desktop/Models_obj/Model_',string(object),'.obj') );
    V = obj_file.v';
    F = obj_file.f3';

    try
        demo_C2Shape
    catch
        try
            demo_C2Shape
        catch
            demo_C2Shape
        end
    end
    correspondance_to_orders
    
    symmetry = symmetries(index_obj,:);
    
    precision_num_0 = precision_num_0 + sum( and(symmetry == 1, new_symmetry == 1)*1 );
    precision_num_1 = precision_num_1 + sum( and(symmetry == 2, new_symmetry == 2)*1 );
    precision_num_2 = precision_num_2 + sum( and(symmetry == 3, new_symmetry == 3)*1 );
    precision_num_3 = precision_num_3 + sum( and(symmetry == 4, new_symmetry == 4)*1 );
    precision_num_4 = precision_num_4 + sum( and(symmetry == 8, new_symmetry == 8)*1 );
    precision_den_0 = precision_den_0 + sum(new_symmetry==1);
    precision_den_1 = precision_den_1 + sum(new_symmetry==2);
    precision_den_2 = precision_den_2 + sum(new_symmetry==3);
    precision_den_3 = precision_den_3 + sum(new_symmetry==4);
    precision_den_4 = precision_den_4 + sum(new_symmetry==8);
    recall_den_0 = recall_den_0 + sum(symmetry==1);
    recall_den_1 = recall_den_1 + sum(symmetry==2);
    recall_den_2 = recall_den_2 + sum(symmetry==3);
    recall_den_3 = recall_den_3 + sum(symmetry==4);
    recall_den_4 = recall_den_4 + sum(symmetry==8);
    
end

recall_0 = (precision_num_0+0.0001)/(0.0001+recall_den_0);
precision_0 = (precision_num_0+0.0001)/(0.0001+precision_den_0);
recall_1 = (precision_num_1+0.0001)/(0.0001+recall_den_1);
precision_1 = (precision_num_1+0.0001)/(0.0001+precision_den_1);
recall_2 = (precision_num_2+0.0001)/(0.0001+recall_den_2);
precision_2 = (precision_num_2+0.0001)/(0.0001+precision_den_2);
recall_3 = (precision_num_3+0.0001)/(0.0001+recall_den_3);
precision_3 = (precision_num_3+0.0001)/(0.0001+precision_den_3);
recall_4 = (precision_num_4+0.0001)/(0.0001+recall_den_4);
precision_4 = (precision_num_4+0.0001)/(0.0001+precision_den_4);

recall_symmetries = ((precision_num_0+0.0001)/(0.0001+recall_den_0) + (precision_num_1+0.0001)/(0.0001+recall_den_1) + (precision_num_4+0.0001)/(0.0001+recall_den_4))/3;
precision_symmetries = ((precision_num_0+0.0001)/(0.0001+precision_den_0) + (precision_num_1+0.0001)/(0.0001+precision_den_1) + (precision_num_4+0.0001)/(0.0001+precision_den_4))/3;

F1_symmetries = 2.0*precision_symmetries*recall_symmetries/(precision_symmetries + recall_symmetries + 0.00001)

