# Transmitter Specifications


Your three mystery signals are generated with the M6 transmitter standard in m6params.m, described in SRD, Chap 15, with these frame parameters:
```
userDataLength:   125
preamble:         '0x0 This is is the Frame Header 1y1'
```
and with the following RF parameters:

- **mysteryA**:

```
SRRCLength:     4
SRRCrolloff:    0.33
T_t:            8.9e-6 s
f_if:           1.6 MHz
f_s:            700 kHz 
```

- **mysteryB**:

```
SRRCLength:     5
SRRCrolloff:    0.4
T_t:            7.5e-6 s
f_if:           1.2 MHz
f_s:            950 kHz
```

- **mysteryC**:

```
SRRCLength:     3
SRRCrolloff:    0.14
T_t:            8.14e-6 s
f_if:           2.2 MHz
f_s:            819 kHz
```
