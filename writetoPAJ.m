function writetoPAJ(a, fname, arcs)
%WRITETOPAJ         Write to Pajek
%
%   writetoPAJ(a, fname, arcs);
%
%   This function writes a Pajek .net file from a MATLAB matrix
%
%   Inputs:     a,          I/O object handler
%               fname,      filename minus .net extension
%               arcs,       1 for directed network
%                           0 for an undirected network
%
%   Notes:  CIJ is a connection matrix.
%
%
%   Chris Honey, Indiana University, 2007

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

N = size(a.CIJ,1);
fid = fopen(cat(2,fname,'.net'), 'w');

%%%VERTICES
fprintf(fid, '*vertices %6i \r', N);
for i = 1:N
    fprintf(fid, '%6i "%6i" \r', [i i]);
end

%%%ARCS/EDGES
if arcs
    fprintf(fid, '*arcs \r');
else
    fprintf(fid, '*edges \r');
end

for i = 1:N
    for j = 1:N
        if a.CIJ(i,j) ~= 0
            fprintf(fid, '%6i %6i %6f \r', [i j a.CIJ(i,j)]);
        end
    end
end

fclose(fid)
