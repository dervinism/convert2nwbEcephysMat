% Session-specific NWB parameters
% Parameters that are different for different animals are:
%   sessionID
%   sessionDescription
%   sessionNotes
%   electrodeName
%   nChannelsPerShank
%   areas
%   endCh
%   electrodeCoordinates
%   electrodeImplantationType

% General info
sessionID = {'20181219182543';
             '20181221145727';
             '20181221165147';
             '20190102134858';
             '20190102162201';
             '20190106174515';
             '20190106200423'};
sessionDescription = {'awake restrained';
                      'awake restrained';
                      'anaesthesia';
                      'awake restrained';
                      'anaesthesia';
                      'awake restrained';
                      'anaesthesia'};
sessionNotes = {'Probe @ left VB: -1.5, -1.6, 3.25 mm.   First recording in awake';
                'Second recording in awake followed by isoflurane anaesthesia. Anaesthesia set to 0.75% at the beginning of recording and stays at the the same level until the end of the recording. Applied eye ointment at 8 min. Heating oad went cold around 54 min.Went cold again around 90 min. Eventually stopped recording because of heater not working properly.';
                'Second recording in awake followed by isoflurane anaesthesia. Anaesthesia set to 0.75% at the beginning of recording and stays at the the same level until the end of the recording. Applied eye ointment at 8 min. Heating oad went cold around 54 min.Went cold again around 90 min. Eventually stopped recording because of heater not working properly.';
                'Third recording in awake followed by isoflurane anaesthesia. Two video files. Eye camera kept on crashing. Isoflurane at 1% at the beginning of the anaesthesia session. Two minutes later lowered to 0.75%.';
                'Third recording in awake followed by isoflurane anaesthesia. Two video files. Eye camera kept on crashing. Isoflurane at 1% at the beginning of the anaesthesia session. Two minutes later lowered to 0.75%.';
                'Fourth recording in awake followed by isoflurane anaesthesia. Isoflurane at 0.75% at the beginning of the anaesthesia session.';
                'Fourth recording in awake followed by isoflurane anaesthesia. Isoflurane at 0.75% at the beginning of the anaesthesia session.'};
              
for iSess = 1:numel(sessionID)
  sessionStartTime{iSess} = datetime(str2double(sessionID{iSess}(1:4)), str2double(sessionID{iSess}(5:6)), str2double(sessionID{iSess}(7:8)),...
    str2double(sessionID{iSess}(9:10)), str2double(sessionID{iSess}(11:12)), str2double(sessionID{iSess}(13:14))); %#ok<*SAGROW>
  
  % Probe #1 info
  ref = 1; % probe reference
  probeInserted{ref} = true; % If the probe used at all
  if probeInserted{ref}
    electrodeName{iSess}{ref} = 'CM32-A32-Poly3-5mm-25s-177';
    electrodeDescription{iSess}{ref} = ['Single shank low density probe in position ' num2str(ref)];
    electrodeManufacturer{iSess}{ref} = 'Neuronexus';
    electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '1'];
    if ~exist(electrodeFolder{iSess}{ref}, 'file') % in case a probe is missing
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_' electrodeName{iSess}{ref} '.mat'];
    nShanks{iSess}{ref} = 1;
    nChannelsPerShank{iSess}{ref} = 32;
    nCh{iSess}{ref} = nChannelsPerShank{iSess}{ref}*nShanks{iSess}{ref}; % total number of probe channels
    areas = {'VB'}; % brain areas that this probe spans
    endCh = 32; % Corresponding probe end channels starting from the tip of the probe. Corresponding and previous end channels are used to work out probe channels that reside in the corresponding brain area.
    electrodeLocation{iSess}{ref} = electrodeLocations(areas, endCh, nCh{iSess}{ref}); % Brain area assigned to each recording channel.
    electrodeCoordinates{iSess}{ref} = [-1.5, -1.6, 3.25]; % Electrode insertion location on the cortical surface in Paxinos coords: AP (posterior negative), ML (left negative), DV (recording site position starting with the tip of the probe.
    electrodeCoordinates{iSess}{ref} = repmat(electrodeCoordinates{iSess}{ref}, nCh{iSess}{ref}, 1); % Coordinates of each probe recording channel (the probe rotation angle is not taken into account). Y coordinates are relative to the tip of the probe.
    load(electrodeMap, 'ycoords');
    if size(ycoords,1) == 1
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})'./1000;
    else
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})./1000;
    end
    electrodeLabel{iSess}{ref} = ['probe' num2str(ref)];
    electrodeImplantationType{iSess}{ref} = 'chronic';
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
  probeInserted{ref} = false;
  if probeInserted{ref}
    electrodeName{iSess}{ref} = 'CM32-A1x32-Edge-5mm-100-177';
    electrodeDescription{iSess}{ref} = ['Single shank low density probe in position ' num2str(ref)];
    electrodeManufacturer{iSess}{ref} = 'Neuronexus';
    electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '26'];
    if ~exist(electrodeFolder{iSess}{ref},'file') || numel(dir(electrodeFolder{iSess}{ref})) <= 2 % in case the raw data folder name is shorter
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    if ~exist(electrodeFolder{iSess}{ref}, 'file') % in case a probe is missing
      electrodeFolder{iSess}{ref} = electrodeFolder{iSess}{ref}(1:end-1);
    end
    electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_' electrodeName{iSess}{ref} '.mat'];
    nShanks{iSess}{ref} = 1;
    nChannelsPerShank{iSess}{ref} = 32;
    nCh{iSess}{ref} = nChannelsPerShank{iSess}{ref}*nShanks{iSess}{ref};
    areas = {'VB','Po','LP','DG','CA1'};
    endCh = [7 13 17 26 32];
    electrodeLocation{iSess}{ref} = electrodeLocations(areas, endCh, nCh{iSess}{ref});
    electrodeCoordinates{iSess}{ref} = [-1.8, -0.5, 0];
    electrodeCoordinates{iSess}{ref} = repmat(electrodeCoordinates{iSess}{ref}, nCh{iSess}{ref}, 1);
    load(electrodeMap, 'ycoords');
    if size(ycoords,1) == 1
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})'./1000;
    else
      electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})./1000;
    end
    electrodeLabel{iSess}{ref} = ['probe' num2str(ref)];
    electrodeImplantationType{iSess}{ref} = 'chronic';
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