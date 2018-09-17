# Geekbench4 on CentOS

A simple shell script to allow installation of Geekbench 4 on old CentOS releases. I have personally tested this on CentOS 6.5 and CentOS 6.6 but, given the similarities, I would expect this to work (perhaps with minor modifications) on the corresponding versions of Red Hat Enterprise Linux (RHEL) and even Scientific Linux.

This is intended for users with outdated versions of the GNU C Library (glibc) and the GNU C++ Library (libstdc++) that are encountering errors similar to the following:

```
./geekbench_x86_64: /lib64/libm.so.6: version `GLIBC_2.15' not found (required by ./geekbench_x86_64)
./geekbench_x86_64: /lib64/libc.so.6: version `GLIBC_2.15' not found (required by ./geekbench_x86_64)
./geekbench_x86_64: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.18' not found (required by ./geekbench_x86_64)
```

The script downloads Geekbench 4, the sources of glibc and the binaries of libstdc++ and installs them locally, i.e. on the current directory, without messing up the global environment of your current configuration. This also has the advantage of not requiring sudo privileges.

This largely is based on information found [here](https://github.com/tensorflow/tensorflow/issues/2924).
