#!/bin/bash
echo -e "\e[32m서버를 구동합니다.\e[0m"
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
echo -e "\e[32m구동완료.\e[0m"
