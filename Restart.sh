#!/bin/bash
echo -e "\e[32m서버를 리붓합니다.\e[0m"

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

$USER_HOME/Save.sh

screen -S PalServerSession -X stuff $'\003'
steamcmd +login anonymous +app_update 2394010 validate +quit
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
sleep 5
echo -e "\e[32m리붓 완료.\e[0m"
