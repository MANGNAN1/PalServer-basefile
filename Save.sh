# 디렉토리 경로와 권한 확인
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
