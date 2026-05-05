mkdir -p new_directory_name/sub_directory_name #creates new directory, -p allows nested directory


echo $? #shows error from previous command...helpful to display in shell user in .bashrc

pwd #returns active working directory

ls #shows all file names in working directory (use TAB to autocomplete)
ls sub_directory_name #shos file names under sub-directory

cd new_working_directory
cd .. #exits to parent directory
cd ~/desktop #the ~ is short for home directory
cd - #the undo button, goes to last previous working directory

source .venv/bin/activate
deactivate

pip instal requests numpy

my_variable="hello"
echo $my_variable

cat filename.txt #reads file text, displays to console
less largefile.txt #reads only one page at a time (use h for help, space for next page, arrows for single line movement)

# redirection
cat filename.txt second_file.txt > combined_file.txt # '>' replaces the new file
cat filename.txt >> appended_file.txt # just appends it rather than replacing
python main.py > output.txt #ouput does not include standard errors (STDERR), only standard output (STDOUT)... STDERR needs '2>' to redirect leaving terminal for STDOUT, '&>' will do both STDERR and STDOUT
# may combine together > file.tx 2> other.txt
#Tutor: As you may know, Python's open() function opens existing files
#Tutor: for reading.  You could instead pass open() a filename that does not
#Tutor: exist along with mode="w".  This tells Python to create a new, empty
#Tutor: file and return a new file object.  This object can be passed to print(),
#Tutor: sending the text into the file instead of the screen.

clear #clears the terminal
reset #clears even when terminal is currupted

man bash_command #user manual for commands(open with the less command automatically)(use -k for searching programs)

cp source_name.txt new_copy_name.yaml
mv source.txt destination #if destination is a file name, the source gets renamed

rm source.txt #use * wildcard ie. *.txt or *example*
rm -r directory #removes all files in directory
rmdir directory #removes directory

#in Nano, M- means "alt"

^U for coping and clearing screen
^Y for pasting that same copy

#use [abc][123].txt to find txt files that start with a,b,or c...with second character starting with 1,2, or 3

file = test.txt
echo ${file%.*}.md #replaces .txt with .md
echo ${file%.*} #strips file extension


#use " " when wanting to preserve multiple spaces in variable
