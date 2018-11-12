#include <iostream>
#include <cstring>
#include <sstream>
#include <string>
#include <cctype>
#include <clocale>

using namespace std;

const int MAX = 43;

bool upperCase = false;
bool startsWithVowel = false;

char* ToPigLatin(char* word);

int main() {
    // creation of 5 character strings, each length MAX
    char word[5][MAX];
    int i;  // loop counter

    cout << "Input 5 words: ";
    for (i = 0; i < 5; i++) {
        cin >> word[i];
    }
    
    // for testing purposes
//    std::string tester = "string Hamburger Rhythm queen zippitydoodah";
//    std::stringstream res(tester);
//    for (i = 0; i < 5; i++) {
//        res >> word[i];
//    }

    cout << "\nPig Latin version of the 5 words:\n";
    for (i = 0; i < 3; i++) {
        ToPigLatin(word[i]);
        cout << word[i] << ' ';
    }
    // Note that the above outputs illustrate that the original
    //  string itself has been converted.  The outputs below illustrate
    //  that a pointer to this string is also being returned from the 
    //  function.

    cout << ToPigLatin(word[3]) << ' ' << ToPigLatin(word[4]) << '\n';
    return 0;
}

// helper methods*****************************
// adds a y and the closing index to all
void addAy(char* word, int wordEnd, int shift) {
    word[wordEnd + 1 + shift] = 'a';
    word[wordEnd + 2 + shift] = 'y';
    word[wordEnd + 3 + shift] = '\0';
}

void strHelper(std::string &str, int &wordEnd, char* word) {
    str = word;
    wordEnd = str.length();
}

void testUpper(std::string& str) {
    if (str.substr(0, 1) >= "A" && str.substr(0, 1) <= "Z") {
        upperCase = true;
    }
}

// moves starting point to index 0
void moveChars(char* word, int wordEnd, int spot) {
    for (int i = 0; i < wordEnd; i++) {
        word[i] = word[i + spot];
    }
}

void finishPig(char* word, std::string& str, int wordEnd, 
        int& shift, int spot) {
    // move all letters before first vowel to end
    for (int i = 0; i < spot; i++) {
        // changes letters in middle of word to lower case
        if (word[i] >= 'A' && word[i] <= 'Z') {
            word[i] = word[i] + 32;
        }
        word[wordEnd + i] = word[i];
    }
    shift = spot - 1;
    addAy(word, wordEnd, shift);
    // reassign str size and length based on word's new form
    strHelper(str, wordEnd, word);
    // based on spot move everything over to starting index 0
    moveChars(word, wordEnd, spot);
}

// Write your definition of the ToPigLatin function here
char* ToPigLatin(char* word) {
    std::string str;
    int wordEnd;
    int shift = 0;
    strHelper(str, wordEnd, word);
    testUpper(str);
    int spot = str.find_first_of("aeiouAEIOU");  // index of first vowel
    if (spot == 0) {
        startsWithVowel = true;
        word[wordEnd] = 'w';
        addAy(word, wordEnd, shift);
    } else if (spot == 1) {
        finishPig(word, str, wordEnd, shift, spot);
    } else if (spot > 1) {
        if (str.substr(1, str.length()).find('y') != std::string::npos) {
            spot = str.find_first_of("y");
            finishPig(word, str, wordEnd, shift, spot);
        } else {
        finishPig(word, str, wordEnd, shift, spot);
        }
    } else if (spot == -1) {
        spot = str.find_first_of("y");
        finishPig(word, str, wordEnd, shift, spot);
    }    
    if (upperCase && !startsWithVowel) {
        word[0] = word[0] - 32;
    }
    upperCase = false;
    return word;
};

