function  write2dev(VRAM,Vector,COM_port)
    write(COM_port,VRAM,'uint8');
    write(COM_port,Vector,'uint8');
end