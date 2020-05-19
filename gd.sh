#!/bin/bash
copy(){
gclone copy google:{$1} google:$2 --drive-server-side-across-configs -v
}
folder(){
gclone lsd google:$2|awk -v sz=$1 'NR==sz {print$5}'
}

read -p """输入分享链接
     请输入 ~>:""" link
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}

echo -e "为了操作快捷,简便,只支持选择一级目录\n二级目录需要手动创建"
gclone lsd google:|awk '{print "     ",NR,"     ",$5}'
echo -e "确认请回车\n\n输入其他字符将在此目录下创建新文件夹并copy\n"
read -p "     选择文件夹 ~>: " list
case $list in
    [1-9][0-9])
        name=`folder $list`
        #gclone lsd google:$name|awk '{print NR,$5}'
        echo -e "确认请回车\n\n输入其他字符将在此 $name 下创建新文件夹并copy\n"
        read -p "保存到 $name 这个文件夹？" list2
        copy $link $name"/"$list2
        ;;
        *)
        gclone copy google:{$link} google:$list --drive-server-side-across-configs -v
esac
        