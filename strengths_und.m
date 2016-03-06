function [str] = strengths_und(a)
%STRENGTHS_UND        Strength
%
%   str = strengths_und(a);
%
%   Node strength is the sum of weights of links connected to the node.
%
%   Input:        a,    I/O object handler
%
%   Output:     str,    node strength
%
%
%   Notes:  CIJ is a weighted and undirected connection matrix.
%
%
%   Olaf Sporns, Indiana University, 2002/2006/2008

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

% compute strengths
str = sum(a.CIJ);        % strength
