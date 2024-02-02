#!/bin/bash

#OS 방화벽 개방
sudo apt update

#방화벽 개방 명령어 실행
echo -e "\e[32mOS 방화벽을 개방합니다.\e[0m"
sudo iptables -I INPUT -p tcp --dport 27015 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 27016 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 25575 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 27015 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 27016 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 25575 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 8211 -j ACCEPT
echo -e "\e[32m설치완료.\e[0m"

#방화벽 개방 확인
sudo iptables -S

#Steam 설치 
#Steam CMD install
echo -e "\e[32mSteam CMD 설치합니다.\e[0m"
sudo add-apt-repository multiverse; sudo dpkg --add-architecture i386; sudo apt update
sudo apt install steamcmd
echo -e "\e[32m설치완료.\e[0m"

#GameEngine 설치
echo -e "\e[32mGameEngine 설치합니다.\e[0m"
steamcmd +login anonymous +app_update 2394010 validate +quit
echo -e "\e[32m설치완료.\e[0m"

#SDK64 설치
echo -e "\e[32mSDK64 설치합니다.\e[0m"
mkdir -p ~/.steam/sdk64/
steamcmd +login anonymous +app_update 1007 +quit
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/
echo -e "\e[32m설치완료.\e[0m"

#Initial 실행 (최초 1회 실행)
echo -e "\e[32m최초 1회 서버를 구동합니다.\e[0m"
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
echo -e "\e[32m구동완료.\e[0m"

echo -e "\e[32m최초 1회 서버를 종료합니다.\e[0m"
screen -S PalServerSession -X stuff $'\003'
echo -e "\e[32m종료 완료.\e[0m"