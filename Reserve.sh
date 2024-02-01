#!/bin/bash

# 사용자로부터 입력 받기
read -p "작업을 추가하려면 '예약추가', 제거하려면 '예약제거'를 입력하세요: " action

if [ "$action" == "예약추가" ]; then
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (예: 0 */12 * * *): " cron_expression

    # 스크립트 경로 입력 받기
    read -p "실행할 스크립트의 경로를 입력하세요: " script_path

    # cron 표현식을 crontab에 추가
    (crontab -l ; echo "$cron_expression $script_path") | crontab -

    echo "작업이 추가되었습니다."
elif [ "$action" == "예약제거" ]; then
    # 사용자로부터 cron 표현식 입력 받기
    read -p "제거할 Cron 표현식을 입력하세요: " cron_expression

    # 해당 cron 표현식을 crontab에서 제거
    (crontab -l | grep -v "$cron_expression") | crontab -

    echo "작업이 제거되었습니다."
else
    echo "올바른 명령을 입력하세요 (예약추가 또는 예약제거)."
fi
