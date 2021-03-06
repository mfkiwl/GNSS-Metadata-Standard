

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the collection of test data. Each test has one directory, in
% which there should be an XML file and corresponding binary data. 
%Each test directory should contain two matlab/octave files:
%  'CheckData.m': should compare the converted samples to the original 
%                 (or some reference), returning true upon succes
%  'CleanData.m': should delete the converted files 


testDirectories = { 'CODC' , 'FHG', 'FITWDP', 'IFEN', 'JRC', 'TRIGR' };

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purge all of the old converted sample files, to ensure that the 
% TestConverter execution acutally creates new converted files 

warning('off','all')

fprintf('Deleting old files: ');
for t=1:numel(testDirectories)
    cd(testDirectories{t});
    CleanData( );
    cd('..');
    fprintf('.');
end
fprintf('Done.\n');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the Converter
doSilent = 1;
binName    = 'Converter';
testDir    = pwd;

% check the system (xmlread not supported under Octave) 
%isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
%isMatlab = ~isOctave;

fprintf('Running the test converter ("%s"): ',binName);
for t=1:numel(testDirectories)
       
    cd(testDirectories{t});  
    RunConverter( doSilent );
    cd('..');

end
fprintf('\Conversion completed.\n\n');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check each of the files
fprintf('Checking the converted output: \n');
for t=1:numel(testDirectories)
    
    cd(testDirectories{t});
    
    TEST_OK = CheckData( doSilent );
    
    TestName = '                ';
    TestName(1:length(testDirectories{t})) = testDirectories{t};
    TestName(1+length(testDirectories{t})) = ':';
    
    if(     TEST_OK ==  1 )
        fprintf('%s OK\n',TestName);
    elseif( TEST_OK ==  0 )
        fprintf('%s FAILED!\n',TestName);
    elseif( TEST_OK == -1 )
        fprintf('%s SKIPPED\n',TestName);
    else
        fprintf('%s PROBLEM WITH TEST\n',TestName);
    end
    
    cd('..');

end
fprintf('\nTest completed.\n\n');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purge all of the old converted sample files now that we're done.

warning('off','all')

fprintf('Deleting converted files: ');
for t=1:numel(testDirectories)
    cd(testDirectories{t});
    CleanData( );
    cd('..');
    fprintf('.');
end
fprintf('Done.\n');











