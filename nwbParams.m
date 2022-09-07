% NWB parameters common across all animals and recording sessions
% Parameters that may change:
%   dataset

projectName = 'Brainwide Infraslow Activity Dynamics';
experimenter = 'Martynas Dervinis';
institution = 'University of Leicester';
publications = {};
lab = 'Michael Okun lab';
dataset = 'neuropixels';
videoFrameRate = 25; % Hz

% Find the repository root folder
rootFolderName = 'convert2nwbMatNpx';
cfd = mfilename('fullpath');
startInd = strfind(cfd, rootFolderName);
rootFolder = cfd(1:startInd+numel(rootFolderName)-1);

% Assign data folders
if strcmpi(dataset, 'neuronexus')
  rawDataFolder = [rootFolder filesep 'nnx_raw_derived_data']; % Raw and certain derived Neuronexus data for all animals
  derivedDataFolder = [rootFolder filesep 'nnx_derived_data']; % Neuroscience Gateway analysis scripts, functions, and downloaded processed Neuronexus data for all animals
  derivedDataFolderNWB = [rootFolder filesep 'nnx_derived_data_nwb']; % Derived Neuronexus data for all animals placed in NWB format
elseif strcmpi(dataset, 'neuropixels')
  rawDataFolder = [rootFolder filesep 'npx_raw_derived_data']; % Raw and certain derived Neuropixels data for all animals
  derivedDataFolder = [rootFolder filesep 'npx_derived_data']; % Neuroscience Gateway analysis scripts, functions, and downloaded processed Neuropixels data for all animals
  derivedDataFolderNWB = [rootFolder filesep 'npx_derived_data_nwb']; % Derived Neuropixels data for all animals placed in NWB format
end