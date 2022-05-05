yt-dlp \
   --config-location "~/.config/youtube-dl/config" \
   -a ~/.config/youtube-archive/youtube-dl-channels.txt | \
   grep --invert-match 'already been recorded'
