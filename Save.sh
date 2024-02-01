# 디렉토리 경로와 권한 확인
SAVE_DIR="$HOME/backup/saved"
if [ ! -d "$SAVE_DIR" ]; then
	mkdir -p "$SAVE_DIR" || { echo -e "[\033[1;32m서버 구동기\033[0m] 디렉토리 생성 실패: $SAVE_DIR"; exit 1; }
fi

# 현재 날짜와 시간으로 저장 파일명 설정 (월일시간분)
SAVE_NAME="save_$(date +%m%d%H%M).tar.gz"
SAVE_PATH="$SAVE_DIR/$SAVE_NAME"
FOLDER_PATH="$HOME/Steam/steamapps/common/PalServer/Pal/Saved"

# 폴더 압축과 에러 로그 기록
tar -czf "$SAVE_PATH" "$FOLDER_PATH" > /dev/null 2> "$HOME/backup/error.log"
if [ $? -eq 0 ]; then
	echo -e "[\033[1;32m서버 구동기\033[0m] 저장이 완료되었습니다: $SAVE_PATH"
	# 저장 파일 이름을 로그에 기록
	echo "$SAVE_NAME" >> "$HOME/backup/save_list.log"

	# 저장 폴더와 하위 폴더에 모든 권한 부여
	chmod -R 777 "$SAVE_DIR" || { echo -e "[\033[1;32m서버 구동기\033[0m] 권한 변경 실패: $SAVE_DIR"; exit 1; }
else
	echo -e "[\033[1;32m서버 구동기\033[0m] 저장 중 오류가 발생했습니다. 로그를 확인하세요: $HOME/backup/error.log"
	exit 1
fi