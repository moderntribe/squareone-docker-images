# SquareOne Docker Images

Base docker images for SquareOne projects. [View it on DockerHub](https://hub.docker.com/r/moderntribe/squareone-php).

## PHP

Image Name: `moderntribe/squareone-php`

### Supported Tags

* `latest`: The latest Dockerfile version using the most recent PHP version (currently 8.0),
  built from the `master` branch.
* `80-latest`: The latest Dockerfile version for PHP 8.0, built from the `master` branch.
* `80-<x.y.z>` or `80-<x.y>`: Specific Dockerfile versions for PHP 8.0, built based on matching tags.
* `74-latest`: The latest Dockerfile version for PHP 7.4, built from the `master` branch.
* `74-<x.y.z>` or `74-<x.y>`: Specific Dockerfile versions for PHP 7.4, built based on matching tags.
* We recommend you use the minor version, so you can continue to receive updates when doing a docker pull, 
e.g. `moderntribe/squareone-php:80-1.0` `moderntribe/squareone-php:74-2.1`

### Adding New Versions

* Create a directory for the new version, e.g., `/php/8.1/`
* Create the Dockerfile and any supporting files in that directory.
* Add automated build configurations to Docker Hub `moderntribe/squareone-php` for the PHP version. Here is an
  example of the build rules to create version 8.0:

  | Source Type | Source              | Docker Tag | Dockerfile location | Build Context |
  |-------------|---------------------|------------|---------------------|---------------|
  | Branch      | master              | 80-latest  | Dockerfile          | /php/8.0/     |
  | Tag         | /^php80-([0-9.]+)$/ | 80-{\1}    | Dockerfile          | /php/8.0/     |

### Testing Releases Before Tagging

After you've made changes to a Dockerfile, it should be built locally and tested **before** being released.

* cd into the folder of the `Dockerfile` that was modified
* Build and tag the image with a custom name: `docker build -t moderntribe/squareone-php:$version-test .`, e.g. `docker build -t moderntribe/squareone-php:74-3.0.6-test .`
* Test it in the [square-one framework](https://github.com/moderntribe/square-one) by temporarily editing [dev/docker/docker-compose.yml](https://github.com/moderntribe/square-one/blob/main/dev/docker/docker-compose.yml#L30) and updating the `x-php` image.

```yaml
x-php: &php
  # Original image
  # image: moderntribe/squareone-php:74-3.0
  # Test image
  image: moderntribe/squareone-php:74-3.0.6-test
```

* Run `so start` and validate the project successfully loads.

### Tagging Releases

* Commit and push the update to the repo. This should trigger an automatic build on the `master` branch for the
  `*-latest` tags.
* Tag the version, prefixed with the affected PHP version, suffixed with the release version. E.g., `php80-1.0.0` for
  the first release of a build for PHP 8.0.
* Tags should follow semantic versioning: `php<version>-<major>.<minor>.<patch>`. `<major>` versions introduce
  breaking changes. `<minor>` versions add features and fix bugs. `<patch>` versions fix bugs. 

### Downstream entrypoint scripts

When using an image from this repo in the downstream, you can add custom scripts in the `docker-entrypoint.d` folder.

All scripts in there will be copied over and automatically executed with
[run-parts](https://manpages.ubuntu.com/manpages/trusty/man8/run-parts.8.html)

Keep in mind the limitations of naming these scripts, they must consist entirely of ASCII upper- and lower-case
letters, ASCII digits, ASCII underscores, and ASCII minus-hyphens. So no .sh extensions.
