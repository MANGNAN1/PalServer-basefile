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
    echo -e "\e[96m╔══════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║  자동백업 예약을 추가하려면 '백업예약추가'   ║\e[0m"    
    echo -e "\e[96m║  자동리붓 예약을 추가하려면 '리붓예약추가'   ║\e[0m"
    echo -e "\e[96m║  모든 예약을 제거하려면 '예약제거'           ║\e[0m"
    echo -e "\e[96m║  예약 리스트를 보시려면 '리스트'             ║\e[0m"
    echo -e "\e[96m║  취소하려면 '취소'                           ║\e[0m"
    echo -e "\e[96m╚══════════════════════════════════════════════╝\e[0m"

# 사용자로부터 입력 받기
read -p "명령어를 입력하세요: " action

if [ "$action" == "리붓예약추가" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)

    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"
    
    # 존재하는 크론탭 내용을 가져와 변수에 저장
    EXISTING_CRONTAB=$(crontab -l 2>/dev/null)

    # 삭제할 크론탭 예약을 포함한 문자열
    TARGET_CRON="Restart"
    
    # 새로운 크론탭 예약을 추가할 표현식
    NEW_CRONTAB="$USER_HOME/Function.sh && Restart"

    echo -e "\e[96m╔═══════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║ \e[93m* * * * *  실행할 명령어                                  ║\e[0m"
    echo -e "\e[96m║                                                           ║\e[0m"
    echo -e "\e[96m║ \e[92m┌───────────────────── 분 (0 - 59)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ ┌─────────────────── 시 (0 - 23)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ ┌───────────────── 일 (1 - 31)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ ┌─────────────── 월 (1 - 12)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ ┌───────────── 요일 (0 - 6)                       ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ │                                                 ║\e[0m"
    echo -e "\e[96m║ \e[92m* * * * * │                                               ║\e[0m"
    echo -e "\e[96m║ \e[92mEX) 0 */12 * * * = 00시 기준 12시간마다 저장 00시 12시    ║\e[0m"    
    echo -e "\e[96m║ \e[92mEX) 0 */8 * * * = 00시 기준 8시간마다 저장 00시 8시 16시  ║\e[0m"  
    echo -e "\e[96m║ \e[92mEX) 0 * * * * = 매시 0분 마다 저장                        ║\e[0m"   
    echo -e "\e[96m║ \e[92mEX) 0,30 * * * * = 매시 0분, 30분 마다 저장               ║\e[0m"      
    echo -e "\e[96m╚═══════════════════════════════════════════════════════════╝\e[0m"    
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (EX: 0 */12 * * *): " cron_expression

# 기존 크론탭에 삭제할 예약이 있는지 확인
if [[ -n "$EXISTING_CRONTAB" && "$EXISTING_CRONTAB" == *"$TARGET_CRON"* ]]; then
    # 삭제할 예약이 포함된 줄을 크론탭에서 제외하고 설정
    (echo "$EXISTING_CRONTAB" | grep -v "$TARGET_CRON") | crontab -
    #echo "기존에 존재하던 리붓 예약이 삭제되었습니다."
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "리붓 예약이 추가되었습니다."	

else
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "리붓 예약이 추가되었습니다."
fi

elif [ "$action" == "백업예약추가" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)

    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"
    
    # 존재하는 크론탭 내용을 가져와 변수에 저장
    EXISTING_CRONTAB=$(crontab -l 2>/dev/null)

    # 삭제할 크론탭 예약을 포함한 문자열
    TARGET_CRON="Save"
    
    # 새로운 크론탭 예약을 추가할 표현식
    NEW_CRONTAB="$USER_HOME/Function.sh && Save"

    echo -e "\e[96m╔═══════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║ \e[93m* * * * *  실행할 명령어                                  ║\e[0m"
    echo -e "\e[96m║                                                           ║\e[0m"
    echo -e "\e[96m║ \e[92m┌───────────────────── 분 (0 - 59)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ ┌─────────────────── 시 (0 - 23)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ ┌───────────────── 일 (1 - 31)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ ┌─────────────── 월 (1 - 12)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ ┌───────────── 요일 (0 - 6)                       ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ │                                                 ║\e[0m"
    echo -e "\e[96m║ \e[92m* * * * * │                                               ║\e[0m"
    echo -e "\e[96m║ \e[92mEX) 0 */12 * * * = 00시 기준 12시간마다 저장 00시 12시    ║\e[0m"    
    echo -e "\e[96m║ \e[92mEX) 0 */8 * * * = 00시 기준 8시간마다 저장 00시 8시 16시  ║\e[0m"  
    echo -e "\e[96m║ \e[92mEX) 0 * * * * = 매시 0분 마다 저장                        ║\e[0m"   
    echo -e "\e[96m║ \e[92mEX) 0,30 * * * * = 매시 0분, 30분 마다 저장               ║\e[0m"      
    echo -e "\e[96m╚═══════════════════════════════════════════════════════════╝\e[0m" 
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (EX: 0,30 * * * *): " cron_expression

# 기존 크론탭에 삭제할 예약이 있는지 확인
if [[ -n "$EXISTING_CRONTAB" && "$EXISTING_CRONTAB" == *"$TARGET_CRON"* ]]; then
    # 삭제할 예약이 포함된 줄을 크론탭에서 제외하고 설정
    (echo "$EXISTING_CRONTAB" | grep -v "$TARGET_CRON") | crontab -
    #echo "기존에 존재하던 리붓 예약이 삭제되었습니다."
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "백업 예약이 추가되었습니다."	
else
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "백업 예약이 추가되었습니다."
fi
    
elif [ "$action" == "예약제거" ]; then
    #Crontab list
    crontab -r
    echo "작업이 제거되었습니다."

elif [ "$action" == "리스트" ]; then
    crontab -l

elif [ "$action" == "취소"||"c" ]; then
    exit 0 
else
    echo "올바른 명령을 입력하세요."
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

# 세팅 함수
Setting() {
    echo -e "\e[32m세팅 편집기로 진입하기 전 설명드립니다.\e[0m"
    echo -e "\e[32m세팅 변경을 원하시면 서버가 OFf 상태여야 합니다.\e[0m"    
    echo -e "\e[32m원하시는 옵션을 변경하신 후 컨트롤 + x 로 저장을 하신 후 Y 엔터 눌러서 편집기에서 빠져나오시면 됩니다. \e[0m"    

    # 사용자에게 y 또는 n으로 답변을 받는 함수
    ask_yes_no() {
        while true; do
            read -p "$1 (y/n): " answer
            case $answer in
                [Yy]* ) return 0;;  # 사용자가 y로 응답
                [Nn]* ) return 1;;  # 사용자가 n으로 응답
                * ) echo "y 또는 n으로 답하세요.";;
            esac
        done
    }
    
    # 사용자에게 y 또는 n으로 묻기
    if ask_yes_no "작업을 진행하시겠습니까?"; then
        #echo "사용자가 y로 응답함 - 작업을 진행합니다."
        nano ~/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
    else
        #echo "사용자가 n으로 응답함 - 작업을 취소합니다."
        return 1
    fi
}
