% Session-specific NWB parameters
% Parameters that are different for different animals are:
%   sessionID
%   sessionDescription
%   sessionNotes
%   electrodeName
%   areas
%   endCh
%   electrodeImplantationType

% General info
sessionID = {'20190205085751';
             '20190208100404';
             '20190208110536';
             '20190212095950';
             '20190212111502';
             '20190215112507';
             '20190215123537';
             '20190222104514';
             '20190312165540'};
sessionDescription = {'awake restrained';
                      'awake restrained';
                      'anaesthesia';
                      'awake restrained';
                      'anaesthesia';
                      'awake restrained';
                      'anaesthesia';
                      'awake restrained';
                      'awake restrained'};
sessionNotes = {'Advancing to 3967.4 um on z-axis and 1040.6 on x-axis but the probe is moving 15 degrees to the z-axis.   Using z-axis instead of the virtual axis coordinates as the latter are incorrectly calculated in the manipulator.   Second probe advanced to 966.2 um in z and 290.8 in x. Also moving at 15 degrees angle.   1st recording 3 hours restrained and no anaesthesia.';
                '2nd recording 50 minutes restaint followed by 1 hour and 40 minutes of isoflurane anaesthesia starting at 0.75%.   At 10 mins of anaesthesia recording there briefly appears 50 Hz noise and isoflurane flow is increased to 1% beacause the animal started waking up.';
                '2nd recording 50 minutes restaint followed by 1 hour and 40 minutes of isoflurane anaesthesia starting at 0.75%.   At 10 mins of anaesthesia recording there briefly appears 50 Hz noise and isoflurane flow is increased to 1% beacause the animal started waking up.';
                '3rd recording 1 hour restrained followed by 2 hours of isoflurane anaesthesia at 0.75%. Increased to 1% after 15 mins.';
                '3rd recording 1 hour restrained followed by 2 hours of isoflurane anaesthesia at 0.75%. Increased to 1% after 15 mins.';
                '4th recording 1 hour restrained followed by 2 hours of isoflurane anaesthesia at 1%. May need to cut off initial 5 mins of anaesthesia recording due to missing channels.';
                '4th recording 1 hour restrained followed by 2 hours of isoflurane anaesthesia at 1%. May need to cut off initial 5 mins of anaesthesia recording due to missing channels.';
                '5th recording 2 hours restrained and no anaesthesia.';
                ''};
              
for iSess = 1:numel(sessionID)
  sessionStartTime{iSess} = datetime(str2double(sessionID{iSess}(1:4)), str2double(sessionID{iSess}(5:6)), str2double(sessionID{iSess}(7:8)),...
    str2double(sessionID{iSess}(9:10)), str2double(sessionID{iSess}(11:12)), str2double(sessionID{iSess}(13:14))); %#ok<*SAGROW>
  
  % Probe #1 info
  ref = 1; % probe reference
  electrodeName{iSess}{ref} = 'CM16LP-A1x16-Poly2-5mm-50s-177';
  electrodeDescription{iSess}{ref} = ['Single shank low density probe in position ' num2str(ref)];
  electrodeManufacturer{iSess}{ref} = 'Neuronexus';
  electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '1'];
  electrodeMap = [electrodeFolder{iSess}{ref} filesep 'forPRB_' electrodeName{iSess}{ref} '.mat'];
  nShanks{iSess}{ref} = 1;
  nChannelsPerShank{iSess}{ref} = 16;
  nCh{iSess}{ref} = nChannelsPerShank{iSess}{ref}*nShanks{iSess}{ref}; % total number of probe channels
  areas = {'S1'}; % brain areas that this probe spans
  endCh = 16; % Corresponding probe end channels starting from the tip of the probe. Corresponding and previous end channels are used to work out probe channels that reside in the corresponding brain area.
  electrodeLocation{iSess}{ref} = electrodeLocations(areas, endCh, nCh{iSess}{ref}); % Brain area assigned to each recording channel.
  electrodeCoordinates{iSess}{ref} = [-1.8, -2.5, 0]; % Electrode insertion location on the cortical surface in Paxinos coords: AP (posterior negative), ML (left negative), DV (recording site position starting with the tip of the probe.
  electrodeCoordinates{iSess}{ref} = repmat(electrodeCoordinates{iSess}{ref}, nCh{iSess}{ref}, 1); % Coordinates of each probe recording channel (the probe rotation angle is not taken into account). Y coordinates are relative to the tip of the probe.
  load(electrodeMap, 'ycoords');
  if size(ycoords,1) == 1
    electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})'./1000;
  else
    electrodeCoordinates{iSess}{ref}(:,3) = ycoords(1:nCh{iSess}{ref})./1000;
  end
  electrodeLabel{iSess}{ref} = ['probe' num2str(ref)];
  electrodeImplantationType{iSess}{ref} = 'chronic';
  
  % Probe #2 info
  ref = 2;
  electrodeName{iSess}{ref} = 'CM32-A1x32-Edge-5mm-100-177';
  electrodeDescription{iSess}{ref} = ['Single shank low density probe in position ' num2str(ref)];
  electrodeManufacturer{iSess}{ref} = 'Neuronexus';
  electrodeFolder{iSess}{ref} = [animalRawDataFolder filesep sessionID{iSess} '26'];
  if ~exist(electrodeFolder{iSess}{ref},'file') || numel(dir(electrodeFolder{iSess}{ref})) <= 2
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