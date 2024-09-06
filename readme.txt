# dconf

## load, dump, reset

cat dconf.ini | dconf load /
dconf dump / > dconf.ini
dconf reset -f /

## extensions

gext install 4269 1262 779 1634 6385

## chrome flags

chrome://flags/#overlay-scrollbars
chrome://flags/#ozone-platform-hint