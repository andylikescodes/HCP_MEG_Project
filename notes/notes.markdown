## Performed a number of sanitychecks:

### There are something that is quite interesting to look into:
1. They chop the data into 1024 sample snippets, and they are saying that the correlation is likely to fail because of the resampling, and the correlation only reflect the very low frequency fluctuations - kind of the idea that we had before for doing the analysis?
    - Basically the data was broken down into small chunks and analysis was run seperately on these data snippets. This way we can calculate the statistics in each small snippet which gives us some temporal resolution about how the low frequency data are like.

2. So after a closer look at the different configurations of processing the data, they seperated the cfg into 4 sections:
    - the first cfg is just to create a container
    - 1st cfg general preprocessing, no demeaning first to get the low frequency stuff
    - 2nd cfg for the time course of the line noise
    - 3rd cfg for the detection of jumps
    - 4th cfg for the analysis of low frequency
        - So found out that this is just a simple variance of the data. However, need to figure out what the epoch # means?
        - 
    - cfgf for the spectral analysis

3. So there is actually a branch for different analysis and statistics, so that the data doesn't get mixed up in this case 

4. Average correlation with neighbours: They defined the neighbor distance as 0.035. Fieldtrip to prepare the neighbor distribution.

### Need to look into there things:
1. What is line noise? - The frequency that is injected by the environment?
    - Turns out that line noise is the frequency of the power from electric socket. European standard of 220-240 volts is at 50Hz. (so I guess in the HCP case, it will be European standard 50Hz :WRONG:)
    - North american standard of AC is at 60Hz. (So the data is actually collected in North America, which is 60Hz)
2. What's the purpose of demeaning the data?
    - I guess using demean enable good visualization of the data? Because the signal is going to be around zero. However, what if we actually have thos squid jumps and bad segments and bad channels that can affect the mean so much? I am feeling that this kind of things doesn't work well for any analysis algorithms. Guess this needs to be clarify.
3. What are squid jumps?
    - Squid jumps are caused by instability of the electrodes - a high burst of activity.
4. EOG (Horizontal (H, left, right) and Vertical(V, up, down) EOG), ECG at right collarbone and left collarbone, reference electrode on your face, and the GND at the back of your neck.
5.    
