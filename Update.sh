#!/bin/bash
echo -e "\e[32m서버를 업데이트합니다.\e[0m"
steamcmd +login anonymous +app_update 2394010 validate +quit
echo -e "\e[32m업데이트 완료.\e[0m"
