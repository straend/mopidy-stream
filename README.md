# mopidy-stream
Orginal from Christopher Schirner

@ https://github.com/schinken/docker-container/tree/master/mopidy-stream

Modified to clone my version of the webclient

This is a docker container which provides the latest mopidy release combined with a streaming server. The current version (0.19) sends EOS (End-of-Stream) if the track changes which closes the stream in icecast, mplayer, etc.

This solution pipes the output through liquidsoap which then provides a http stream.

## Setup

```
$~ git clone https://github.com/straend/mopidy-stream.git
$~ cd mopidy-stream
$~ docker build -t mopidy-stream .
```

## Running the container

The container exposes port 80 with nginx acting as a reverse proxy, serving both the webinterface and the stream.
Stream is available at http://<ip:port>/stream/stream
Web interface is at http://<ip:port>

```
docker run -e SPOTIFY_USERNAME=spotifyUser42 -e SPOTIFY_PASSWORD=spotifyPassword123 -p 80 -t mopidy-stream:latest
```

You could also run it direct from hub.docker.com with the following commnd:
```
docker run -e SPOTIFY_USERNAME=spotifyUser42 -e SPOTIFY_PASSWORD=spotifyPassword123 -p 80 -t iamslo/mopidy-stream:latest
```




## Planned

* I will add a mappable volume to include a share with all your music which is then indexed by mopidy
