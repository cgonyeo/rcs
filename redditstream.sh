#!/bin/bash
SUBREDDIT="http://www.reddit.com/r/corgi"
NUMPAGES=5
REFRESHRATE=300

while [ 1 ]; do
    PAGEURL=$SUBREDDIT
    PAGECOUNT=1
    echo "updating `date`"
    while [ $PAGECOUNT -lt $NUMPAGES ]; do
        PAGE=`curl -s $PAGEURL | sed 's/!//g'`
        NOLINKS=`echo $PAGE | sed 's_\(http://imgur.com/[a-zA-Z0-9]*\)_\n\1\n_g' | egrep '^http' | egrep -v 'com/a$'`
        NOLINKS=`echo $NOLINKS | sed 's_//imgur_//i.imgur_g' | sed 's_\(.com/[a-zA-Z0-9]*\)_\1.jpg_g'`
        LINKS=`echo $PAGE | sed 's_\(http://i.imgur.com/[a-zA-Z0-9]*.[a-z]*\)_\n\1\n_g' | egrep '^http'`
        for IMAGE in $LINKS
        do
            wget -r -q $IMAGE
        done
        for IMAGE in $NOLINKS
        do
            wget -r -q $IMAGE
        done
        PAGEURL=`echo $PAGE | sed 's_\(http://www.reddit.com/r/corgi/?count=[a-zA-Z0-9&;=_]*\)_\n\1\n_g' | egrep '^http'`
        if ! curl --output /dev/null --silent --head --fail "$PAGEURL";
        then
            PAGEURLS=`echo $PAGE | sed 's_\(http://www.reddit.com/r/corgi/?amp[a-zA-Z0-9&;=_]*\)_\n\1\n_g' | egrep '^http'`
            PAGEURL=`echo "hi $PAGEURLS" | grep -v hi`
        fi
        let PAGECOUNT=PAGECOUNT+1
    done
    echo "Update complete"
    sleep $REFRESHRATE
done
