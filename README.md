# Viewtube all in one docker image

All in one image to easily run [Viewtube](https://github.com/ViewTube/viewtube) on your NAS or your router.

## Usage

```shell
docker run --rm -it $(docker build -q .)
open "http://localhost:9066"
```
