function Cs = subgraph_centrality(a)
% SUBGRAPH_CENTRALITY     subgraph centrality of a network
%
%   Cs = subgraph_centrality(a)
%
%   The subgraph centrality of a node is a weighted sum of closed walks of
%   different lengths in the network starting and ending at the node. This
%   function returns a vector of subgraph centralities for each node of the
%   network.
%
%   Inputs:       a,        I/O object handler
%
%   Outputs:     Cs,        subgraph centrality
%
%   Notes:	CIJ is a binary adjacency matrix.
%
%   Reference: Estrada and Rodriguez-Velasquez (2005) Phys Rev E 71, 056103
%              Estrada and Higham (2010) SIAM Rev 52, 696.
%
%   Xi-Nian Zuo, Chinese Academy of Sciences, 2010
%   Rick Betzel, Indiana University, 2012

%   Modification History:
%	2016: CIJ is directly accessed without being loaded into memory

[V,lambda] = eig(a.CIJ);               % Compute the eigenvectors and
lambda     = diag(lambda);             % eigenvalues.
V2         = V.^2;                     % Matrix of squares of the eigenvectors elements.
Cs         = real(V2 * exp(lambda));   % Compute eigenvector centrality. Lop off imaginary part remaining due to precision error.
