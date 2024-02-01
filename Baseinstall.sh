#!/bin/bash
# 사용자의 홈 디렉토리로 이동합니다.
cd "$HOME" || exit

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

#Start.sh Stop.sh Restart.sh Update.sh Manual.sh 설치 

#echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"
#chmod +w ~
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Start.sh
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Restart.sh
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Stop.sh
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Update.sh
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Manual.sh
#wget --no-clobber https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Save.sh
#echo -e "\e[32m완료.\e[0m"

echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"
curl -o Start.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Start.sh
curl -o Restart.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Restart.sh
curl -o Stop.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Stop.sh
curl -o Update.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Update.sh
curl -o Manual.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Manual.sh
curl -o Save.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Save.sh
curl -o Reserve.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Reserve.sh
echo -e "\e[32m완료.\e[0m"

#실행권한 획득
chmod +x $USER_HOME/Start.sh $USER_HOME/Stop.sh $USER_HOME/Restart.sh $USER_HOME/Update.sh $USER_HOME/Manual.sh $USER_HOME/Save.sh $USER_HOME/Reserve.sh

#dos2unix 설치
echo -e "\e[32mdos2uni를 설치합니다.\e[0m"
sudo apt-get update
sudo apt-get install dos2unix
echo -e "\e[32m완료.\e[0m"

#새로고침
source ~/.bashrc

#윈도우sh -> 리눅스sh 변환
echo -e "\e[32msh 파일 변환을 실행합니다.\e[0m"
dos2unix $USER_HOME/Start.sh
dos2unix $USER_HOME/Stop.sh
dos2unix $USER_HOME/Restart.sh
dos2unix $USER_HOME/Update.sh
dos2unix $USER_HOME/Manual.sh
dos2unix $USER_HOME/Save.sh
dos2unix $USER_HOME/Reserve.sh
echo -e "\e[32m완료.\e[0m"

#명령어 한글화
# .bashrc 파일에서 명령어 갱신
update_bashrc() {
    # .bashrc 파일 경로
    bashrc_path="$HOME/.bashrc"

    # 기존 명령어 삭제
    sed -i '/# 명령어 한글화/,/# 완료./d' "$bashrc_path"

    # 추가할 내용
    append_text="# 명령어 한글화
alias 서버시작=\"$USER_HOME/Start.sh\"
alias 서버종료=\"$USER_HOME/Stop.sh\"
alias 서버리붓=\"$USER_HOME/Restart.sh\"
alias 업데이트=\"$USER_HOME/Update.sh\"
alias 사용법=\"$USER_HOME/Manual.sh\"
alias 저장=\"$USER_HOME/Save.sh\"
alias 예약=\"$USER_HOME/Reserve.sh\"
# 완료.
"

    # 파일 끝에 내용 추가
    echo "$append_text" >> "$bashrc_path"
    echo -e "\e[32m갱신되었습니다.\e[0m"

    # 변경사항 즉시 적용
    source "$bashrc_path"
    source ~/.bashrc
}

# 함수 실행
update_bashrc

#새로고침
source ~/.bashrc

echo -e "\e[32m모든 작업을 완료하였습니다.\e[0m"

#echo -e "\e[31m마지막으로 아래 코드를 복사해서 붙혀넣기하고 엔터를 눌러주세요.\e[0m"
#echo -e "\e[31msource ~/.bashrc\e[0m"
echo -e "\e[32m사용법을 입력하시면 사용가능한 명령어가 나옵니다.\e[0m"

