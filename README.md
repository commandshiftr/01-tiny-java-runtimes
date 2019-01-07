# Tiny Java Docker Images
> Guide for creating a custom micro-sized JRE in order to containerise Java applications with Alpine Linux.

Inspired by: https://mjg123.github.io/2018/11/05/alpine-jdk11-images.html

# Prereqresites

- [Docker](https://www.docker.com/get-started)
- [OpenJDK 11](https://openjdk.java.net/install/) - Open-source Java 11 implementation
    - [JLink](https://openjdk.java.net/jeps/282) - 
    - [JDeps]() - Java class depdenecy analyzer
    - [javac]() - Java compiler


# Getting Started
First things first, we need a Java app to run and to setup our environment. I've included a simple **Hello World** app in the `src/` folder within this repository.

We need to compile the application, see what dependencies or modules it requires and build a JRE based on those required modules.

## Compile
Turn the source code into `.class` files or *bytecode*.
```java
javac -d bin/ src/Main.java
```

## Analyze
See what dependencies you *actually* need to run your app.

```java
jdeps --print-module-deps bin/Main.class
```

## Build Custom JRE:
Link together the modules required from your application's dependencies listed above.

```java
jlink \
    --compress=2 \
    --module-path dist/linux_x86-64/jdk-11.0.1/jmods/ \
    --add-modules $(jdeps --print-module-deps bin/Main.class) \
    --output dist/myJRE
```

From here, you have a tailored JRE to run your application with:

```java
dist/myJRE/bin/java bin/Main.class
```

# Create Docker Image
In this repository I've also included a `Dockerfile` to quickly build our image. The Dockerfile pulls from [Alpine Linux](https://alpinelinux.org/) which is a ridicously small Linux distribution.

```docker
docker build --tag tiny-jre .
```

```docker
docker run tiny-jre
```