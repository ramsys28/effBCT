function [id,od,deg] = degrees_dir(a)
%DEGREES_DIR        Indegree and outdegree
%
%   [id,od,deg] = degrees_dir(CIJ);
%
%   Node degree is the number of links connected to the node. The indegree 
%   is the number of inward links and the outdegree is the number of 
%   outward links.
%
%   Input:      a,      I/O object handler
%
%   Output:     id,     node indegree
%               od,     node outdegree
%               deg,    node degree (indegree + outdegree)
%
%   Notes:  Inputs are assumed to be on the columns of the CIJ matrix.
%           Weight information is discarded.
%
%
%   Olaf Sporns, Indiana University, 2002/2006/2008

% Modification history:
% 2015: CIJ is directly accessed without being loaded into memory

% ensure CIJ is binary and compute degrees
id = sum(double(a.CIJ~=0),1);    % indegree = column sum of CIJ
od = sum(double(a.CIJ~=0),2)';   % outdegree = row sum of CIJ
deg = id+od;      % degree = indegree+outdegree
