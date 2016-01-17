function T = transitivity_wu(a)
%TRANSITIVITY_WU    Transitivity
%
%   T = transitivity_wu(a);
%
%   Transitivity is the ratio of 'triangles to triplets' in the network.
%   (A classical version of the clustering coefficient).
%
%   Input:      a,      I/O object handler
%
%   Output:     T,      transitivity scalar
%
%   Reference: Rubinov M, Sporns O (2010) NeuroImage 52:1059-69
%              based on Onnela et al. (2005) Phys Rev E 71:065103
%
%
%   Mika Rubinov, UNSW, 2010

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

K = sum((a.CIJ~=0),2);            	
cyc3 = diag(((a.CIJ).^(1/3))^3);           
T = sum(cyc3)./sum((K.*(K-1)));       %transitivity
