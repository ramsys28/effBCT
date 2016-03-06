function [a,sn] = score_wu(a, s)
%SCORE_WU       S-score
%
%   [a,sn] = score_wu(a,s);
%
%   The s-core is the largest subnetwork comprising nodes of strength at
%   least s. This function computes the s-core for a given weighted
%   undirected connection matrix. Computation is analogous to the more
%   widely used k-core, but is based on node strengths instead of node
%   degrees. 
%
%   input:            a,    I/O object handler
%                     s,    level of s-core. Note: s can take on any fractional value
%
%   output:           a,    I/O object handler on the connection matrix of 
%                           the s-core. This matrix (a.CIJ) contains only 
%                           nodes with a strength of at least s.
%                    sn,    size of s-score
%
%   Notes:  CIJ is a weighted and undirected connection matrix.
%
%
%   Olaf Sporns, Indiana University, 2007/2008/2010/2012

% Modification history:
% 2016: 1. CIJ is directly accessed without being loaded into memory
%       2. CIJscore is removed, object handler is returned instead

while 1

    % get strengths of matrix
    [str] = strengths_und(a);
    
    % find nodes with strength <s
    ff = find((str<s)&(str>0));
    
    % if none found -> stop
    if (isempty(ff)) break; end;

    a.Properties.Writable = true; %enable writing property
    
    % peel found nodes
    a.CIJ(ff,:) = 0;
    a.CIJ(:,ff) = 0;

    a.Properties.Writable = false; %disable writing property
    
end;

sn = sum(str>0);
