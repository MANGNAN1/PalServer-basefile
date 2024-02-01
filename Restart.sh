#!/bin/bash
echo -e "\e[32m서버를 리붓합니다.\e[0m"
screen -S PalServerSession -X stuff $'\003'
steamcmd +login anonymous +app_update 2394010 validate +quit
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
echo -e "\e[32m리붓 완료.\e[0m"
