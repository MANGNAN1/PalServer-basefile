# 함수 정의: Manual 출력
Manual() {
  echo -e "\e[96m╔════════════════════════════════════════╗\e[0m"
  echo -e "\e[96m║  입력 가능한 명령어                    ║\e[0m"
  echo -e "\e[96m║  \e[93m최초 설치                             ║\e[0m"
  echo -e "\e[96m║  \e[92m서버 시작                             ║\e[0m"
  echo -e "\e[96m║  \e[91m서버 종료                             ║\e[0m"
  echo -e "\e[96m║  \e[93m서버 리부팅                           ║\e[0m"
  echo -e "\e[96m║  \e[94m업데이트                              ║\e[0m"
  echo -e "\e[96m║  \e[95m예약                                  ║\e[0m"
  echo -e "\e[96m╚════════════════════════════════════════╝\e[0m"
}

# 예약 함수
Reserve() {

#예약 설명서 에코
    echo -e "\e[96m╔════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║  자동리붓 예약을 추가하려면 '예약추가' ║\e[0m"
    echo -e "\e[96m║  제거하려면 '예약제거'                 ║\e[0m"
    echo -e "\e[96m║  리스트를 보시려면 '리스트'            ║\e[0m"
    echo -e "\e[96m║  취소하려면 '취소'                     ║\e[0m"
    echo -e "\e[96m╚════════════════════════════════════════╝\e[0m"

# 사용자로부터 입력 받기
read -p "명령어를 입력하세요: " action

if [ "$action" == "예약추가" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)
    
    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME/Function.sh && Restart"
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (예: 0 */12 * * *): " cron_expression

    # cron 표현식을 crontab에 추가
    (crontab -l ; echo "$cron_expression $USER_HOME") | crontab -

    echo "작업이 추가되었습니다."
elif [ "$action" == "예약제거" ]; then
    #Crontab list
    crontab -r

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)
    
    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME/Function.sh && Save"

    # cron 표현식을 crontab에 추가
    (crontab -l ; echo "0,30 * * * * $USER_HOME") | crontab -

    echo "작업이 제거되었습니다."

elif [ "$action" == "리스트" ]; then
    crontab -l

elif [ "$action" == "취소" ]; then
    exit 0 
else
    echo "올바른 명령을 입력하세요 (예약추가 또는 예약제거 또는 리스트 또는 취소)."
fi
}

# 서버리붓 함수
Restart() {
    echo -e "\e[32m서버를 리붓합니다.\e[0m"
    screen -S PalServerSession -X stuff $'\003'
    steamcmd +login anonymous +app_update 2394010 validate +quit
    screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
    echo -e "\e[32m리붓 완료.\e[0m"
}

# 파일 저장 함수
Save() {
SAVE_DIR="$HOME/backup/saved"

if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR" || { echo -e "\e[91m디렉터리 생성 실패: $SAVE_DIR\e[0m"; exit 1; }
fi

#echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"

# 현재 날짜와 시간으로 저장 파일명 설정 (월일시간분)
SAVE_NAME="save_$(date +%m%d%H%M).tar.gz"
SAVE_PATH="$SAVE_DIR/$SAVE_NAME"
FOLDER_PATH="$HOME/Steam/steamapps/common/PalServer/Pal/Saved"

# 폴더 압축과 에러 로그 기록
tar -czf "$SAVE_PATH" "$FOLDER_PATH" > /dev/null 2> "$HOME/backup/error.log"

if [ $? -eq 0 ]; then
    echo -e "\e[32m저장이 완료되었습니다: $SAVE_PATH\e[0m"

    # 저장 파일 이름을 로그에 기록
    echo "$SAVE_NAME" >> "$HOME/backup/save_list.log"

    # 저장 폴더와 하위 폴더에 모든 권한 부여
    chmod -R 777 "$SAVE_DIR" || { echo -e "\e[91m권한 변경 실패: $SAVE_DIR\e[0m"; exit 1; }
else
    echo -e "\e[91m저장 중 오류가 발생했습니다. 로그를 확인하세요: $HOME/backup/error.log\e[0m"
    exit 1
fi
}

# 서버 시작 함수
Start() {
    echo -e "\e[32m서버를 구동합니다.\e[0m"
    screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
    echo -e "\e[32m구동완료.\e[0m"
}

# 서버 종료 함수
Stop() {
echo -e "\e[32m서버를 종료합니다.\e[0m"
screen -S PalServerSession -X stuff $'\003'
echo -e "\e[32m종료 완료.\e[0m"
}

# 서버 엔진 업데이트 함수
Update() {
    echo -e "\e[32m서버를 업데이트합니다.\e[0m"
    steamcmd +login anonymous +app_update 2394010 validate +quit
    echo -e "\e[32m업데이트 완료.\e[0m"
}

# 최초 vm세팅 함수
Vminstall() {
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
    sleep 10
    echo -e "\e[32m구동완료.\e[0m"
    
    echo -e "\e[32m최초 1회 서버를 종료합니다.\e[0m"
    screen -S PalServerSession -X stuff $'\003'
    echo -e "\e[32m종료 완료.\e[0m"
}
