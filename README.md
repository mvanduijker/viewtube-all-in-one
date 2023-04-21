# Viewtube all in one docker image

All in one image to easily run [Viewtube](https://github.com/ViewTube/viewtube) on your NAS or your router.

## Usage

### From registry

```shell
docker run --rm -p 8066:8066 -v $(pwd)/data:/data mvanduijker/viewtube-all-in-one
open "http://localhost:8066"
```


### Development

```shell
docker run --rm -p 8066:8066 -v $(pwd)/data:/data $(docker build -q .)
open "http://localhost:8066"
```
