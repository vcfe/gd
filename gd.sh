#!/bin/bash
copy(){
gclone copy goog:{$1} goog:"$2" --drive-server-side-across-configs -v
}
folder(){
gclone lsd goog:$2|awk -v sz=$1 'NR==sz {print$5}'
}
option(){
name=`folder $list`
echo -e "\n\n确认请回车\n\n输入其他字符将在此 $name 下创建新文件夹并copy\n"
read -p "保存到 $name/$foname 这个文件夹？" list2
if [ -z $list2 ] ; then
    echo "保存至    $name/$foname"
    copy $link "$name/$foname"
    check "$name/$foname"
else
    echo "保存至    $name/$list2"
    copy $link $name/$list2
    check $name/$list2
fi
}
check(){
clear
echo -e "\n\n\n\n操作完成。。。。\n\n\n\n\n开始数据比对....."
gclone check goog:{$link} goog:"$1" --disable ListR
echo -e "完成。\n\n\n"
echo "去重进行中......(删除较旧文件)"
gclone dedupe oldest goog:"$1"
echo "完成。"
}
read -p """输入分享链接
     请输入 ~>:""" link
if [ -z $link ] ;then
    echo "不允许输入为空"
    exit
else
    :
fi
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
fname=$(gclone lsd goog:{$link} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $4}')
foname=$(gclone lsd goog:{$link} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $8}')
clear
[ -z "$foname" ] && echo "无效链接" && exit || [ $link != $fname ] && echo "链接无效，检查是否有权限" && exit
echo -e "\n\n为了操作快捷,简便,只支持选择一级目录\n二级目录需要手动创建"
gclone lsd goog:|awk '{print "     ",NR,"     ",$5}'
echo -e "\n\n确认保存根目录请回车\n\n输入其他字符将在此目录下创建新文件夹并copy\n"
echo -e "此资源目录为 $foname\n\n"
read -p "     选择文件夹 ~>: " list
case $list in
    [1-9])
    option;;
    [1-9][0-9])
    option;;
        *)
        echo "保存至    $list/$foname"
        gclone copy goog:{$link} goog:"$list/$foname" --drive-server-side-across-configs -v
	check "$list/$foname"
esac 
