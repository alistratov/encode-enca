Encode::Enca (libencode-enca-perl)
============
[![Build Status](https://travis-ci.org/alistratov/libenca-perl.png?branch=master)](https://travis-ci.org/alistratov/libenca-perl)

Enca Library Perl interface.

Enca (Extremely Naive Charset Analyser) is a library to detecting character set and encoding of text:
http://cihar.com/software/enca/

Encoding::Enca is a XS module to provide API to libenca.

How to build and install:

    perl Makefile.PL
    make
    make test
    make install
