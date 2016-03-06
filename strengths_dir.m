function [is,os,str] = strengths_dir(a)
%STRENGTHS_DIR      Instrength and outstrength
%
%   [is,os,str] = strengths_dir(a);
%
%   Node strength is the sum of weights of links connected to the node. The
%   instrength is the sum of inward link weights and the outstrength is the
%   sum of outward link weights.
%
%   Input:      a,      I/O object handler
%
%   Output:     is,     node instrength
%               os,     node outstrength
%               str,    node strength (instrength + outstrength)
%
%   Notes:  1. Inputs are assumed to be on the columns of the CIJ matrix.
%           2. CIJ is a weighted and directed connection matrix.
%
%
%   Olaf Sporns, Indiana University, 2002/2006/2008

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

% compute strengths
is = sum(a.CIJ,1);    % instrength = column sum of CIJ
os = sum(a.CIJ,2)';   % outstrength = row sum of CIJ
str = is+os;        % strength = instrength+outstrength
