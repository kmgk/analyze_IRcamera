% .tifか.matファイルを読み込む
function data = load_ir_data
    [file, path] = uigetfile({'*.mat;*.tif'});
    if ~file
        data = [];
        return;
    end
    full_file_path = fullfile(path, file);
    % 拡張子で場合分け
    [~,~,ext] = fileparts(full_file_path);
    if strcmp(ext, ".tif")
        image_info = imfinfo(full_file_path);
        data.raw_data = zeros(image_info(1).Height, image_info(1).Width, size(image_info, 1));
        for i = 1:size(image_info,1)
            data.raw_data(:,:,i) = imread(full_file_path, i);
        end
    end
end