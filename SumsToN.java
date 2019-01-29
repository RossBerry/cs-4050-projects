import java.util.Scanner;

class SumsToN {

private static int[] sums;

    static void findSums(int[] arr, int index, int n, int reducedNum) {
        if (reducedNum < 0) {
            return;
        }

        if (reducedNum == 0) {
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
            findSums(arr, index + 1, n, reducedNum - i);
        }
    }

    public static void main (String[] args) {
        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a positive integer:");
        int n = reader.nextInt();
        reader.close();
        sums = new int[n]; 
        findSums(sums, 0, n, n); 
    }
}