@echo off

set "USERNAME=계정명"
set "WINDOWS_DEFENDER=C:\Program Files\Windows Defender\MpCmdRun.exe"
set "TARGET_FOLDER=C:\Users\%USERNAME%\Desktop\파일반입"
set "LIST_FILE=C:\Users\%USERNAME%\Desktop\blackfile.txt"

rem 디렉토리 이동
cd /d "%TARGET_FOLDER%"

echo 검사 전 파일 압축을 모두 풀어주세요!
echo.

echo =============================
echo      반입 파일 검사
echo =============================

echo.
echo --- 반입 불가 도구 확인... ---
for /f "usebackq eol=# delims=" %%F in ("%LIST_FILE%") do (
	dir /s /b *%%F* 2>nul
)

echo.
echo --- 메일 관련 파일 확인... ---
dir /s /b *.eml 2>nul || echo EML 파일을 찾을 수 없습니다.
dir /s /b *.pst 2>nul || echo PST 파일을 찾을 수 없습니다.
dir /s /b *.ost 2>nul || echo OST 파일을 찾을 수 없습니다.
dir /s /b *.msg 2>nul || echo MSG 파일을 찾을 수 없습니다.
dir /s /b *.oft 2>nul || echo OFT 파일을 찾을 수 없습니다.

echo.
echo --- EXE 파일 확인... ---
dir /s /b *.exe 2>nul || echo EXE 파일을 찾을 수 없습니다.

echo.
echo =============================
echo      윈도우 디펜더 검사
echo =============================

rem eicar.txt X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H* 백신 테스트용
FOR /R "%TARGET_FOLDER%" %%F IN (*.*) DO (
    "C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "%%F" -DisableRemediation >nul 2>&1
    
    if ERRORLEVEL 2 (
        echo [탐지됨] %%F
    )
)

echo.
echo 검사가 종료되었습니다!
pause
