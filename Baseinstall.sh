#!/bin/bash
# 사용자의 홈 디렉토리로 이동합니다.
cd "$HOME" || exit

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

#Start.sh Stop.sh Restart.sh Update.sh Manual.sh 설치 

#echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"
#curl -o Start.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Start.sh
#curl -o Restart.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Restart.sh
#curl -o Stop.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Stop.sh
#curl -o Update.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Update.sh
#curl -o Manual.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Manual.sh
#curl -o Save.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Save.sh
#curl -o Reserve.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Reserve.sh
#curl -o Vminstall.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Vminstall.sh
#echo -e "\e[32m완료.\e[0m"

#실행권한 획득
#chmod +x $USER_HOME/Start.sh $USER_HOME/Stop.sh $USER_HOME/Restart.sh $USER_HOME/Update.sh $USER_HOME/Manual.sh $USER_HOME/Save.sh $USER_HOME/Reserve.sh $USER_HOME/Vminstall.sh

# dos2unix 설치 여부 확인
#if command -v dos2unix &> /dev/null; then
#    echo "dos2unix가 이미 설치되어 있습니다. 넘어갑니다."
#else
    # dos2unix 설치
#    echo "dos2unix를 설치합니다."
#    sudo apt-get update
#    sudo apt-get install dos2unix
#    echo "dos2unix 설치가 완료되었습니다."
#fi

#윈도우sh -> 리눅스sh 변환
#echo -e "\e[32msh 파일 변환을 실행합니다.\e[0m"
#dos2unix $USER_HOME/Start.sh
#dos2unix $USER_HOME/Stop.sh
#dos2unix $USER_HOME/Restart.sh
#dos2unix $USER_HOME/Update.sh
#dos2unix $USER_HOME/Manual.sh
#dos2unix $USER_HOME/Save.sh
#dos2unix $USER_HOME/Reserve.sh
#dos2unix $USER_HOME/Vminstall.sh
#echo -e "\e[32m완료.\e[0m"

#명령어 한글화
# .bashrc 파일에서 명령어 갱신
update_bashrc() {
    # .bashrc 파일 경로
    bashrc_path="$HOME/.bashrc"

    # 기존 명령어 삭제
    sed -i '/# 명령어 한글화/,/# 완료./d' "$bashrc_path"

    # 추가할 내용
    append_text="# 명령어 한글화
alias 서버시작=\"$USER_HOME/Baseinstall.sh 서버시작\"
alias 서버종료=\"$USER_HOME/Baseinstall.sh 서버종료\"
alias 서버리붓=\"$USER_HOME/Baseinstall.sh 서버리붓\"
alias 업데이트=\"$USER_HOME/Baseinstall.sh 업데이트\"
#alias 사용법=\"$USER_HOME/Baseinstall.sh 사용법\"
alias 저장=\"$USER_HOME/Baseinstall.sh 저장\"
alias 예약=\"$USER_HOME/Baseinstall.sh 예약\"
alias 최초설치=\"$USER_HOME/Baseinstall.sh 최초설치\"
#alias 사용법="$USER_HOME/Baseinstall.sh && Baseinstall.sh Manual"
# 완료.


    # 파일 끝에 내용 추가
    echo "$append_text" >> "$bashrc_path"
    echo -e "\e[32m갱신되었습니다.\e[0m"

    # 변경사항 즉시 적용
    source "$bashrc_path"
    source ~/.bashrc
}

# 함수 실행
update_bashrc

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
# 사용자로부터 입력 받기
read -p "작업을 추가하려면 '예약추가', 제거하려면 '예약제거', 예약리스트를 보시려면 '리스트', 취소하려면 '취소'를 입력하세요: " action

if [ "$action" == "예약추가" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)
    
    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME/Restart.sh"
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (예: 0 */12 * * *): " cron_expression

    # cron 표현식을 crontab에 추가
    (crontab -l ; echo "$cron_expression $USER_HOME") | crontab -

    echo "작업이 추가되었습니다."
elif [ "$action" == "예약제거" ]; then
    #Crontab list
    crontab -r

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

#새로고침
source ~/.bashrc

# 사용자 입력 확인
case "$1" in
  "사용법")
    Manual
    ;;
  "예약")
    Reserve
    ;;
  "서버리붓")
    Restart
    ;;
  "저장")
    Save
    ;;
  "서버시작")
    Start
    ;;
  "서버종료")
    Stop
    ;;
  "업데이트")
    Update
    ;;
  "최초설치")
    Vminstall
    ;;
  *)


echo -e "\e[32m모든 작업을 완료하였습니다.\e[0m"
echo -e " "
echo -e "\e[31m마지막으로 아래 코드를 복사해서 붙혀넣기하고 엔터를 눌러주세요.\e[0m"
echo -e "\e[31msource ~/.bashrc\e[0m"
echo -e " "
echo -e "\e[32m사용법을 입력하시면 사용가능한 명령어가 나옵니다.\e[0m"

    ;;
esac
