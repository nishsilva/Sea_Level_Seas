% Function file that yields the phases for the equilibrium tide of the
% major tidal constituents from HW95 catalogue
% 
% INPUT:   target time specified as mjd
%          char-array of constituents
%
% OUTPUT:  phases in radians
% 
% First created: 9-Oct-2014 MS
%
% --------------------------------------------------------------------

function [ph] = get_EQphase(mjd,cid)

% ---> reference epoch: J2000.0 (midday reference)
mjd0 = 51544.5;
T = (mjd-mjd0)/36525;

% mean local lunar time
tau = 242.14980453 + 12703732.88855*T + 0.0017696111*T^2 - 0.00000183140*T^3;
% mean tropic longitude of the Moon
s   = 218.31664563 + 481267.881196*T - 0.0014663889*T^2 + 0.00000185140*T^3;
% mean tropic longitude of the Sun 
h   = 280.46645016 + 36000.7697488*T + 0.0003032222*T^2 + 0.000000020*T^3;
% mean tropic longitude of the lunar perigee 
p   =  83.35324312 + 4069.01363525*T - 0.0103217222*T^2 - 0.00001249168*T^3;
% mean tropic longitude of the ascending lunar node (decreasing in time)(N')
zns = 234.95544499 + 1934.13626197*T - 0.0020756111*T^2 - 0.00000213942*T^3;
% mean tropic longitude of the perihelion 
ps  = 282.93734098 + 1.719457667*T + 0.0004568889*T^2 - 0.00000001776*T^3;

% all together in (deg)
argT = [tau s h p zns ps];

% ---> argument at epoch with Doodson numbers
arg_sa = [0 0 1 0 0 0]*argT';
ph_sa = wrapTo2Pi(arg_sa*pi/180);

arg_ss = [0 0 2 0 0 0]*argT';
ph_ss = wrapTo2Pi(arg_ss*pi/180);


% ---> arrange output according to 'con'
nc = size(cid,1);
ph = zeros(nc,1);

% specify order in this function file and convert to cell arrays
ph_here = [ph_sa;ph_ss];
cid_here = ['sa';'ss'];

Ccid_here = cellstr(cid_here);
Ccid = cellstr(cid);

% ---> loop the constituents
for j = 1:nc
    
    % determine position of j and assign to output
    [str,pos1,pos2] = intersect(Ccid(j),Ccid_here);
    ph(j) = ph_here(pos2);
    
end


