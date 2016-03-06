function [C_tri] = transitivity_bu(a)
%TRANSITIVITY_BU    Transitivity
%
%   T = transitivity_bu(a);
%
%   Transitivity is the ratio of 'triangles to triplets' in the network.
%   (A classical version of the clustering coefficient).
%
%   Input:      a,      I/O object handler
%
%   Output:     T,      transitivity scalar
%
%   Notes: CIJ is a binary and undirected connection matrix.
%
%   Reference: e.g. Humphries et al. (2008) Plos ONE 3: e0002051
%
%
%   Alexandros Goulas, Maastricht University, 2010

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

C_tri = trace((a.CIJ)^3) / (sum(sum((a.CIJ)^2)) - trace((a.CIJ)^2));

return;
