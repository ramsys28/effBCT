function [Spos,Sneg,vpos,vneg] = strengths_und_sign(a)
%STRENGTHS_UND_SIGN        Strength and weight
%
%   [Spos,Sneg] = strengths_und_sign(a);
%   [Spos,Sneg,vpos,vneg] = strengths_und_sign(a);
%
%   Node strength is the sum of weights of links connected to the node.
%
%   Inputs:             a,      I/O object handler      
%
%   Output:     Spos/Sneg,      nodal strength of positive/negative weights
%               vpos/vneg,      total positive/negative weight
%
%   Notes: CIJ is an undirected connection matrix with positive & negative 
%          weights.
%
%   2011, Mika Rubinov, UNSW

%   Modification History:
%   Mar 2011: Original
%	Mar 2016: 1. CIJ is directly accessed without being loaded into memory
%             2. Diagonal elements are removed by re-defining matlab's 
%             assignment procedure (through matlab's subsasgn) since linear 
%             indexing is not supported by matfile objects

a.Properties.Writable = true; %enable writing property

n = length(a.CIJ);              %number of nodes

S.type = '()';                      %define function's type
S.subs = {1:n+1:n^2};               %define diagonal indices
a.CIJ = subsasgn(a.CIJ, S, 0);      %clear diagonal

Spos = sum((a.CIJ).*(a.CIJ>0));     %positive strengths
Sneg = sum(-(a.CIJ).*(a.CIJ<0));    %negative strengths

if nargout>2
    vpos = sum(Spos);       %positive weight
    vneg = sum(Sneg);       %negative weight
end

a.Properties.Writable = false; %disable writing property
