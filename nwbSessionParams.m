% Session-specific NWB parameters
% Parameters that are different for different animals are:
%   sessionID
%   sessionDescription
%   sessionNotes
%   areas
%   endCh
%   probeInserted
%   electrodeName
%   nChannelsPerShank
%   electrodeCoordinates
%   electrodeImplantationType

% General info
sessionID = {'20200324161349'};
sessionDescription = {'anaesthesia'};
sessionNotes = {'Probe 1:   X      Y Z      D   1064.7 0 3992.4 4113.9.   Probe 2:   X      Y Z      D   1061.7 0 3918.7 4113.9.   Anaesthesia recording with 0.5% isoflurane, heater set to 43 degrees, and the temperature probe showing 37.8 degrees. Increased isoflurane to 0.75% at minute 21.'};
endCh{1}{1} = [88 117 149 342 384]; % Corresponding probe end channels starting from the tip of the probe. Corresponding and previous end channels are used to work out probe channels that reside in the corresponding brain area.
endCh{1}{2} = [41 091 138 217 304 384];

for iSess = 1:numel(sessionID)
  sessionStartTime{iSess} = datetime(str2double(sessionID{iSess}(1:4)), str2double(sessionID{iSess}(5:6)), str2double(sessionID{iSess}(7:8)),...
    str2double(sessionID{iSess}(9:10)), str2double(sessionID{iSess}(11:12)), str2double(sessionID{iSess}(13:14))); %#ok<*SAGROW>
  
  % Probe #1 info
  ref = 1; % probe reference
  probeInserted{iSess}{ref} = true; % If the probe used at all
  if probeInserted{iSess}{ref} && ~isempty(endCh{iSess}{ref})
    electrodeName{iSess}{ref} = 'Neuropixels 1.0';
    electrodeDescription{iSess}{ref} = ['Single shank high density probe in position ' num2str(ref)];
    electrodeManufacturer{iSess}{ref} = 'imec';
    electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '1'];
    if ~exist(electrodeFolder{iSess}{ref}, 'file') % in case a probe is missing
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    if contains(electrodeName{iSess}{ref}, 'neuropixels', 'IgnoreCase',true)
      electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_Neuropixels.mat'];
    else
      electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_' electrodeName{iSess}{ref} '.mat'];
    end
    load(electrodeMap, 'ycoords');
    nShanks{iSess}{ref} = 1;
    nChannelsPerShank{iSess}{ref} = 384;
    nChannelsPerShank{iSess}{ref} = min([numel(ycoords) nChannelsPerShank{iSess}{ref}]);
    nCh{iSess}{ref} = nChannelsPerShank{iSess}{ref}*nShanks{iSess}{ref}; % total number of probe channels
    areas = {'VB','LP','LGN','CA3','S1'}; % brain areas that this probe spans
    electrodeLocation{iSess}{ref} = electrodeLocations(areas, endCh{iSess}{ref}, nCh{iSess}{ref}); % Brain area assigned to each recording channel.
    electrodeCoordinates{iSess}{ref} = [-1.8, -2.5, 0]; % Electrode insertion location on the cortical surface in Paxinos coords: AP (posterior negative), ML (left negative), DV (recording site position starting with the tip of the probe.
    electrodeCoordinates{iSess}{ref} = repmat(electrodeCoordinates{iSess}{ref}, nCh{iSess}{ref}, 1); % Coordinates of each probe recording channel (the probe rotation angle is not taken into account). Y coordinates are relative to the tip of the probe.
    if size(ycoords,1) == 1
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})'./1000;
    else
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})./1000;
    end
    electrodeLabel{iSess}{ref} = ['probe' num2str(ref)];
    electrodeImplantationType{iSess}{ref} = 'acute';
  else % The case when the probe #1 is missing
    electrodeName{iSess}{ref} = []; %#ok<*UNRCH>
    electrodeDescription{iSess}{ref} = [];
    electrodeManufacturer{iSess}{ref} = [];
    electrodeFolder{iSess}{ref} = [];
    nShanks{iSess}{ref} = [];
    nChannelsPerShank{iSess}{ref} = [];
    nCh{iSess}{ref} = [];
    electrodeLocation{iSess}{ref} = [];
    electrodeCoordinates{iSess}{ref} = [];
    electrodeLabel{iSess}{ref} = [];
    electrodeImplantationType{iSess}{ref} = [];
  end
  
  % Probe #2 info
  ref = 2;
  probeInserted{iSess}{ref} = true;
  if probeInserted{iSess}{ref} && ~isempty(endCh{iSess}{ref})
    electrodeName{iSess}{ref} = 'Neuropixels 1.0';
    electrodeDescription{iSess}{ref} = ['Single shank high density probe in position ' num2str(ref)];
    electrodeManufacturer{iSess}{ref} = 'imec';
    electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '26'];
    if ~exist(electrodeFolder{iSess}{ref},'file') || numel(dir(electrodeFolder{iSess}{ref})) <= 2 % in case the raw data folder name is shorter
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    if ~exist(electrodeFolder{iSess}{ref}, 'file') % in case a probe is missing
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    if strcmpi(electrodeFolder{iSess}{1}, electrodeFolder{iSess}{2})
      probeInserted{iSess}{ref} = false;
      continue
    end
    if contains(electrodeName{iSess}{ref}, 'neuropixels', 'IgnoreCase',true)
      electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_Neuropixels.mat'];
    else
      electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_' electrodeName{iSess}{ref} '.mat'];
    end
    load(electrodeMap, 'ycoords');
    nShanks{iSess}{ref} = 1;
    nChannelsPerShank{iSess}{ref} = 384;
    nChannelsPerShank{iSess}{ref} = min([numel(ycoords) nChannelsPerShank{iSess}{ref}]);
    nCh{iSess}{ref} = nChannelsPerShank{iSess}{ref}*nShanks{iSess}{ref};
    areas = {'VB','Po','LP','DG','CA1','RSC'};
    electrodeLocation{iSess}{ref} = electrodeLocations(areas, endCh{iSess}{ref}, nCh{iSess}{ref});
    electrodeCoordinates{iSess}{ref} = [-1.8, -0.5, 0];
    electrodeCoordinates{iSess}{ref} = repmat(electrodeCoordinates{iSess}{ref}, nCh{iSess}{ref}, 1);
    if size(ycoords,1) == 1
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})'./1000;
    else
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})./1000;
    end
    electrodeLabel{iSess}{ref} = ['probe' num2str(ref)];
    electrodeImplantationType{iSess}{ref} = 'acute';
  else % The case when the probe #2 is missing
    electrodeName{iSess}{ref} = []; %#ok<*UNRCH>
    electrodeDescription{iSess}{ref} = [];
    electrodeManufacturer{iSess}{ref} = [];
    electrodeFolder{iSess}{ref} = [];
    nShanks{iSess}{ref} = [];
    nChannelsPerShank{iSess}{ref} = [];
    nCh{iSess}{ref} = [];
    electrodeLocation{iSess}{ref} = [];
    electrodeCoordinates{iSess}{ref} = [];
    electrodeLabel{iSess}{ref} = [];
    electrodeImplantationType{iSess}{ref} = [];
  end
end



%% Local functions
function electrodeLocationVec = electrodeLocations(areas, endCh, nCh)
% electrodeLocationVec = electrodeLocations(areas, endCh, nCh)
% Function assigns brain area to a channel

for iCh = 1:nCh
  areaInd = find(endCh >= iCh,1);
  electrodeLocationVec{iCh} = areas{areaInd};
end
end