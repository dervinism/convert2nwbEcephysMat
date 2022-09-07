% NWB parameters for an animal
% Parameters that are likely to change:
%   animalID
%   dob
%   firstProcedureDate
%   sex
%   weight
%   description

animalID = 'M200324_MD';
dob = '20200206'; % yyyymmdd
dob = datetime(str2double(dob(1:4)), str2double(dob(5:6)), str2double(dob(7:8))); % Convert to datetime format
firstProcedureDate = '20200324'; % yyyymmdd
firstProcedureDate = datetime(str2double(firstProcedureDate(1:4)), str2double(firstProcedureDate(5:6)), str2double(firstProcedureDate(7:8)));
ageInDays = floor(etime(datevec(firstProcedureDate),datevec(dob))/(3600*24));
age = ['P' num2str(ageInDays) 'D']; % Convert to ISO8601 format: https://en.wikipedia.org/wiki/ISO_8601#Durations
strain = 'C57BL/6J';
sex = 'M';
species = 'Mus musculus';
weight = [];
description = '025'; % Animal testing order.
animalRawDataFolder = [rawDataFolder filesep animalID]; % Raw and certain derived data for the animal. Probe map and unit waveforms files are stored here.
animalDerivedDataFile = [derivedDataFolder filesep animalID filesep animalID '.mat']; % Spiking, behavioural, and certain analysis data produced after running analyses routines on the Neuroscience Gateway Portal are stored here in a single mat file.
animalDerivedDataFolderNWB = [derivedDataFolderNWB filesep animalID]; % The output folder: The location where derived data after converting to the NWB format is stored.