#!/usr/bin/env python
"""
SumsToN.py

Prints all unique sums that result in a positive integer input
by the user in the console.
"""
__author__ = "Kenneth Berry"

def sums_to_n(sums_lst, index, input_n, current):
    """ 
    Recursively finds all sums adding up to n and prints
    them to the console 
    """
    if current < 0:
        return

    if current == 0:
        out_string = ""
        for i in range(index):
            if (i + 1) == index:
                out_string += str(sums_lst[i])
            else:
                out_string += (str(sums_lst[i]) + " + ")

        print(out_string)
        return

    if index == 0:
        prev = 1
    else:
        prev = sums_lst[index - 1]

    while(prev <= input_n):
        sums_lst[index] = prev;
        sums_to_n(sums_lst, index + 1, input_n, current - prev)
        prev += 1


if __name__ == "__main__":
    n = int(input("Enter a positive integer: "))
    zero_lst = [0 for num in range(n)]
    sums_to_n(zero_lst, 0, n, n)