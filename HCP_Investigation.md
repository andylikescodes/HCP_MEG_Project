## A Complete Investigation of the HCP MEG Preprocessing Pipeline
#### 1. Raw Data Structure
The HCP data is recorded from a MEG system called BTi and later renamed to 4D-Neuroimaging. The company is broke but the system is still running. A BTi/4D dataset directory is different from the exported data. The exported data usually look like this:
* c,rfDC
* e,rfhp1.0Hz
* hc,rfDC
* e,rfhp1.0Hz,COH

The letters before the first comma refer to the recording mode: e for epoched data, c for continuously recorded data, or hc for continuously recorded data with the coils in continuous headmotiontracking mode. The rfXXXX part refers to the hardware filter settings, rfDC meaning no filtering at all, and rfhp1.0Hz means that a 1.0 Hz cutoff high pass filter was applied prior to the digitization of the data. COH (or COH1) refer to the short recording to obtain the positions of the Coils On Head.

Usually a hs_file is available containing a list of coordinates in 3D-space, describing the participants headshape - however, in this case I wasn't able to find it in anywhere. Maybe in the anatomy folder?

1. header file 
    - ft_read_header(c.rfDC) - read the header information that contains the following information from the c.rfDC file: 
        - Fs - sampling frequency
        - nChans - number of channels
        - nSamples - number of samples per trial
        - nSamplesPre - number of pre-trigger samples in each trial?
        - nTrials - number of trials
        - Label - Nx1 cell-array with the label of each channel
        - Chantype - Nx1 cell-array with the channel type, see FT_CHANTYPE
        - Chanunit - Nx1 cell-array with the physical units, see FT_CHANUNIT
        - Some has hdr.orig
        - For continuously recorded data, this will return nSamplesPre = 0 and nTrials = 1

2. events 
    - ft_read_event(c.rfDC) - also read from the c.rfDC file - reads all events from EEG/MEG and return a data structure:
        - event.type
        - event.sample
        - event.value
        - event.offset
        - event. duration
        - event.timestamp
        - might not be found in this dataset

3. electrodes and headshape
    - ft_prepare_layout(cfg=4D248) - readin the electrode sensors info from 4D248.m from the /template folder of in the pipeline.
    - ft_read_headshape(hsname) - readin the hs_file to define the shape of the head in the machine - however, wasn't able to locate the hs_file in the dataset.

headshape visualization:
![headshape visualization](./datacheck/100307_MEG_3-Restin_datacheck_headshape.png)

#### Data Check





