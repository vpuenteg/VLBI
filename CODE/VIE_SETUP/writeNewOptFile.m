% This function creates empty (commented) data to an optfile (data
% is appended if the file does already exist...
%
% CHANGE LOG:
%   16 May 2014 by Monika Tercjak: adding "Station to be downweighted" to OPT file
%   20 Jun 2014 by Hana Krasna: the downtime for stations from Lucia Plank added back
%   20 Jun 2014 by Hana Krasna: the description of cable cal added
% 	13 Jan 2015 by Matthias Madzak: Comment part corrected!
% 	11 Dec 2015 by A. Hellerschmied: Comment part corrected!
% 	07 Jan 2016 by Matthias Madzak: Comment part corrected!
% 	08 Feb 2016 by C. Schoenberger: Comment part updated.
% 	10 Mai 2016 by A. Hellerschmied: Comments part updated (# Name; # Date)
%       18 Dec 2018 by S. Boehm: "Stations to be downweighted" deleted from comments part

function writeNewOptFile(wantedOPTfile)

    % create new OPT file
    fid=fopen(wantedOPTfile, 'a');
    disp(wantedOPTfile)
    % write some helping lines to OPT file
    fprintf(fid, ['CLOCK BREAKS: 0\n',...
        'STATIONS TO BE EXCLUDED: 0\n',...
        'BASELINES TO BE EXCLUDED: 0\n',...
        'SOURCES TO BE EXCLUDED: 0\n',...
        'STATIONS TO BE DOWN-WEIGHTED: 0\n',...
        'NO CABLE CAL: 0\n',...
        '+BASELINE-DEPENDENT CLOCK OFFSET\n',...
        '-BASELINE-DEPENDENT CLOCK OFFSET\n',...
        '\n',...
        '# Name: <Enter your name here>\n',...
        '# Date: <Date of OPT-file submission>\n',...
        '# Additional analysis comments (optional):\n',...
        '\n',...
        '\n',...
        '# example\n',...
        '# =============================================\n',...
        '# CLOCK REFERENCE:\n',...
        '# WETTZELL\n',...
        '#\n',...
        '# CLOCK BREAKS: 2\n',...
        '# BADARY    55454.4\n',...
        '# WETTZELL  55372.369\n',...
        '#\n',...
        '# STATIONS TO BE EXCLUDED: 5\n',...
        '# MATERA  \n',...
        '# WETTZELL\n',...
        '# MATERA   YYMMDDhhmm-YYMMDDhhmm\n',...
        '# WETTZELL YYMMDDhhmm-YYMMDDhhmm\n',...
        '# BADARY   MJD1-MJD2\n',...
        '#\n',...
        '# BASELINES TO BE EXCLUDED: 3\n',...
        '# WETTZELL  ZELENCHK\n',...
        '# SVETLOE   ZELENCHK\n',...
        '# BADARY    ZELENCHK\n',...
        '#\n',...
        '# SOURCES TO BE EXCLUDED: 1\n',...
        '# 1936+095\n',...
        '# 2356+385 YYMMDDhhmm-YYMMDDhhmm\n',...
        '#\n',...
        '# NO CABLE CAL: 2\n',...
        '# WETTZELL\n',...
        '# MATERA  \n',...
        '#\n',...
        '# +BASELINE-DEPENDENT CLOCK OFFSET\n',...
        '# WETTZELL  ZELENCHK\n',...
        '# #SVETLOE   ZELENCHK\n',...
        '# BADARY    ZELENCHK\n',...
        '# -BASELINE-DEPENDENT CLOCK OFFSET\n']);

    
    fclose(fid);
