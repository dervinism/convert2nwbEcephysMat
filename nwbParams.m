% NWB parameters common across all animals and recording sessions
% Parameters that may change:
%   dataset

projectName = 'Brainwide Infraslow Dynamics';
experimenter = 'MD';
institution = 'University of Leicester';
publications = {};
lab = 'Michael Okun lab';
dataset = 'neuronexus';
videoFrameRate = 25; % Hz

% Find the repository root folder
rootFolderName = 'infraslow-dynamics';
cfd = mfilename('fullpath');
startInd = strfind(cfd, 'infraslow-dynamics');
rootFolder = cfd(1:startInd+numel(rootFolderName)-1);

% Assign data folders
if strcmpi(dataset, 'neuronexus')
  rawDataFolder = [rootFolder filesep '03_data' filesep '001_uol_neuronexus_exp_raw_derived']; % Raw and certain derived Neuronexus data for all animals
  derivedDataFolder = [rootFolder filesep '04_data_analysis' filesep '001_uol_neuronexus_exp' filesep 'runNSG']; % Neuroscience Gateway analysis scripts, functions, and downloaded processed Neuronexus data for all animals
  derivedDataFolderNWB = [rootFolder filesep '03_data' filesep '001_uol_neuronexus_exp' filesep 'NWB']; % Derived Neuronexus data for all animals placed in NWB format
elseif strcmpi(dataset, 'neuropixels')
  rawDataFolder = [rootFolder filesep '03_data' filesep '002_uol_neuropixels_exp_raw_derived']; % Raw and certain derived Neuropixels data for all animals
  derivedDataFolder = [rootFolder filesep '04_data_analysis' filesep '002_uol_neuropixels_exp' filesep 'runNSG']; % Neuroscience Gateway analysis scripts, functions, and downloaded processed Neuropixels data for all animals
  derivedDataFolderNWB = [rootFolder filesep '03_data' filesep '002_uol_neuropixels_exp' filesep 'NWB']; % Derived Neuropixels data for all animals placed in NWB format
end