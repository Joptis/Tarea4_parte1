function [sal]= converter(dec)
if (size(dec,1)==2)
    q1=dec(1);
    q2=dec(2); 
    if q1<16
        s1=strcat('0',num2str(dec2hex(q1)));
    else
        s1=dec2hex(q1);   
    end
    if q2<16 
        s2=strcat('0',num2str(dec2hex(q2)));
    else
        s2=dec2hex(q2);
    end
    tot=strcat(s1,s2);
    sal=hex2dec(tot);
end
if (size(dec,1)==3)
    q1=dec(1);
    q2=dec(2); 
    q3=dec(3);
    if q1<16
        s1=strcat('0',num2str(dec2hex(q1)));
    else
        s1=dec2hex(q1);   
    end
    if q2<16 
        s2=strcat('0',num2str(dec2hex(q2)));
    else
        s2=dec2hex(q2);
    end
    if q3<16 
        s3=strcat('0',num2str(dec2hex(q3)));
    else
        s3=dec2hex(q3);
    end
    tot=strcat(s1,s2,s3);
    sal=hex2dec(tot);
end 