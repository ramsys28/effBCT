function [kden,N,K] = density_dir(a)
%DENSITY        Density
%
%   kden = density_dir(CIJ);
%   [kden,N,K] = density_dir(CIJ);
%
%   Density is the fraction of present connections to possible connections.
%
%   Input:      a,      I/O object handler
%
%   Output:     kden,   density
%               N,      number of vertices
%               K,      number of edges
%
%   Notes:  Assumes CIJ is directed and has no self-connections.
%           Weight information is discarded.
%
%
%   Olaf Sporns, Indiana University, 2002/2007/2008

% Modification history:
% 2015: CIJ is directly accessed without being loaded into memory

N = size(a.CIJ,1);
K = nnz(a.CIJ);
kden = K/(N^2-N);
