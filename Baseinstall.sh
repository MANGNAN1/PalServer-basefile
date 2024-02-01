#!/bin/bash
#Start.sh Stop.sh Restart.sh Update.sh 디렉토리 설치 

echo "베이스 파일들을 설치합니다."
chmod +w ~
wget https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Start.sh
wget https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Restart.sh
wget https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Stop.sh
wget https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile/main/Update.sh
echo "완료."

#dos2unix 설치
echo "dos2uni를 설치합니다."
sudo apt-get update
sudo apt-get install dos2unix
echo "완료."

#윈도우sh -> 리눅스sh 변환
echo "sh 파일 변환을 실행합니다."
dos2unix /Start.sh
dos2unix /Stop.sh
dos2unix /Restart.sh
dos2unix /Update.sh
echo "완료."

#명령어 한글화
echo "명령어 한글화를 진행합니다."
alias 서버시작="~/Start.sh"
alias 서버종료="~/Stop.sh"
alias 서버리붓="~/Restart.sh"
alias 업데이트="~/Update.sh"
echo "완료."

#새로고침
source ~/.bashrc

echo "모든 작업을 완료하였습니다."