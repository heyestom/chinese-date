# Aribic and corrisponding Chinese numerals
declare -a aribic_numerals=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13"
                            "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "29" "30" "31")
declare -a chinese_numerals=("零" "一" "二" "三" "四" "五" "六" "七" "八" "九" "十" "十一" "十二" "十三"
    "十四" "十五" "十六" "十七" "十八" "十九" "二十" "二十一" "二十三" "二十四" "二十四" "二十六" "二十七" "二十八" "二十九" "三十" "三十一")

# decalre a sudo 'map'
# thank you stackoverflow http://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
for i in `seq 0 ${#aribic_numerals[@]}`;
do
  aribic="${aribic_numerals[$i]}"
  chinese="${chinese_numerals[$i]}"
  declare "aribic_to_chinese_map_$aribic=$chinese"
done

getFromMap() {
    local array=$1 index=$2
    local i="${array}_$index"
    printf '%s' "${!i}"
}

day_of_the_week=$(date "+%w"); # 0 = sunday

# Chinese days are numbered ascendingly from monday which is 1 or ‘一 yi'
# except sunday which is '天 tian'
if [ $day_of_the_week = "0" ]; then
  day_of_the_week=天
else
  day_of_the_week=$(getFromMap aribic_to_chinese_map $day_of_the_week)
fi

day=$(getFromMap aribic_to_chinese_map $(date "+%_d" | tr -d '[[:space:]]'));
month=$(getFromMap aribic_to_chinese_map $(date "+%_m" | tr -d '[[:space:]]'));
year=$(date "+%Y");

# without using printf the day/month/year became '??????'
echo 你好！今天是$(printf $year)年$(printf $month)月$(printf $day)日, 星期$(printf $day_of_the_week)。;
