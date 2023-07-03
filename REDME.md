## Installation

add to docker compose
```docker
    php-tools:
      image: grzegab/php-tools:1.0.1
    volumes:
      - '.:/app/data'```
      
* must be mapped with src - for soruce code
* must be mapped with tests - for unit testing
* must have rector.php - for rector things

## Usage

* To fix (while developing) use docker compose command:
`docker compose run --rm php-tools ./fix`

* To check if there are no errors (while running pipeline):
`docker compose run --rm php-tools ./check`

Initial commit:
Greg "Grzegab" Gabryel