#!/usr/bin/python3
#pip install pdfminer
from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument
import os
def get_info(dirName):
    # create a list of file and sub directories 
    # names in the given directory 
    listOfFile = os.listdir(dirName)
    allFiles = list()
    # Iterate over all the entries
    for entry in listOfFile:
        # Create full path
        fullPath = os.path.join(dirName, entry)
        # If entry is a directory then get the list of files in this directory 
        if os.path.isdir(fullPath):
            allFiles = allFiles + getListOfFiles(fullPath)
        else:
            allFiles.append(fullPath)
                
    return allFiles

#Modify this path to your file path of PDFs 
pdfpath = '/home/user/Downloads/pdf'
file_list = get_info(pdfpath)
print(file_list)

for f in file_list:
	pdfile = open(f, 'rb')
	parser = PDFParser(pdfile)
	doc = PDFDocument(parser)
	print(doc.info) 