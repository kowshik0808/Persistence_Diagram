
% load settings
setting_up_shrec2010_nonrigid_s
skip_coding = 0;


load_vq_codes;


% total spatial bins
dimFea      = size(feature1,1);
tBins       = sum(pyramid);
dimFeaUnit  = dimFea/tBins;


warning off;
mkdir(DIST_DIR);
warning on;   


% spatial levels
pLevels = length(pyramid);
D_multi_level = zeros(num_shapes,num_shapes,pLevels);

for iter1 = 1:pLevels

    str = mprintf(str, '%s', iter1);    
    
    if iter1 == 1
        fea1 = feature1(1:dimFeaUnit,:)';
        fea2 = feature2(1:dimFeaUnit,:)';
    else
        fea1 = feature1(sum(pyramid(1:iter1-1))*dimFeaUnit:sum(pyramid(1:iter1))*dimFeaUnit,:)';
        fea2 = feature2(sum(pyramid(1:iter1-1))*dimFeaUnit:sum(pyramid(1:iter1))*dimFeaUnit,:)';        
    end

    D1 = pdist2(fea1,fea1,'euclidean');
    D2 = pdist2(fea1,fea2,'euclidean');
    D = min(D1, D2);

    D_multi_level(:,:,iter1) = D;

end

% Save result

save(fullfile(DIST_DIR, ['distance_' num2str(dimFeaUnit) '_coding_' CodingType '_desc_' DescriptorType '.mat']), 'D_multi_level');
% save(fullfile(DIST_DIR, ['distance_' num2str(dimFeaUnit) '_desc_' DescriptorType '_assign_' AssignmentType '.mat']), 'D_multi_level');
% save(fullfile(DIST_DIR, ['distance_' num2str(dimFeaUnit) '_desc_' DescriptorType '_LLC_knn_' num2str(LLC_knn) '.mat']), 'D_multi_level');


