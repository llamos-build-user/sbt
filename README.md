# llamos/sbt

This Docker image contains an installation of SBT on Java 8 provided by OpenJDK.

The entrypoint is the `sbt` command, so simply mount a volume containing your project to `/workspace`, and run/build/etc via normal sbt commands.
```
docker run -v /path/to/project:/workspace llamos/sbt clean compile run
```
