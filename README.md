## to build

```
docker build -t abuild .
docker run --privileged --cap-add=ALL -v /proc:/proc -v /sys:/sys -it -v $PWD:/home/build/aports/scripts/mnt --rm abuild
```
