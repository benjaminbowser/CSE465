import sys

class readWrite:
	def __init__(self):
		self.temp = ""
		self.contents = []
		self.info = []
		
	def execute(self, file, tempFile):
		
		
		# https://www.guru99.com/reading-and-writing-files-in-python.html
		# https://stackoverflow.com/questions/9282967/how-to-open-a-file-using-the-open-with-statement
		with open(tempFile, 'r') as readTemplate:
			for content in readTemplate:
				self.temp = self.temp + content
		self.temp = self.temp.strip()
		delimiter = '\t' 
		
		with open(file, 'r') as readInput:
			contents = [line.strip() for line in readInput.readline().split(delimiter)]
			
			for input in readInput:
				swap = scoreData()
				data = [line.strip() for line in input.split(delimiter)]
				for i in range(len(contents)):
					swap.pushInfo(contents[i], data[i])
				
				self.info.append(swap)
		for data in self.info:
			data.fileOutput(self.temp)

class scoreData:
	def __init__(self):
		self.contents = {}
	
	def fileOutput(self, tempFile):
	# Generate a new file and write output
		for key in self.contents.keys():
			tempFile = tempFile.replace('<<'+key+'>>', self.contents[key])
			# Same idea as C#
			
		file = self.contents['ID']
		file = file + '.txt' #same as C# implementation
		with open(file, 'w') as writeOut:
			writeOut.write(tempFile)
		
	def pushInfo(self, location, data):
	# Add data to set to writeout 
		self.contents[location] = data

if __name__ == "__main__":
# https://stackoverflow.com/questions/419163/what-does-if-name-main-do

	runner = readWrite()
	# http://www.pythonforbeginners.com/system/python-sys-argv
	if (len(sys.argv) != 2):
		runner.execute(sys.argv[1], sys.argv[2])
	else:
		print("An incorrect number of files was used.")
		