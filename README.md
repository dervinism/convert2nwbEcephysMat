# convert2nwbMatNpx
Matlab functions to convert extracellular electrophysiology recordings and associated behavioural data to Neurodata Without Borders (NWB) file format: Neuropixels example.

In order to download this repository, you will have to install [GIN](https://gin.g-node.org/G-Node/Info/wiki) client. You can find the installation instructions [here](https://gin.g-node.org/G-Node/Info/wiki/GIN+CLI+Setup).

To download the repository execute the following lines in your command line:
```
gin get dervinism/convert2nwbMatNpx
cd convert2nwbMatNpx
gin get-content
```

In order to execute the Matlab code, you will also need to download the [matnwb repository](https://github.com/NeurodataWithoutBorders/matnwb) and add it to your Matlab path.

Once you have downloaded and installed all the required dependencies you can execute convert2nwb script in Matlab. This should convert the example data into NWB format and store it inside the npx_derived_data_nwb folder. If you want to adapt the code for your own puprposes, have a look at the code and the comments inside Matlab scritps and functions.

**Keywords:** Neurodata Without Borders; NWB; matnwb; extracellular electrophysiology; ecephys; Neuropixels; silicone probe; extracellular electrode; spiking; FAIR principles; open science.