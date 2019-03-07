/**
 * SumsToN.java
 * 
 * CS 4050 Project 4: Sums to n Problem by Brute Force
 * 
 * Kenneth Berry
 * Alex Parmentier
 * John Sanders
 */

import java.util.Scanner;

class SumsToN {

    public static void printSumsToN(int arr[], int index, int countdown, int n) {
        if (countdown < 0) {
            return;
        }

        if (countdown == 0) {

            // DEBUG - print contents of array
            // for (int i = 0; i < n; i++){
            // System.out.print(arr[i]);
            // }
            // System.out.println();

            for (int i = 0; i < index; i++) {
                if (i + 1 == index) {
                    System.out.print(arr[i]);
                } else {
                    System.out.print(arr[i] + " + ");
                }
            }
            System.out.println();
            return;
        }

        int prev;
        if (index == 0) {
            prev = 1;
        } else {
            prev = arr[index - 1];
        }

        for (int x = prev; x <= n; x++) {
            arr[index] = x;
            printSumsToN(arr, index + 1, countdown - x, n);
        }
    }

    public static void main(String[] args) {
        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a positive integer:");
        int n = reader.nextInt();
        reader.close();
        int arr[] = new int[n];
        printSumsToN(arr, 0, n, n);
    }
}