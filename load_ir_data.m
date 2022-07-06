% .tifか.matファイルを読み込む
function [data, file, path] = load_ir_data
    [file, path] = uigetfile({'*.mat;*.tif;*.ats'});
    if ~file
        data = [];
        return;
    end
    full_file_path = fullfile(path, file);
    % 拡張子で場合分け
    [~,~,ext] = fileparts(full_file_path);
    if strcmp(ext, ".tif")
        image_info = imfinfo(full_file_path);
        data = zeros(image_info(1).Height, image_info(1).Width, size(image_info, 1));
        for i = 1:size(image_info,1)
            data(:,:,i) = imread(full_file_path, i);
        end
    elseif strcmp(ext, ".ats")
        v = FlirMovieReader(full_file_path);
        v_info = v.info;
        data = zeros(v_info.height, v_info.width, v_info.numFrames);
        while ~v.isDone
            v_data = v.read;
            data(:,:,v.frameIndex+1) = v_data;
        end
    end
end