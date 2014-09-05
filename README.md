# aem-author

This Docker image installs [Adobe Experience Manager 6.0](http://docs.adobe.com/docs/en/aem/6-0.html), and allows it
to be run within a Docker container.

## About docker-aem-author

> *From [the official readme](https://github.com/clue/php-redis-server#readme):*

You must copy your AEM installation Media into the `aemMedia` directory before
running this image. The image expects the following files within that directory:
* cq-author-4502.jar
* license.properties

## Usage

```bash
$ docker run --name AEM_AUTH -p 4502:4502 -d "ggotti/aem_author"
```

Where
* `-d` will run a detached session running in the background
* `--name` will assign the given name to the running container instance
* `ggotti/aem_author` the name of this docker image
