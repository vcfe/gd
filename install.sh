#!/bin/bash
rm -rf gd.sh
wget https://github.com/vcfe/gd/raw/master/gd.sh
clear
echo "\n\n\n\n\n输入配置gclone的名称\n"
read -p "gclone config Name:" gclone
sed -i "s/goog/$gclone/g" gd.sh
chmod +x gd.sh
dir=`pwd`
pa=${PATH%%:*}
rm -rf $pa/gd
ln -s $dir/gd.sh $pa/gd
echo "\n配合screen使用效果更佳(可以后台执行)\n"
echo "输入 gd 使用脚本\n输入 gd 使用脚本\n输入 gd 使用脚本\n\n"

