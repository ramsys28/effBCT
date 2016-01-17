function T = transitivity_wd(a)
%TRANSITIVITY_WD    Transitivity
%
%   T = transitivity_wd(a);
%
%   Transitivity is the ratio of 'triangles to triplets' in the network.
%   (A classical version of the clustering coefficient).
%
%   Input:      a,      I/O object handler
%
%   Output:     T,      transitivity scalar
%
%   Reference:  Rubinov M, Sporns O (2010) NeuroImage 52:1059-69
%               based on Fagiolo (2007) Phys Rev E 76:026107.
%
%
%   Mika Rubinov, UNSW/U-Cambridge
%   Christoph Schmidt, Friedrich Schiller University Jena
%   2007-2013

% Modification history:
% 2007: original (MR)
% 2013: removed test for absence of nodewise 3-cycles (CS)
% 2016: CIJ is directly accessed without being loaded into memory


%   Methodological note (also see note for clustering_coef_bd)
%   The weighted modification is as follows:
%   - The numerator: adjacency matrix is replaced with weights matrix ^ 1/3
%   - The denominator: no changes from the binary version
%
%   The above reduces to symmetric and/or binary versions of the clustering
%   coefficient for respective graphs.

% A = a.CIJ~=0;                             %adjacency matrix
% S = (a.CIJ).^(1/3)+((a.CIJ).').^(1/3);    %symmetrized weights matrix ^1/3
K = sum((a.CIJ~=0)+(a.CIJ~=0).',2);                     %total degree (in + out)
cyc3 = diag(((a.CIJ).^(1/3)+((a.CIJ).').^(1/3))^3)/2;   %number of 3-cycles (ie. directed triangles)
CYC3 = K.*(K-1)-2*diag((a.CIJ~=0)^2);   %number of all possible 3-cycles
if CYC3
    T = sum(cyc3)./sum(CYC3);           %transitivity
else                                    %if no 3-cycles exist
    T = 0;
end
