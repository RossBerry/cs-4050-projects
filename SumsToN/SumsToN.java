/**
 * SumsToN.java
 * 
 * Prints all unique sums that result in a positive integer input
 * by the user in the console.
 * 
 * @author Kenneth Berry
 */


import java.util.Scanner;

class SumsToN {

    public static void printSumsToN(int[] arr, int index, int n, int current) {
        if (current < 0) {
            return;
        }

        if (current == 0) {
            for (int i = 0; i < index; i++) {
                if (i + 1 == index) {
                    System.out.print (arr[i]);
                }
                else {
                    System.out.print (arr[i] + " + ");
                }
            }
            System.out.println();
            return;
        }

        int prev;
        if (index == 0) {
            prev = 1;
        }
        else {
            prev = arr[index - 1];
        }

        for (int i = prev; i <= n ; i++) {
            arr[index] = i; 
            printSumsToN(arr, index + 1, n, current - i);
        }
    }

    public static void main (String[] args) {
        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a positive integer:");
        int n = reader.nextInt();
        reader.close();
        int sums[] = new int[n]; 
        printSumsToN(sums, 0, n, n); 
    }
}