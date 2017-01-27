#!/usr/bin/env python

from colorama import Fore, Back, Style
import gzip
import sys, os, re

r = re.compile(r"""
Program\ received\ signal\ (?P<signal>[A-Z]+),.*\n
.*\n
eax\ +(?P<eax>0x[0-9a-f]+) .*$\n
ecx\ +(?P<ecx>0x[0-9a-f]+) .*$\n
edx\ +(?P<edx>0x[0-9a-f]+) .*$\n
ebx\ +(?P<ebx>0x[0-9a-f]+) .*$\n
esp\ +(?P<esp>0x[0-9a-f]+) .*$\n
ebp\ +(?P<ebp>0x[0-9a-f]+) .*$\n
esi\ +(?P<esi>0x[0-9a-f]+) .*$\n
edi\ +(?P<edi>0x[0-9a-f]+) .*$\n
eip\ +(?P<eip>0x[0-9a-f]+) .*$\n
eflags\ +(?P<eflags>0x[0-9a-f]+).*\[(?P<eflags_names>.*)\].*$\n
cs\ +(?P<cs>0x[0-9a-f]+) .*$\n
ss\ +(?P<ss>0x[0-9a-f]+) .*$\n
ds\ +(?P<ds>0x[0-9a-f]+) .*$\n
es\ +(?P<es>0x[0-9a-f]+) .*$\n
fs\ +(?P<fs>0x[0-9a-f]+) .*$\n
gs\ +(?P<gs>0x[0-9a-f]+) .*$\n
st0.*\(raw\ (?P<st0>0x[0-9a-f]+)\).*$\n
st1.*\(raw\ (?P<st1>0x[0-9a-f]+)\).*$\n
st2.*\(raw\ (?P<st2>0x[0-9a-f]+)\).*$\n
st3.*\(raw\ (?P<st3>0x[0-9a-f]+)\).*$\n
st4.*\(raw\ (?P<st4>0x[0-9a-f]+)\).*$\n
st5.*\(raw\ (?P<st5>0x[0-9a-f]+)\).*$\n
st6.*\(raw\ (?P<st6>0x[0-9a-f]+)\).*$\n
st7.*\(raw\ (?P<st7>0x[0-9a-f]+)\).*$\n
fctrl\ +(?P<fctrl>0x[0-9a-f]+) .*$\n
fstat\ +(?P<fstat>0x[0-9a-f]+) .*$\n
ftag\ +(?P<ftag>0x[0-9a-f]+) .*$\n
fiseg\ +(?P<fiseg>0x[0-9a-f]+) .*$\n
fioff\ +(?P<fioff>0x[0-9a-f]+) .*$\n
foseg\ +(?P<foseg>0x[0-9a-f]+) .*$\n
fooff\ +(?P<fooff>0x[0-9a-f]+) .*$\n
fop\ +(?P<fop>0x[0-9a-f]+) .*$\n
xmm0\ +{.*uint128\ =\ (?P<xmm0>0x[0-9a-f]+)}.*$\n
xmm1\ +{.*uint128\ =\ (?P<xmm1>0x[0-9a-f]+)}.*$\n
xmm2\ +{.*uint128\ =\ (?P<xmm2>0x[0-9a-f]+)}.*$\n
xmm3\ +{.*uint128\ =\ (?P<xmm3>0x[0-9a-f]+)}.*$\n
xmm4\ +{.*uint128\ =\ (?P<xmm4>0x[0-9a-f]+)}.*$\n
xmm5\ +{.*uint128\ =\ (?P<xmm5>0x[0-9a-f]+)}.*$\n
xmm6\ +{.*uint128\ =\ (?P<xmm6>0x[0-9a-f]+)}.*$\n
xmm7\ +{.*uint128\ =\ (?P<xmm7>0x[0-9a-f]+)}.*$\n
mxcsr\ +(?P<mxcsr>0x[0-9a-f]+).*\[(?P<mxcsr_names>.*)\].*$\n
mm0\ +{uint64\ =\ (?P<mm0>0x[0-9a-f]+),.*$\n
mm1\ +{uint64\ =\ (?P<mm1>0x[0-9a-f]+),.*$\n
mm2\ +{uint64\ =\ (?P<mm2>0x[0-9a-f]+),.*$\n
mm3\ +{uint64\ =\ (?P<mm3>0x[0-9a-f]+),.*$\n
mm4\ +{uint64\ =\ (?P<mm4>0x[0-9a-f]+),.*$\n
mm5\ +{uint64\ =\ (?P<mm5>0x[0-9a-f]+),.*$\n
mm6\ +{uint64\ =\ (?P<mm6>0x[0-9a-f]+),.*$\n
mm7\ +{uint64\ =\ (?P<mm7>0x[0-9a-f]+),.*$\n
[^{]+(?P<siginfo>{.*})$\n
(?P<text>(0x[0-9a-f]+.*:.*\n){512})
(?P<data>(0x[0-9a-f]+.*:.*\n){128})
(?P<stack>(0x[0-9a-f]+.*:.*\n){1024})
""", re.VERBOSE|re.MULTILINE)

RAW = 0
INIT = 1
DONE = 2

def print_diff(line1, line2):
    l1diff = ''
    l2diff = ''
    for i in range(len(line1)):
        if i >= len(line2) or line1[i] != line2[i]:
            l1diff += Fore.RED + line1[i] + Fore.RESET
        else:
            l1diff += line1[i]
    for i in range(len(line2)):
        if i >= len(line1) or line1[i] != line2[i]:
            l2diff += Fore.RED + line2[i] + Fore.RESET
        else:
            l2diff += line2[i]
    print s1[INIT][k]
    print l1diff
    print l2diff

def compare_states(s1, s2):
    if len(s1) <= DONE or len(s2) <= DONE:
        stage = INIT
    else:
        stage = DONE
        
    d1 = s1[stage]
    d2 = s2[stage]

    diff = [k for k in set(d1) - set(['fioff', 'fooff', 'siginfo']) if d1[k] != d2[k]]
    if not diff: return "same"
    else: return ",".join(diff)

    #for k in s1[stage]:
    #    if k in ('fioff', 'fooff', 'siginfo'): continue
    #    if s1[stage][k] != s2[stage][k]:
    #        print "=== %s ===" % k

if __name__ == "__main__":
    data1 = gzip.open(sys.argv[1]).read()
    data2 = gzip.open(sys.argv[2]).read()

    states1 = [m.groupdict() for m in r.finditer(data1)]
    states2 = [m.groupdict() for m in r.finditer(data2)]
    print os.path.basename(sys.argv[1]), compare_states(states1, states2)
