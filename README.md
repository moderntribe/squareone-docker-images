# SquareOne Docker Images

Base docker images for SquareOne projects

## PHP

Image Name: `moderntribe/squareone-php`

### Supported Tags

* `latest`: The latest Dockerfile version using the most recent PHP version (currently 7.4),
  built from the `master` branch.
* `74-latest`: The latest Dockerfile version for PHP 7.4, built from the `master` branch.
* `74-<x.y.z>`: Specific Dockerfile versions for PHP 7.4, built based on matching tags.

### Adding New Versions

* Create a directory for the new version, e.g., `/php/8.0/`
* Create the Dockerfile and any supporting files in that directory.
* Add automated build configurations to Docker Hub `moderntribe/squareone-php` for the PHP version. Here is an
  example of the build rules to create version 8.0:

  | Source Type | Source              | Docker Tag | Dockerfile location | Build Context |
  |-------------|---------------------|------------|---------------------|---------------|
  | Branch      | master              | 80-latest  | Dockerfile          | /php/8.0/     |
  | Tag         | /^php80-([0-9.]+)$/ | 80-{\1}    | Dockerfile          | /php/8.0/     |

### Tagging Releases

* Commit and push the update to the repo. This should trigger an automatic build on the `master` branch for the
  `*-latest` tags.
* Tag the version, prefixed with the affected PHP version, suffixed with the release version. E.g., `php80-1.0.0` for
  the first release of a build for PHP 8.0.
* Tags should follow semantic versioning: `php<version>-<major>.<minor>.<patch>`. `<major>` versions introduce
  breaking changes. `<minor>` versions add features and fix bugs. `<patch>` versions fix bugs.
