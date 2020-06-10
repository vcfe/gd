#!/bin/bash
rm -rf gd.sh
wget https://github.com/vcfe/gd/raw/master/gd.sh
clear
echo -e "\n\n\n\n\n输入配置gclone的名称"
read -p "gclone config Name:" gclone
sed -i "s/goog/$gclone/g" gd.sh
chmod +x gd.sh
dir=`pwd`
pa=${PATH%%:*}
rm -rf $pa/gd
ln -s $dir/gd.sh $pa/gd
echo -e "\n\n\n\n\n\n\n配合screen使用效果更佳(可以后台执行)"
echo -e "\n\n\n输入 gd 使用脚本"

