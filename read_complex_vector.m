% ========Integers, unsigned========
% 'uint'            - 32 (4)
% 'uint8'           - 8  (1)
% 'uint16'          - 16 (2)
% 'uint32'          - 32 (4)
% 'uint64'          - 64 (8)
% 'uchar'           - 8  (1)
% 'unsigned char'   - 8  (1)
% 'ushort'          - 16 (2)
% 'ulong'           - 32 (4)
% 'ubitn'           - 1 ≤ n ≤ 64
% ========Integers, signed========
% 'int'             - 32 (4)
% 'int8'            - 8  (1)
% 'int16'           - 16 (2)
% 'int32'           - 32 (4)
% 'int64'           - 64 (8)
% 'integer*1'       - 8  (1)
% 'integer*2'       - 16 (2)
% 'integer*4'       - 32 (4)
% 'integer*8'       - 64 (8)
% 'schar'           - 8  (1)
% 'signed char'     - 8  (1)
% 'short'           - 16 (2)
% 'long'            - 32 (4)
% 'bitn'            - 1 ≤ n ≤ 64
% ========Floating-point numbers========
% 'single'          - 32 (4)
% 'double'          - 64 (8)
% 'float'           - 32 (4)
% 'float32'         - 32 (4)
% 'float64'         - 64 (8)
% 'real*4'          - 32 (4)
% 'real*8'          - 64 (8)
% ========Characters========
% 'char*1'          - 8  (1)
function complex_vector = read_complex_vector(fileName, unitType, inverseIQ)
    if(nargin < 3)
        inverseIQ = 0;
    end
    fid = fopen(fileName, 'rb');
    if(fid == -1)
        error("Can't open file");
    end
    vector = read_vector(fileName, unitType);
    
    if(mod(length(vector), 2))
        vector = vector(1:end-1);
    end
    
    if(inverseIQ)
        complex_vector = complex(vector(2:2:end), vector(1:2:end)).';
    else
        complex_vector = complex(vector(1:2:end), vector(2:2:end)).';
    end
    fclose(fid);
end