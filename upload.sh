configs=("i3" "rofi" "polybar" "nvim" "fish" "fisher")
rm -rf $(dirname $0)/config/*
for i in ${configs[@]}
do
    cp -rf ~/.config/$i $(dirname $0)/config/
done
