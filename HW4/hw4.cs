using System.Collections.Generic;
using System;
using System.IO;

public class hw4 {
	public static void Main(string[] args) {
		readWrite prog = new readWrite();
		int inputGiven = args.Length;
		
		// Safety check to make program more reliable
		if (inputGiven != 2) {
			Console.WriteLine("An incorrect number of files was used.");
		}
		else {
			prog.execute(args[0], args[1]);
		}
	}
}	

public class scoreData {
	public Dictionary<string, string> records;
	
	public scoreData() {
		records = new Dictionary<string,string>();
		// Used as reference: http://www.tutorialsteacher.com/csharp/csharp-dictionary
		//					  https://www.dotnetperls.com/dictionary
	}
	
	public void fileOutput(string tmpFile) {
		string copy = tmpFile;
		int total = 0;
		
		if (tmpFile != null) {
			int tagNumber = (tmpFile.Length - copy.Replace("<<", "").Length) / 2;
			// There is content in the file to write out
			foreach(string key in records.Keys) {
			// https://msdn.microsoft.com/en-us/library/fk49wtc1(v=vs.110).aspx
			if (total <= tagNumber) {
			tmpFile = tmpFile.Replace("<<"+key+">>", records[key]);
			total++;
			}
			}
		}
		
		// https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/file-system/how-to-write-to-a-text-file
		// Write the file name
		string file = records["ID"];
		file = file + ".txt"; // Add .txt at end
		using (StreamWriter output = File.CreateText(file)) {
			output.WriteLine(tmpFile);
		}
	}
}


public class readWrite {
	public List<string> columns;
	// https://stackoverflow.com/questions/12384905/string-split-function-in-c-sharp-tab-delimiter
	public List<scoreData> data = new List<scoreData>();
	public string temp; // Refactored output (sent in fileOutput method)
	
	public void execute(string file, string tmpFile) {

		// https://docs.microsoft.com/en-us/dotnet/standard/io/how-to-read-text-from-a-file
		using (StreamReader input = new StreamReader(tmpFile)) {
			string content; // Make global above??
			while ((content = input.ReadLine()) != null) {
				temp = temp + content + "\n"; 
			}
			if (content != null) {
				temp = temp.Trim();
			}
		}
		using (StreamReader input = new StreamReader(file)) {
			String content = input.ReadLine();
			columns = new List<string>(content.Split('\t'));
			// https://stackoverflow.com/questions/3575029/c-sharp-liststring-to-string-with-delimiter
			
			while((content = input.ReadLine()) != null) {
				List<string> columnData;
				columnData = new List<string>(content.Split('\t'));
				scoreData scores = new scoreData();
				
				int count = columns.Count;
				for (int i = 0; i < count; i++) {
					scores.records.Add(columns[i], columnData[i]);
				}
				data.Add(scores);
			}
		}
		foreach(scoreData score in data) {
			score.fileOutput(temp);
		}
	}
}
