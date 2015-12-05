function [a, CIJ] = read_matfile(path)

%   Opens I/O connection with the disk in order to retrieve (big) data 
%   without loading them on workspace.
%
%   Input:      path,   full path specifying the location of the directed 
%                       (binary/weighted) connection matrix
%
%   Output:     a,     I/O object handler
%               CIJ,   string containing the name of the connection matrix
%
%   Notes:      Full path should contain one .mat file with the desired 
%               connection matrix only.
%

a = matfile(path);
b = whos(a);

if(min(b.size) == max(b.size))
    CIJ = b.name;
else
    error('Matrix should be square!');
end
