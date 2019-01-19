# Tiny Java Runtimes
> ☕ Guide for creating a micro-sized JRE tailor built for your application.

Inspired by: https://mjg123.github.io/2018/11/05/alpine-jdk11-images.html

# Prereqresites

- [Open JDK 11](https://openjdk.java.net/install/) - Open-source Java 11 implementation
    - jlink - Java libray linker tool
    - jdeps - Java class depdenecy analyzer
    - javac - Java compiler


# Getting Started
First things first, we need a Java app to run and to setup our environment. I've included a simple **Hello World** app in the `src/` folder within this repository.

We need to compile the application, see what dependencies or modules it requires and build a JRE based on those required modules.

## Compile
Turn the source code into `.class` files or *bytecode*.
```java
javac -d . src/Main.java
```

## Analyze
See what dependencies you *actually* need to run your app.

```java
jdeps --print-module-deps Main.class
```

## Build Custom JRE:
Link together the modules required from your application's dependencies listed above.

```java
jlink \
    --compress=2 \
    --verbose \
    --no-man-pages \
    --no-header-files \
    --strip-debug \
    --module-path $JAVA_HOME/jmods \
    --add-modules $(jdeps --print-module-deps Main.class) \
    --output dist/myJRE
```

From here, you have a tailored JRE to run your application with:

```java
dist/myJRE/bin/java Main
```