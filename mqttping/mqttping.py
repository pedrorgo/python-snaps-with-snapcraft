#!/usr/bin/env python
# coding: utf-8
# References:
# https://opensource.org/licenses

import os
import sys

__version__ = '0.1.1'


def quit(s, code=0):
    if s is not None:
        print(s)
    sys.exit(code)


def print_help():
    help = """
Usage: mqttping <test string>
"""[1:-1]
    print(help)


def main():
    args = sys.argv[1:]
    if not args:
        print_help()
        quit(None, 0)

    print("Hello Python snaped {}".format(args))

if __name__ == '__main__':
    main()
