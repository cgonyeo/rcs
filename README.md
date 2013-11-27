rcs
===

Usage: ./redditstream.sh {subreddit} {number of pages} {time between updates}

The Reddit Content Stream. Watches a given subreddit for imgur links and 
downloads all it sees.

Run the script, there are variables to modify at the top to change some things.

Every x seconds it will go through the first x pages of the given subreddit,
and download all imgur links it finds. Albums are not supported.

You can do whatever you want with these pictures, I installed shotwell and have
it watch for new files and display a slideshow of the images
