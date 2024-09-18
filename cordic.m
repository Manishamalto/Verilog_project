L = 139;
u = 20;
n = (0:L-1)';
teta =  pi * u * n .* (n + 1) / L;
teta1=wrapToPi(teta);
q = quantizer([28 4]);
int_data = num2bin(q,teta1);
writematrix(int_data,'in_bin.dat')