#!/bin/bash
screen -S PalServerSession -X stuff $'\003'
steamcmd +login anonymous +app_update 2394010 validate +quit
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"