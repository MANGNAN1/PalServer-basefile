# 함수 정의: Manual 출력
Manual() {
  echo -e "\e[96m╔════════════════════════════════════════╗\e[0m"
  echo -e "\e[96m║  입력 가능한 명령어                    ║\e[0m"
  echo -e "\e[96m║  \e[93m최초설치                              ║\e[0m"
  echo -e "\e[96m║  \e[92m서버시작                              ║\e[0m"
  echo -e "\e[96m║  \e[91m서버종료                              ║\e[0m"
  echo -e "\e[96m║  \e[93m서버리붓                              ║\e[0m"
  echo -e "\e[96m║  \e[98m서버복구                              ║\e[0m"  
  echo -e "\e[96m║  \e[94m업데이트                              ║\e[0m"
  echo -e "\e[96m║  \e[95m예약                                  ║\e[0m"
  echo -e "\e[96m║  \e[97m세팅                                  ║\e[0m"
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
    NEW_CRONTAB="$USER_HOME/Restart.sh >> $USER_HOME/logfile.log 2>&1"

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
    NEW_CRONTAB="$USER_HOME/Save.sh >> $USER_HOME/logfile.log 2>&1"

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
    
    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)
    
    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"
    
    $USER_HOME/Save.sh

    screen -S PalServerSession -X stuff $'\003'
    sleep 5
    steamcmd +login anonymous +app_update 2394010 validate +quit
    screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS EpicApp=PalServer"
    echo -e "\e[32m리붓 완료.\e[0m"
}

