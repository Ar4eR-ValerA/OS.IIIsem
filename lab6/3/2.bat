sc stop DNScache
timeout /t 5 /nobreak > NUL
sc query | find "SERVICE_NAME" > "%~dp0services2.txt"
sc start DNScache