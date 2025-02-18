% #########################################################################
% #     read_vgosdb_input_settings
% #########################################################################
%
% DESCRIPTION
% 	This file reads the vievs_input_settings.txt file from the /WORK/ folder
% 	and looks for "institute" and "frequencyband" path to file: ptf = 'vgosdb_input_settings.txt';
%   
%
% CREATED  
%   2017-11-14     Jakob Gruber
%
% REFERENCES
%
%
% COUPLING
%
%
% INPUT:
%	- ptf (path to file)
% OUTPUT:
%	- in (institute name)(cell array)
%	- fb (frequency band name)
%   - wrapper_k  (wrapper tag, "all" or "ngs")
%   - wrapper_v  (wrapper version number)
%
% CHANGES:
% 2018-09-12, A. Hellerschmied: "Priority list option" for institution flag added
%

function [ in, fb, wrapper_k, wrapper_v, ioncorr, ambcorr ] = read_vgosdb_input_settings( ptf )

in_tag          = 'institute:';             % => in
fb_tag          = 'frequency_band:';        % => fb
wrapper_k_tag   = 'wrapper_k:';             % => wrapper_k
wrapper_v_tag   = 'wrapper_version:';       % => wrapper_v
ioncorr_tag     = 'ionosphere_correction:';  % => ioncorr
ambcorr_tag     = 'ambiguity_correction:';   % => ambcorr


in{1} = '';
fb = '';
wrapper_k = '';
wrapper_v = '';
ioncorr = '';
ambcorr = '';

% ##### Open file #####
fid = fopen(ptf,'r');

if fid<0
    fprintf('File vievs_input_settings.txt does not exist\n')
else
    fprintf('Reading: %s\n', ptf)
    
    % ##### Loop over all lines #####
    while ~feof(fid)
	
        % #### Read one line ####
        str = fgetl(fid);
  
        if ~isempty(str)
            % parse line
            temp_str = textscan(str, '%s', 'CommentStyle', '%'); 
            if ~isempty(temp_str{1}) % not a comment

                switch(temp_str{1}{1})
                    
                    case in_tag
                        % in = temp_str{1}{2};
                        in = {temp_str{1}{2:length(temp_str{1})}};
                        
                    case fb_tag
                        fb = temp_str{1}{2};

                    case wrapper_k_tag
                        wrapper_k = temp_str{1}{2};

                    case wrapper_v_tag
                        wrapper_v = temp_str{1}{2};
                        
                    case ioncorr_tag
                        ioncorr = temp_str{1}{2};
                        
                    case ambcorr_tag
                        ambcorr = temp_str{1}{2};

                end
            end
            
        end % if ~isempty(str)
        
    end % while ~feof(fid)
    
    
    
    
    % Close file
    fclose(fid);

    
end




