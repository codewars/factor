# Factor

Container image for Factor with Testest unit test library, used by CodeRunner.

## Examples

Use `bin/run` to test examples inside `examples/`.

```bash
# Usage: ./bin/run $example_name
./bin/run passing
```

> NOTE: The CodeRunner supports arbitrary vocabulary name for the tests,
> but the examples must use `kata.tests` for simplicity.


## Building

```bash
docker build -t ghcr.io/codewars/factor:latest .
```
