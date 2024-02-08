#!/bin/bash
# 디렉토리 경로와 권한 확인
    # 찾고자 하는 프로세스의 이름
    process_name="PalServer-Linux-Test"

    # ps 명령어로 프로세스 확인하고 grep으로 검색
    if ps aux | grep -v grep | grep "$process_name" > /dev/null
		then
		Admin save

		sleep 3

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
    else
        echo -e "\e[32m서버를 구동중이지 않습니다 SAVE명령을 취소합니다.\e[0m"
    fi   

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
