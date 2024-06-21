# Viewtube all in one docker image

All in one image to easily run [Viewtube](https://github.com/ViewTube/viewtube) in a single docker container.

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


## Known issues

- Mongodb requires a CPU with the AVX instruction set for x86_64 CPU's. Older cpu's are sadly out of luck.
 