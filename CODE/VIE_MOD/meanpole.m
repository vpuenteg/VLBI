% ************************************************************************
%   Description:
%   Approximation of the pole path by a linear trend. Translated from
%   Occam subfunction MEAN_POLE.
% 
%   Reference: 
%   IERS Conventions 2003, 2010, revisions 2014
%
%   Input:										
%      t                  time [year]
%      ctpm               model of the conventional mean pole ('linear', 'cubic', 'cmp2015')
%                
%   Output:
%      xpm, ypm            mean pole coordinates [mas]
%      flgm_ctp            flagmessage if a linear model instead of a cubic one had
%                          to be used
% 
%   External calls: 	
%      ---   
%
%   Coded for VieVS: 
%   10 Feb 2009 by Hana Spicakova
%
%   Revision: 
%   13 Oct 2010 by Hana Spicakova: model for conventional mean pole added
%      according to IERS Conv. 2010 (cubic model over the period 1976-2010)
%   22 Jun 2015 by Lucia Plank: new 2015 model added; needs to be updated
%       yearly!
%   14 Jul 2015 by A. Hellerschmied: Added check, if the table values for the IERS 2015 model are up to date
%
% *************************************************************************
function [xpm,ypm,flgm_ctp] = meanpole(t,ctpm)
flgm_ctp=0;

% time
t0 = 2000;       % year

switch ctpm
    case 'linear'
% if strcmp(ctpm,'linear') %IERS Conv. 2019

    x0 = 55.0;       %  mas
    x1 = 1.677;      %  mas/year
    
    y0 = 320.5;        %  mas
    y1 = 3.460;       %  mas/year
        
    xpm = x0 + x1*(t-t0); %[mas]
    ypm = y0 + y1*(t-t0); %[mas]

    case 'cubic' %IERS Conv. 2010
        if t < 2010         % (Cubic model only over the period (1976-2010))
            x0 = 55.974;    % mas
            x1 = 1.8243;    % mas/y
            x2 = 0.18413;   % mas/y^2
            x3 = 0.007024;  % mas/y^3

            y0 = 346.346;
            y1 = 1.7896;
            y2 = -0.10729;
            y3 = -0.000908;
        else
            x0 = 23.513;
            x1 = 7.6141;
            x2 = 0;
            x3 = 0;

            y0 = 358.891;
            y1 = -0.6287;
            y2 = 0;
            y3 = 0;
            flgm_ctp=1;
        end
        
    xpm = x0 + x1*(t-t0) + x2*(t-t0)^2 + x3*(t-t0)^3; %[mas]
    ypm = y0 + y1*(t-t0) + y2*(t-t0)^2 + y3*(t-t0)^3; %[mas]
    
    
    case 'cmp2015' % IERS Conv. 2015
        
    ierstab=[...
     1970.00,   0.002117,   0.219438;...
     1971.00,	0.005376,	0.225514;...
     1972.00,	0.008752,	0.231446;...
     1973.00,	0.012200,	0.237249;...
     1974.00,	0.015675,	0.242939;...
     1975.00,	0.019134,	0.248524;...
     1976.00,	0.022536,	0.254008;...
     1977.00,	0.025841,	0.25939;...
     1978.00,	0.029016,	0.264667;...
     1979.00,	0.032029,	0.269833;...
     1980.00,	0.034850,	0.274883;...
     1981.00,	0.037453,	0.279812;...
     1982.00,	0.039815,	0.284619;...
     1983.00,	0.041917,	0.289304;...
     1984.00,	0.043746,	0.293872;...
     1985.00,	0.045297,	0.298326;...
     1986.00,	0.046571,	0.302667;...
     1987.00,	0.047582,	0.306895;...
     1988.00,	0.048352,	0.311002;...
     1989.00,	0.048912,	0.314978;...
     1990.00,	0.049304,	0.318804;...
     1991.00,	0.049576,	0.322462;...
     1992.00,	0.049783,	0.32593;...
     1993.00,	0.049983,	0.329189;...
     1994.00,	0.050238,	0.332221;...
     1995.00,	0.050608,	0.335012;...
     1996.00,	0.051151,	0.337554;...
     1997.00,	0.051918,	0.339844;...
     1998.00,	0.052955,	0.341881;...
     1999.00,	0.054299,	0.34367;...
     2000.00,	0.055981,	0.345218;...
     2001.00,	0.058022,	0.346532;...
     2002.00,	0.060436,	0.347619;...
     2003.00,	0.063229,	0.34849;...
     2004.00,	0.066403,	0.349153;...
     2005.00,	0.069953,	0.349618;...
     2006.00,	0.073868,	0.349899;...
     2007.00,	0.078133,	0.350008;...
     2008.00,	0.082731,	0.349963;...
     2009.00,	0.087643,	0.349779;...
     2010.00,	0.092851,	0.349474;...
     2011.00,	0.098339,	0.349062;...
     2012.00,	0.104098,	0.348553;...
     2013.00,	0.110120,	0.347955;...
     2014.00,	0.116401,	0.347271;...
     2015.00,	0.122942,	0.346502];
        
    % Check, if the table is up to date:
    %  => Table values are available at: ftp://tai.bipm.org/iers/convupdt/chapter7/IERS_CMP_2015.F
    % Get current year:
    c = clock;
    current_year = c(1);
    if ierstab(end,1) < current_year
        fprintf('++++ WARNING: Table values for the mean pole model (IERS 2015) are not up-to-date! Please update table in /VieVS/COMPILE/VIE_MOD_Vxx/meanpole.m ++++\n')
    end
     
    ti  = floor(t); % integer year
    tinc= t-ti;     % increment year
    
    it=find(ierstab(:,1)==ti);
    
    if it==length(ierstab)
        xpm=(ierstab(it,2)+tinc*(ierstab(it,2)-ierstab(it-1,2)))*1000;
        ypm=(ierstab(it,3)+tinc*(ierstab(it,3)-ierstab(it-1,3)))*1000;
    else
        xpm=(ierstab(it,2)+tinc*(ierstab(it+1,2)-ierstab(it,2)))*1000;
        ypm=(ierstab(it,3)+tinc*(ierstab(it+1,3)-ierstab(it,3)))*1000;
    end       
        
end
   


