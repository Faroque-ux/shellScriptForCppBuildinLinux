#! /bin/bash
cd /home/faroque
decrypted_result=$(./.decode.sh U2FsdGVkX1+A18tIyEpcOb+WXyQmZbUl6JwaABrcKT8=)
cd /home/faroque/SRC

git pull "https://faroque.jakaria:$decrypted_result@https://sample.git"
cpp2unix BL Clean
cd /home/faroque/BL_TRUNK_26TH_JUL/Clean
source compileenvd
make -j12 -f debug.build full >> test1.log

build_result="PASSED"
search_string="completed generation 28"

grep "$search_string" test1.log
if [[ $? -eq 0 ]]; then
    build_result="PASSED"
else
    build_result="FAILED"
fi

recipient1="Faroque.Jakaria@test.com"
recipient2="abc@test.com"
recipient3="xyz@test.com"
subject="Debug build - $build_result"
body="This is a test email from my build script."

tar -cvf logFile.tar ./test1.log
tar -cvzf logFile.tar.gz logFile.tar

rm /home/faroque/BL_TRUNK_26TH_JUL/Clean/test1.log
echo "$body" | mutt -s "$subject" -a "/home/faroque/BL_TRUNK_26TH_JUL/Clean/logFile.tar.gz" -- "$recipient1","$recipient2","$recipient3"
