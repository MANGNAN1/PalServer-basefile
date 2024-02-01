#!/bin/bash
# 사용자의 홈 디렉토리로 이동합니다.
cd "$HOME" || exit

#Start.sh Stop.sh Restart.sh Update.sh Manual.sh 설치 

echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"
chmod +w ~
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Start.sh
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Restart.sh
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Stop.sh
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Update.sh
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Manual.sh
wget -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Save.sh
echo -e "\e[32m완료.\e[0m"

#실행권한 획득
chmod +x ~/Start.sh ~/Stop.sh ~/Restart.sh ~/Update.sh ~/Manual.sh ~/Save.sh

#dos2unix 설치
echo -e "\e[32mdos2uni를 설치합니다.\e[0m"
sudo apt-get update
sudo apt-get install dos2unix
echo -e "\e[32m완료.\e[0m"

#새로고침
source ~/.bashrc

#윈도우sh -> 리눅스sh 변환
echo -e "\e[32msh 파일 변환을 실행합니다.\e[0m"
dos2unix ~/Start.sh
dos2unix ~/Stop.sh
dos2unix ~/Restart.sh
dos2unix ~/Update.sh
dos2unix ~/Manual.sh
dos2unix ~/Save.sh
echo -e "\e[32m완료.\e[0m"

#명령어 한글화
echo -e "\e[32m명령어 한글화를 진행합니다.\e[0m"
alias 서버시작="~/Start.sh"
alias 서버종료="~/Stop.sh"
alias 서버리붓="~/Restart.sh"
alias 업데이트="~/Update.sh"
alias 사용법="~/Manual.sh"
alias 저장="~/Save.sh"
echo -e "\e[32m완료.\e[0m"

#새로고침
source ~/.bashrc

echo -e "\e[32m모든 작업을 완료하였습니다.\e[0m"
