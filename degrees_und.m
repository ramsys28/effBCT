function [deg] = degrees_und(a)
%DEGREES_UND        Degree
%
%   deg = degrees_und(CIJ);
%
%   Node degree is the number of links connected to the node.
%
%   Input:      a,      I/O object handler
%
%   Output:     deg,    node degree
%
%   Notes:  1. CIJ is a weighted/binary and undirected connection matrix.
%           2. Weight information is discarded.
%
%
%   Olaf Sporns, Indiana University, 2002/2006/2008

% Modification history:
% 2015: CIJ is directly accessed without being loaded into memory, 
% binary validation of CIJ is performed inside the sum (direct access).

% ensure CIJ is binary and compute degrees
deg = sum(double(a.CIJ~=0));
