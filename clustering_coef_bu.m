function C = clustering_coef_bu(a)
%CLUSTERING_COEF_BU     Clustering coefficient
%
%   C = clustering_coef_bu(a);
%
%   The clustering coefficient is the fraction of triangles around a node
%   (equiv. the fraction of node’s neighbors that are neighbors of each other).
%
%   Input:      a,      I/O object handler
%
%   Output:     C,      clustering coefficient vector
%
%
%   Notes:  CIJ is a binary and undirected connection matrix.
%
%   Important update: 
%       Linear indexing is not supported by matfile objects. In order to
%       solve this issue, subscripted reference is re-defined with matlab's
%       subsref. For example CIJ(V,V) is replaced as follows:
%       subsref(a.CIJ,S) where S.type = '()' and S.subs = {V,V}
%
%   Reference: Watts and Strogatz (1998) Nature 393:440-442.
%
%
%   Mika Rubinov, UNSW, 2007-2010

% Modification history:
% 2016: 1. CIJ is directly accessed without being loaded into memory
%       2. Redefined matlab's subscripted reference wherever needed since 
%       linear indexing is not supported for matfile objects

n = length(a.CIJ);
C = zeros(n,1);
S.type = '()'; %type of index used for re-defining reference

for u=1:n
    V = find(a.CIJ(u,:));
    k = length(V);
    if k>=2;                %degree must be at least 2 
        S.subs = {V,V};
        T = subsref(a.CIJ,S);
        C(u) = sum(T(:))/(k^2-k);
    end
end
