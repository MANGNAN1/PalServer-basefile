#!/bin/bash
# 인게임 Admin 명령어 콘솔창에서 가능하게
Admin_Save() {
    USERNAME=$(whoami)

    ini_file="/home/$USERNAME/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
    # Admin 패스워드 값 추출
    ADMIN_PASSWORD=$(awk '/OptionSettings=/ {match($0, /AdminPassword="([^"]*)"/, arr); print arr[1]}' "$ini_file")
    
    # RCONPort 값 추출
    RCON_PORT=$(awk '/OptionSettings=/ {match($0, /RCONPort=([0-9]+)/, arr); print arr[1]}' "$ini_file")
    
    # 사용자가 입력한 메시지를 'ARRCON'에 전달하여 실행
    echo "save" | ./ARRCON -P $RCON_PORT -p $ADMIN_PASSWORD   
}

echo -e "\e[32m서버를 리붓합니다.\e[0m"

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

Admin_Save

sleep 5

$USER_HOME/Save.sh

screen -S PalServerSession -X stuff $'\003'
steamcmd +login anonymous +app_update 2394010 validate +quit
screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
sleep 3
echo -e "\e[32m리붓 완료.\e[0m"
