function  [lambda,efficiency,ecc,radius,diameter] = charpath(a, diagonal_dist)
%CHARPATH       Characteristic path length, global efficiency and related statistics
%
%   lambda = charpath(a);
%   lambda = charpath(a,1);
%   [lambda,efficiency] = charpath(a);
%   [lambda,efficiency,ecc,radius,diameter] = charpath(a);
%
%   The characteristic path length is the average shortest path length in 
%   the network. The global efficiency is the average inverse shortest path
%   length in the network.
%
%   Input:      a,               I/O object handler
%               diagonal_dist,   optional argument
%                                include distances on the main diagonal
%                                (diagonal_dist=0 by default)
%
%   Outputs:    lambda,         characteristic path length
%               efficiency,     global efficiency
%               ecc,            eccentricity (for each vertex)
%               radius,         radius of graph
%               diameter,       diameter of graph
%
%   Notes:
%       The input distance matrix may be obtained with any of the distance
%   functions, e.g. distance_bin, distance_wei.
%       Characteristic path length is calculated as the global mean of the 
%   distance matrix CIJ, excludings any 'Infs' and excluding distances on 
%   the main diagonal (unless diagonal_dist=1; by default diagonal_dist=0).
%
%   Important updates: 
%       1. Diagonal elements are removed by re-defining matlab's assignment 
%       procedure (through matlab's subsasgn) since linear indexing is not 
%       supported by matfile objects. For example:
%       CIJ(1:n+1:end) = Inf is replaced by matlab's subsasgn as follows:
%       subsasgn(a.CIJ,S,Inf) where S.type = '()' and S.subs = {1:n+1:n^2}
%       
%       2. Subscripted references are also re-defined for matfile objects. 
%       For example:
%       CIJ(CIJ~=Inf) is replaced by matlab's subsref as follows:
%       subsref(a.CIJ,S) where S.type = '()' and S.subs = {a.CIJ~=Inf} 
%
%   Olaf Sporns, Indiana University, 2002/2007/2008
%   Mika Rubinov, U Cambridge, 2010/2015

% Modification history
% 2002: original (OS)
% 2010: incorporation of global efficiency (MR)
% 2015: exclusion of diagonal weights by default (MR) 
% 2016: 1. CIJ is directly accessed without being loaded into memory
%       2. Redefined matlab's subscripted assignment and reference wherever
%       needed since linear indexing is not supported for matfile objects

a.Properties.Writable = true; %activate writing property

n = size(a.CIJ,1);
temp_diag = diag(a.CIJ); %keep a copy of the main diagonal elements

S.type = '()'; %type of index used for re-defining assignment
S.subs = {1:n+1:n^2}; %actual subscripts (diagonal elements)

if ~exist('diagonal_dist','var') || ~diagonal_dist
    a.CIJ = subsasgn(a.CIJ, S, Inf); %set diagonal distance to inf
end

S.subs = {a.CIJ~=Inf}; %the actual subscripts are now the non-Inf elements

% Mean of finite entries of D(G)
lambda = sum(sum(subsref(a.CIJ,S)))/length(nonzeros(a.CIJ~=Inf));

% Efficiency: mean of inverse entries of D(G)
efficiency = sum(sum(1./subsref(a.CIJ,S)))/length(nonzeros(a.CIJ~=Inf));

% Eccentricity for each vertex (note: ignore 'Inf') 
ecc = max(a.CIJ.*(a.CIJ~=Inf),[],2);

% Radius of graph
radius = min(ecc);

% Diameter of graph
diameter = max(ecc);

a.CIJ = subsasgn(a.CIJ, S, temp_diag); %recover diagonal elements

a.Properties.Writable = false; %de-activate writing property
