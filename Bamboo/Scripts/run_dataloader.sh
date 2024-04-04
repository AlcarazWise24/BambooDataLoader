#!/bin/bash

# Path to the Data Loader executable
DATALOADER_CONSOLE="/Users/davidalcarazgarcia/Documents/WiseWolves/Bamboo/dataloader_v60.0.1/dataloader_console"

# Configuration directory containing process-conf.xml and config.properties
CONFIG_DIR="/Users/davidalcarazgarcia/Documents/WiseWolves/Bamboo/dataloader_v60.0.1/Bamboo/Conf"

# Execute Data Loader in batch mode
"$DATALOADER_CONSOLE" "$CONFIG_DIR" upsertAccount run.mode=batch
