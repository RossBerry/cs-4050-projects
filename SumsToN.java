import java.util.Scanner;
import java.util.ArrayList;

public class SumsToN {
    
    private static int n;
    private static ArrayList<ArrayList<Integer>> sums;

    public static ArrayList<ArrayList<Integer>> sumsOfN(int n){
        ArrayList<ArrayList<Integer>> sumsList = new ArrayList<ArrayList<Integer>>();
        sumsList.add(new ArrayList<Integer>(n));
        for (int i = 1, j = n - 1; i < (n/2) + 1; i++, j--){
            ArrayList<Integer> tempList = new ArrayList<Integer>();
            tempList.add(i);
            tempList.add(j);
            sumsList.add(tempList);
        }
        return sumsList;
    }

    public static void main(String[] args) {

        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a positive integer:");
        int n = reader.nextInt();
        reader.close();
        sums = sumsOfN(n);
        for (int i = 0; i < sums.size(); i ++){
            for (int j = 0; j < sums.get(i).size(); j ++){
                System.out.print(sums.get(i).get(j));
                if (sums.get(i).get(j) != sums.get(i).size()){
                    System.out.print(" + ");
                }
            }
            System.out.println();
        }
        
    }

}