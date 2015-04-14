if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

cd <%= node[:app_root] %>