# 파일 저장 함수
Save() {
SAVE_DIR="$HOME/backup/saved"
MAX_BACKUPS=30

if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR" || { echo -e "\e[91m디렉터리 생성 실패: $SAVE_DIR\e[0m"; exit 1; }
fi

# 현재 날짜와 시간으로 저장 파일명 설정 (월일시간분)
SAVE_NAME="$(date +%m%d%H%M).tar.gz"
SAVE_PATH="$SAVE_DIR/$SAVE_NAME"
FOLDER_PATH="$HOME/Steam/steamapps/common/PalServer/Pal/Saved"

# 폴더 압축과 에러 로그 기록
tar -czf "$SAVE_PATH" "$FOLDER_PATH"

if [ $? -eq 0 ]; then
    echo -e "\e[32m저장이 완료되었습니다: $SAVE_PATH\e[0m"

    # 저장 폴더와 하위 폴더에 모든 권한 부여
    chmod -R 777 "$SAVE_DIR" || { echo -e "\e[91m권한 변경 실패: $SAVE_DIR\e[0m"; exit 1; }

    # 백업 데이터 개수가 MAX_BACKUPS를 넘으면 가장 오래된 데이터 삭제
    while [ $(ls -1 "$SAVE_DIR" | grep -c '.tar.gz') -gt $MAX_BACKUPS ]; do
        OLDEST_FILE=$(ls -1t "$SAVE_DIR" | grep '.tar.gz' | tail -n 1)
        rm -f "$SAVE_DIR/$OLDEST_FILE"
        echo -e "\e[33m가장 오래된 백업 데이터 삭제: $OLDEST_FILE\e[0m"
    done
    
else
    echo -e "\e[91m저장 중 오류가 발생했습니다. 로그를 확인하세요: $HOME/backup/error.log\e[0m"
    exit 1
fi
}

# 서버 시작 함수
Start() {
    echo -e "\e[32m서버를 구동합니다.\e[0m"
    screen -S PalServerSession -dm bash -c "cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS EpicApp=PalServer"
    sleep 5
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

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)
    
    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"

    # 기본 세팅파일
    echo "[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=None,DayTimeSpeedRate=1.000000,NightTimeSpeedRate=1.000000,ExpRate=1.000000,PalCaptureRate=1.000000,PalSpawnNumRate=1.000000,PalDamageRateAttack=1.000000,PalDamageRateDefense=1.000000,PlayerDamageRateAttack=1.000000,PlayerDamageRateDefense=1.000000,PlayerStomachDecreaceRate=1.000000,PlayerStaminaDecreaceRate=1.000000,PlayerAutoHPRegeneRate=1.000000,PlayerAutoHpRegeneRateInSleep=1.000000,PalStomachDecreaceRate=1.000000,PalStaminaDecreaceRate=1.000000,PalAutoHPRegeneRate=1.000000,PalAutoHpRegeneRateInSleep=1.000000,BuildObjectDamageRate=1.000000,BuildObjectDeteriorationDamageRate=1.000000,CollectionDropRate=1.000000,CollectionObjectHpRate=1.000000,CollectionObjectRespawnSpeedRate=1.000000,EnemyDropItemRate=1.000000,DeathPenalty=All,bEnablePlayerToPlayerDamage=False,bEnableFriendlyFire=False,bEnableInvaderEnemy=True,bActiveUNKO=False,bEnableAimAssistPad=True,bEnableAimAssistKeyboard=False,DropItemMaxNum=3000,DropItemMaxNum_UNKO=100,BaseCampMaxNum=128,BaseCampWorkerMaxNum=15,DropItemAliveMaxHours=1.000000,bAutoResetGuildNoOnlinePlayers=False,AutoResetGuildTimeNoOnlinePlayers=72.000000,GuildPlayerMaxNum=20,PalEggDefaultHatchingTime=2.000000,WorkSpeedRate=1.000000,bIsMultiplay=False,bIsPvP=False,bCanPickupOtherGuildDeathPenaltyDrop=False,bEnableNonLoginPenalty=True,bEnableFastTravel=True,bIsStartLocationSelectByMap=True,bExistPlayerAfterLogout=False,bEnableDefenseOtherGuildPlayer=False,CoopPlayerMaxNum=4,ServerPlayerMaxNum=32,ServerName="Default Palworld Server",ServerDescription="",AdminPassword="12341234",ServerPassword="",PublicPort=8211,PublicIP="",RCONEnabled=True,RCONPort=25575,Region="",bUseAuth=True,BanListURL="https://api.palworldgame.com/api/banlist.txt")" > /home/$USERNAME/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
}

# 세팅 함수
Setting() {
    # 색상 및 스타일 정의
    BOLD_GREEN="\e[1;32m"
    BOLD_YELLOW="\e[1;33m"
    RESET="\e[0m"

    # 에코 문구 출력
    echo -e "${BOLD_GREEN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD_GREEN}║ 세팅 편집기로 진입하기 전 설명드립니다.                ║${RESET}"
    echo -e "${BOLD_GREEN}║ 세팅 변경을 하시기 전에는 서버가 ${BOLD_YELLOW}OFF${BOLD_GREEN} 상태여야 합니다.  ║${RESET}"    
    echo -e "${BOLD_GREEN}║ 원하시는 옵션을 변경하신 후 ${BOLD_YELLOW}Ctrl + X${BOLD_GREEN} 로 저장을 하신 후 ║${RESET}"    
    echo -e "${BOLD_GREEN}║ ${BOLD_YELLOW}Y 엔터${BOLD_GREEN} 눌러서 편집기에서 빠져나오시면 됩니다.          ║${RESET}"    
    echo -e "${BOLD_GREEN}╚════════════════════════════════════════════════════════╝${RESET}"    

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
        nano ~/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
    else
        return 1
    fi
}

# 서버 구동 확인
Servercheck() {
# PalServer.sh 프로세스가 실행 중인지 확인
if pgrep -f "PalServer.sh" > /dev/null; then
    echo "서버가 구동중입니다."
else
    echo "서버가 구동중이지 않습니다."
fi
}

# 서버 백업데이터 복구
Restore() {

# 설명서
echo -e "\e[96m╔═════════════════════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[96m║\e[1m 서버 데이터 복구 작업 전 설명드립니다. \e[0m                             \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 서버 데이터 복구 시 반드시 서버가 OFF상태여야합니다.\e[0m                \e[96m║\e[0m"
echo -e "\e[96m║                                                                     \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 현재 보관 중인 상위 5개의 백업 데이터 리스트를 확인합니다.         \e[0m \e[96m║\e[0m"
echo -e "\e[96m║\e[1m EX) save_02041546.tar.gz \e[0m                                           \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 원하시는 날짜 EX) 02041546 를 입력하시면 그 데이터로 복구을 합니다.\e[0m \e[96m║\e[0m"
echo -e "\e[96m╚═════════════════════════════════════════════════════════════════════╝\e[0m"

# PalServer.sh 프로세스가 실행 중인지 확인
if pgrep -f "PalServer.sh" > /dev/null; then
    echo "서버가 구동중입니다. 복구 시스템을 종료합니다."
    return 1
else
    echo "서버가 구동중이지 않습니다. 복구 시스템을 계속 진행합니다."
    echo ""
fi

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

BACKUP_DIR="$USER_HOME/backup/saved"

# 최신 5개의 파일 리스트 표시
echo "최신 5개의 복구 데이터 리스트:"
ls -t "$BACKUP_DIR" | head -n 5

# 사용자로부터 날짜 입력 받기
read -p "복구할 데이터의 날짜를 입력하세요 (MMDDHHMM): " restore_date

# 입력 받은 날짜에 해당하는 복구 데이터 찾기
restore_file="$BACKUP_DIR/save_$restore_date.tar.gz"

# 복구 데이터가 존재하는지 확인
if [ -f "$restore_file" ]; then
    # 복구 작업 수행
    echo "선택한 날짜의 복구 데이터를 찾았습니다. 복구을 시작합니다..."
    # 복구 명령어를 여기에 추가
    tar -xzf "$restore_file" -C /
else
    echo "해당 날짜의 복구 데이터를 찾을 수 없습니다. 복구을 종료합니다."
fi
}

# 공지 함수
Broadcast1() {
    USERNAME=$(whoami)

    local user_message=$1  # 함수에 전달된 첫 번째 인자를 변수로 사용

    ini_file="/home/$USERNAME/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
    # Admin 패스워드 값 추출
    ADMIN_PASSWORD=$(awk '/OptionSettings=/ {match($0, /AdminPassword="([^"]*)"/, arr); print arr[1]}' "$ini_file")
    
    # RCONPort 값 추출
    RCON_PORT=$(awk '/OptionSettings=/ {match($0, /RCONPort=([0-9]+)/, arr); print arr[1]}' "$ini_file")

    # 추출된 값 출력
    #echo "AdminPassword: $ADMIN_PASSWORD"
    #echo "RCONPort: $RCON_PORT"

    # 사용자에게 메시지 입력 받기
    #read -r -p "할말: " user_message
    
    # 사용자가 입력한 메시지를 'ARRCON'에 전달하여 실행
    echo "broadcast $user_message" | ./ARRCON -P $RCON_PORT -p $ADMIN_PASSWORD   
}

# 공지 함수
Broadcast() {
    USERNAME=$(whoami)

    local user_message=$1  # 함수에 전달된 첫 번째 인자를 변수로 사용

    ini_file="/home/$USERNAME/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
    # Admin 패스워드 값 추출
    ADMIN_PASSWORD=$(awk '/OptionSettings=/ {match($0, /AdminPassword="([^"]*)"/, arr); print arr[1]}' "$ini_file")
    
    # RCONPort 값 추출
    RCON_PORT=$(awk '/OptionSettings=/ {match($0, /RCONPort=([0-9]+)/, arr); print arr[1]}' "$ini_file")

    # MCRCON을 사용하여 RCON 명령어를 전송
    mcrcon -H 127.0.0.1 -P $RCON_PORT -p $ADMIN_PASSWORD "broadcast $user_message"
}

# 인게임 Admin 명령어 콘솔창에서 가능하게
Admin() {
    USERNAME=$(whoami)

    local user_message=$1  # 함수에 전달된 첫 번째 인자를 변수로 사용

    ini_file="/home/$USERNAME/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
    # Admin 패스워드 값 추출
    ADMIN_PASSWORD=$(awk '/OptionSettings=/ {match($0, /AdminPassword="([^"]*)"/, arr); print arr[1]}' "$ini_file")
    
    # RCONPort 값 추출
    RCON_PORT=$(awk '/OptionSettings=/ {match($0, /RCONPort=([0-9]+)/, arr); print arr[1]}' "$ini_file")

    # 추출된 값 출력
    #echo "AdminPassword: $ADMIN_PASSWORD"
    #echo "RCONPort: $RCON_PORT"

    # 사용자에게 메시지 입력 받기
    #read -r -p "할말: " user_message
    
    # 사용자가 입력한 메시지를 'ARRCON'에 전달하여 실행
    echo "$user_message" | ./ARRCON -P $RCON_PORT -p $ADMIN_PASSWORD   
}
