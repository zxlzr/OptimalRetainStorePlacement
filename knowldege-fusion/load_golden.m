function WTrueNeighbor=golden_matrix(golden_file)


data_num = 1000001;
query_num = 2045;
WTrueNeighbor = zeros(query_num, data_num);
whos WTrueNeighbor
[fid, message] = fopen(golden_file, 'r');
if fid == -1
    display(message)
    return
end
idx = 0;
while ~feof(fid)
    idx = idx+1;
    if mod(idx, 1000) == 0
        display([num2str(idx),' queries finished.'])
    end
    aline = fgetl(fid);
    aline = regexp(aline, ' ', 'split');
    sen_num = size(aline,2)-1;
    aline = aline(:, 1:sen_num);
    aline_l = zeros(1,sen_num);
    for i=1:sen_num
        aline_l(i) = str2num(aline{1,i});
    end
    for sen_idx = aline_l
        WTrueNeighbor(idx, sen_idx) = 1;
    end
end
fclose(fid);
