import java.util.Scanner;
import java.io.*;

public class Project24
{
    static Scanner input;

    private static int[][] createTable(String inputFile)
    {
        try
        {
            input = new Scanner(new File(inputFile));
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        int size = input.nextInt();  input.nextLine();
        System.out.println(size);
        int[][] table = new int[size][size];
        int row = 0;
        int col = 0;
        while (row < size)
        {
            if (col >= size)
            {
                col = 0;
                row += 1;
                if (input.hasNextLine())
                {
                    input.nextLine();
                }
            }
            else
            {
                table[row][col] = input.nextInt();
                col += 1;
            }
        }
        return table;
    }
    
    private static void printTable(int[][] table)
    {
        int size = table.length;
        int row = 0;
        int col = 0;
        while (row < size)
        {
            if (col >= size)
            {
                col = 0;
                row += 1;
                System.out.println();
            }
            else
            {
                System.out.print(table[row][col] + " ");
                col += 1;
            }
        }
    }

    private static int[][] processTable(int[][] table)
    {
        int[][] result = table;
        return result;
    }

    public static void main(String[] args)
    {
        String inputFile = args[0];
        int[][] table = createTable(inputFile);
        printTable(table);
        int[][] result = processTable(table);
        printTable(result);
    }
}