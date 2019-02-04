#!/usr/bin/env python
"""
SumsToN.py

 Gets a positive integer N, input by the user, and then
 prints out all unique sums of positive integers adding 
 up to N.
"""
__author__ = "Kenneth Berry"


def sums_to_n(input_n):
    """
    Displays all unique sums adding up to input_n by calling
    recursive function print_sums()
    """
    zero_list = [0 for num in range(input_n)]
    print_sums(zero_list, 0, input_n, input_n)


def print_sums(num_list, index, input_n, current):
    """
    Recursively finds all sums adding up to input_n and prints
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
        print_sums(num_list, index + 1, input_n, current - prev)
        prev += 1


if __name__ == "__main__":
    INPUT_N = int(input("Enter a positive integer: "))
    sums_to_n(INPUT_N)
