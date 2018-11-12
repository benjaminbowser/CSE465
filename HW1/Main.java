import java.io.File;

public class Main {
	
	public static void main(String[] args) {
		// Help from:
		// https://stackoverflow.com/questions/40822533/input-a-text-file-through-command-line-in-java
		
		if (args.length == 0) {
			System.out.println("Please input a file");
			System.exit(0);
		}
		try {
            File file = new File(args[0]);
    		Helper open = new Helper(file);
        } 
		catch (Exception e) {
            System.err.println("Cannot open file.");
            System.exit(0);
        }
	
	}
}