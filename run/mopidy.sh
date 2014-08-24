#!/bin/bash

if [ -n "$SPOTIFY_PASSWORD" ]; then
    sed -i "s/password = demo/password = $SPOTIFY_PASSWORD/g" /etc/mopidy/mopidy.conf
fi

if [ -n "$SPOTIFY_USERNAME" ]; then
    sed -i "s/username = demo/username = $SPOTIFY_USERNAME/g" /etc/mopidy/mopidy.conf
fi

if [ -n "$SOUNDCLOUD_TOKEN" ]; then
  echo "\n[soundcloud]\nauth_token = $SOUNDCLOUD_TOKEN\n" >> /etc/mopidy.cond
fi


exec sudo -u mopidy mopidy --config /etc/mopidy/mopidy.conf
