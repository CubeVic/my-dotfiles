# Display all the variables in the path 

echo $PATH | sed 's/:/\n/g' | sort | uniq -c
