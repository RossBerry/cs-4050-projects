#!/usr/bin/env python
"""
SumsToN.py

Prints all unique sums that result in a positive integer input
by the user in the console.
"""
__author__ = "Kenneth Berry"

def sums_to_n(num_list, index, input_n, current):
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
                out_string += str(num_list[i])
            else:
                out_string += (str(num_list[i]) + " + ")

        print(out_string)
        return

    if index == 0:
        prev = 1
    else:
        prev = num_list[index - 1]

    while prev <= input_n:
        num_list[index] = prev
        sums_to_n(num_list, index + 1, input_n, current - prev)
        prev += 1


if __name__ == "__main__":
    INPUT_N = int(input("Enter a positive integer: "))
    ZERO_LIST = [0 for num in range(INPUT_N)]
    sums_to_n(ZERO_LIST, 0, INPUT_N, INPUT_N)
