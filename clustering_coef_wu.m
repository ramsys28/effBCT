function C = clustering_coef_wu(a)
%CLUSTERING_COEF_WU     Clustering coefficient
%
%   C = clustering_coef_wu(a);
%
%   The weighted clustering coefficient is the average "intensity" of 
%   triangles around a node.
%
%   Input:      a,      I/O object handler
%
%   Output:     C,      clustering coefficient vector
%
%   Notes:  CIJ is a weighted and undirected connection matrix.
%
%   Reference: Onnela et al. (2005) Phys Rev E 71:065103
%
%
%   Mika Rubinov, UNSW, 2007-2010

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

K = sum((a.CIJ~=0),2); 
% cyc3 = diag((nthroot((a.CIJ),3))^3); - alternative
cyc3 = diag(((a.CIJ).^(1/3))^3);           
K(cyc3==0) = inf;             %if no 3-cycles exist, make C=0 (via K=inf)
C = cyc3./(K.*(K-1));         %clustering coefficient

