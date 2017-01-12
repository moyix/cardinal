This is a collection of test for the paper "Cardinal Pill Testing of
System Virtual Machines" (which I did not write). They have been ported
so that they assemble under nasm and can be built on Linux.

To build:

    ./build.sh

To clean up:

    ./build.sh clean

To run the tests:

    ls *.asm | parallel --eta --progress gdb -batch -q -x gdbcmd.txt {.} '|' gzip -c '>' {.}.txt.gz

The original test cases, along with their WinDbg-based test harness, can be
found on the authors' web site:

http://steel.isi.edu/Projects/cardinal/
