#!/bin/bash
#
# Wikivoyage2OSM
#
# Extract Wikivoyage Points Of Interest (POI), validate them, and generate OpenStreetMap (OSM) and CSV files.
# Reference: https://en.wikivoyage.org/wiki/Wikivoyage:Listings
# To make URLs clickable in CSV files, search for 'http.*' and replace with '=HYPERLINK("&")' as per https://forum.openoffice.org/en/forum/viewtopic.php?f=9&t=18313#p83972
#
# Usage ./wikivoyage.sh enwikivoyage-20131130-pages-articles.xml
#
# License: GNU-GPLv3
# Website: https://github.com/nicolas-raoul/wikivoyage2osm
# Tracker: https://github.com/nicolas-raoul/wikivoyage2osm/issues
# Results: https://sourceforge.net/p/wikivoyage

####################################################
# Settings begin
####################################################

# Target file (unit test if none given).
XML=${1:-rattanakosin.xml}

cat $XML |\
tr '\n' ' ' |\
awk -vRS='<title>' -vORS='\n<title>' 1 |\
awk -vRS='</title>' -vORS='\n</title>' 1 |\
grep --before-context=1 "\*'''" |\
grep "^<title>" |\
grep -v ":" |\
sed -e "s/<title>/*\[\[/;s/$/\]\]/" \
> out.wikicode
