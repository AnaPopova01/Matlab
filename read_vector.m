function vector = read_vector(fileName, unitType)
    fid = fopen(fileName, 'rb');
    if(fid == -1)
        error("Can't open file");
    end
    vector = fread(fid, Inf, unitType);
    fclose(fid);
end