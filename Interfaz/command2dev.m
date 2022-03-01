function [readVec] = command2dev(reada,COM_porta,N)
     write(COM_porta,reada,'uint8');
    while COM_porta.NumBytesAvailable < N; end
        readVec = read(COM_porta,N,'uint8');
end