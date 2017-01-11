#!/bin/bash

if [ "$1" == "clean" ]; then
    rm *.o
    ls 0x* | grep -v asm | xargs rm
    exit
else
    ls *.asm | parallel nasm -t -f elf {} 
    ls *.o | parallel ld -T ldscript -emain {} -o {.} 
fi
