import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Helper {
	Scanner reader;
	Map<String, String> data;
	// Key, Value
	File fileLocation;
	int counter = 0;

	public Helper(File file) {
		data = new HashMap<String, String>();

		this.fileLocation = file;
		try {
			reader = new Scanner(fileLocation);
		}
		catch(Exception e) {
			System.out.println("Something went wrong. Check to make sure the file exists.");
		}
		process();
	}

	private void process() {
		while(reader.hasNext()) {
			String textLine = reader.nextLine().trim(); // get whole line
			counter++;
			decode(textLine);
		}
	}

	private void decode(String text) {
		if (text.indexOf("PRINT") >= 0) {
			print(text);
		}
		else if (text.indexOf("FOR") >= 0) {
			forDecode(text);
		}
		// += (int/string), *=, -=
		else if (text.indexOf("+=") >= 0) {
			plusEquals(text);
		}
		else if (text.indexOf("*=") >= 0) {
			timesEquals(text);
		}
		else if (text.indexOf("-=") >= 0) {
			minusEquals(text);
		}
		// Equals HAS to be right here
		else if (text.indexOf("=") >= 0) {
			equals(text);
		}
	}

	private void print(String text) {
		String[] split = text.split(" ");
		System.out.println(split[1] +  "=" +data.get(split[1]));
	}

	private void forDecode(String text) {
		try {
			String[] split = text.split(" ");

			int value = Integer.parseInt(split[1].trim()); // get the # of loops
			text = text.substring(text.indexOf(" ", 4)).trim(); // data

			for (int i = 0; i < value; i++) { 
				// "for loops can be nested and must appear on one line"
				String[] contents = text.split(";"); 

				for(String data:contents)
				{
					if(!data.trim().equals("ENDFOR")) {
						decode(data.trim());
						// Process until loop is broken
					}
				}
			}
		}
		catch (Exception e) {
			System.out.println("RUNTIME ERROR: line " + counter);
			System.exit(0);
		}
	}

	private void equals(String text) {
		// Handles setting variables (overwrite)
		String[] split = text.split(" ");
		try { 
			split[2] = split[2].replace("\"", "");
			data.put(split[0], (split[2]));
		}
		catch (Exception e) { 
		}
	}

	private void plusEquals(String text) {
		// Handles strings and integers
		String[] split = text.split(" ");

		try {
			int start = Integer.parseInt(data.get(split[0]));
			int calc = start + Integer.parseInt(data.get(split[2]));
			data.put(split[0], Integer.toString(calc)); 
		}
		catch (Exception e) {
			try {
				int start = Integer.parseInt(data.get(split[0]));
				int calc = start + Integer.parseInt(split[2]);
				data.put(split[0], Integer.toString(calc));
			}
			catch (Exception Ea) {
				String start = data.get(split[0]);
				String calc = start + data.get(split[2]);

				if (data.get(split[2]) == null) {
					System.out.println("RUNTIME ERROR: line " + counter);
					System.exit(0);
				}
				data.put(split[0], calc);		
			}
		}
	}

	private void timesEquals(String text) {
		String[] split = text.split(" ");
		try {
			int start = Integer.parseInt(data.get(split[0]));
			int calc = start * Integer.parseInt(split[2]);
			data.put(split[0], Integer.toString(calc)); 
		}
		catch (Exception e) {
			System.out.println("RUNTIME ERROR: line " + counter);
			System.exit(0);
		}
	}

	private void minusEquals(String text) {
		String[] split = text.split(" ");
		try {
			int start = Integer.parseInt(data.get(split[0]));
			int calc = start - Integer.parseInt(split[2]);
			data.put(split[0], Integer.toString(calc)); 	
		}
		catch (Exception e) {
			System.out.println("RUNTIME ERROR: line " + counter);
			System.exit(0);
		}
	}
}