/**
 * Floyd's Algorithm
 * CS 4050
 * 
 * Orange Team: Joe Turner
 *       Kenneth Berry
 *       John Sanders
 *       Alex Parmentier
 *       Nila Niroula
 *       Elie S.
 **/ 
import java.util.Scanner;
import java.io.*;
public class Floyd {
    static int[][][] t;
    static int n;
    public static int[][][] algo(int[][][] d, int k) {
        for(int r = 0; r < n; r++){
            for(int c = 0; c < n; c++){
                if(r != k || c != k){
                    if(d[r][k][0] != -1 && d[k][c][0] != -1){
                        if(d[r][k][0] + d[k][c][0] < d[r][c][0] || d[r][c][0] == -1){
                            d[r][c][0] = d[r][k][0] + d[k][c][0];
                            d[r][c][1] = k + 1;
                        }
                    }
                }
            }
        }
        return d;
    }
    
    public static void printTable(int[][][] table){
        int s = table.length;
        int w = 8;
        for (int i = 0; i < s * w + 1; i++) {
            System.out.print("-");
        }
        System.out.println();
        for (int r = 0; r < s; r++) {
            System.out.print("| ");
            for (int c = 0; c < s; c++) {
                System.out.print(String.format("%-5s", t[r][c][0]));
                System.out.print(" | ");
            }
            System.out.println();
            System.out.print("| ");
            for (int c = 0; c < s; c++) {
                System.out.print(String.format("%1$5s", t[r][c][1]));
                System.out.print(" | ");
            }
            System.out.println();
            for (int i = 0; i < s * w + 1; i++) {
                System.out.print("-");
            }
            System.out.println();
        }
    }
    public static void main(String[] args) {
        if(args.length > 0) {
            try {
                Scanner s = new Scanner(new File(args[0]));
                n = s.nextInt();
                t = new int[n][n][2];
                for(int r = 0; r < n; r++){
                    for(int c = 0; c < n; c++){
                        t[r][c][0] = s.nextInt();
                        t[r][c][1] = 0;
                    }
                }
                s.close();
            }
            catch(Exception e) {
                System.out.println(e);
            }
            System.out.println("D0");
            printTable(t);
            for(int k = 0; k < n; k++) {
                t = algo(t, k);
                System.out.println("D" + (k + 1));
                printTable(t);
            }
        }
    }
}
