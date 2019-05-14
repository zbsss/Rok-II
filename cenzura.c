#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LINE_SIZE 1000

/* Function declaration */
void replaceAll(char* str, const char* oldWord, const char* newWord);


int main()
{
	/* File pointer to hold reference of input file */
	FILE* fPtr;
	FILE* fTemp;
	
	//w sciezce trzeba znak "\" zastapic znakiem "\\" bo ten pierwszy to znak specjalny a my chcemy go normalnie wczytac
	//jako symbol
	char path[100]="C:\\Users\\user\\Desktop\\DZIAŁAJ BŁAGAM\\projekt weronika\\plik.txt";

	char line[LINE_SIZE];
	char oldWord[100]="Michał", newWord[100]="#####";


	// printf("Enter path of source file: ");
	// gets_s(path,100);
	//
	// printf("Enter word to replace: ");
	// gets_s(oldWord,100);
	//
	// printf("Replace '%s' with: ",oldWord);
	// gets_s(newWord,100);


	/*  Open all required files */
	fopen_s(&fPtr, path, "r");
	fopen_s(&fTemp, "replace.tmp", "w");

	/* fopen() return NULL if unable to open file in given mode. */
	if (fPtr == NULL || fTemp == NULL)
	{
		/* Unable to open file hence exit */
		printf("\nUnable to open file.\n");
		printf("Please check whether file exists and you have read/write privilege.\n");
		exit(EXIT_SUCCESS);
	}


	/*
	 * Read line from source file and write to destination 
	 * file after replacing given word.
	 */
	while ((fgets(line, LINE_SIZE, fPtr)) != NULL)
	{
		// Replace all occurrence of word from current line
		replaceAll(line, oldWord, newWord);

		// After replacing write it to temp file.
		fputs(line, fTemp);
	}


	/* Close all files to release resource */
	fclose(fPtr);
	fclose(fTemp);


	/* Delete original source file */
	remove(path);

	/* Rename temp file as original file */
	rename("replace.tmp", path);

	printf("\nSuccessfully replaced all occurrences of '%s' with '%s'.", oldWord, newWord);
	system("Pause");
	return 0;
}


/**
 * Replace all occurrences of a given a word in string.
 */
void replaceAll(char* str, const char* oldWord, const char* newWord)
{
	char *pos, temp[LINE_SIZE];
	int index = 0;
	int owlen;

	owlen = strlen(oldWord);


	/*
	 * Repeat till all occurrences are replaced. 
	 */
	while ((pos = strstr(str, oldWord)) != NULL)
	{
		// Bakup current line
		strcpy_s(temp,LINE_SIZE, str);

		// Index of current found word
		index = pos - str;

		// Terminate str after word found index
		str[index] = '\0';

		// Concatenate str with new word 
		strcat_s(str,LINE_SIZE, newWord);

		// Concatenate str with remaining words after 
		// oldword found index.
		strcat_s(str,LINE_SIZE, temp + index + owlen);
	}
}
