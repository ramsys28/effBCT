function [kden,N,K] = density_und(a)
%DENSITY        Density
%
%   kden = density_und(a);
%   [kden,N,K] = density_und(a);
%
%   Density is the fraction of present connections to possible connections.
%
%   Input:      a,      I/O object handler
%
%   Output:     kden,   density
%               N,      number of vertices
%               K,      number of edges
%
%   Notes:  Assumes CIJ is undirected and has no self-connections.
%           Weight information is discarded.
%
%
%   Olaf Sporns, Indiana University, 2002/2007/2008


% Modification history:
% 2009-10: K fixed to sum over one half of CIJ [Tony Herdman, SFU]
% 2015: CIJ is directly accessed without being loaded into memory

N = size(a.CIJ, 1);
K = nnz(triu(a.CIJ));
kden = K/((N^2-N)/2);
