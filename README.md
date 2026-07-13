# **Introduction to using relational hyperevent models to study criminal networks** 
Code used for data processing, description, and RHEM modelling in Diviák, T. & J. Lerner. (2026). Introduction to using relational hyperevent models to study criminal networks. *Global Crime*. [https://doi.org/10.1080/17440572.2026.2689945]

**SarcladDescriptives.R**: descriptive analysis of a network focusing on its structure, visualisation, and analysing the frequency of events over time. The analysed datasets are  stored in two sheets ('edgelist' and 'attributes') in *Sarclad_relEvents.xlsx*.

**SarcladProcessing.R**: data processing of the originally coded data (see the data for descriptive analysis above) into the eventnet format for Relational Hyperevent Model (RHEM). This produces *SarcladRHEM.csv*.

**SarcladRHEM.R**, **UScooffRHEM.R**: fitting Cox Proportional Hazard to the data generated in event from the processed data files, specifically to *SarcladRHEM_EMAILS_RANDOM_SENDER.txt* (the first script), and *UScooffSubsetEventsUp_PROPERTY.txt* and *UScooffSubsetEventsUp_VIOLENCE.txt* (in the second script). **NOTE** - the latter two files are not in the repository because they are rather large. In case of interest, contact the main author for access.

**Sarclad_configGW.txt**, **UScooff.config.txt**: configuration files for specifying the output of eventnet (for details on eventnet and RHEM in general, see [Jürgen Lerner's GitHub page](https://github.com/juergenlerner/eventnet).

The repository contains the exact datasets used to estimate the relational hyperevent models reported in the manuscript.

The open-source dataset, the Sarclad corruption network, is provided in its original form.

The US metropolitan co-offending dataset, **UScooffSubsetEventsUp.txt** is a publicly releasable subset of violent and property co-offences derived from confidential source data under a data-sharing agreement. Prior to release, identifying information and additional protected content were removed or transformed in accordance with the agreement. The original data and the preprocessing pipeline cannot be shared. However, all descriptive analyses and data processing follows the logic in **SarcladDescriptives.R** and **SarcladProcessing.R**.
