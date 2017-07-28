#!/bin/bash
#Declare build path and buildLog name
buildDir="build"
buildLog="buildLog.txt"

outputLog="outputLog.txt"

#de
makeTarget="main"
exeName="textManip"

separator="============================================================"

echo > $buildLog

testOk() {
	if [[ ${1: -4} == ".txt" ]]; then
		echo "Found text file: "$1 >> $buildLog
		return 0
	else
		echo "No text file found. Exiting..." >> $buildLog
		return 1
	fi
}
   echo "Executing grade.sh..." > $buildLog

   echo $separator >> $buildLog
	#Make sure the necessary text file exists
	testOk $1
   	if [[ ! $? -eq 0 ]]; then
      echo "The required text file does not exist, or its contents are not valid.">> $buildLog
    	echo "Fix this error.">> $buildLog
    	exit 1
   	fi

      echo $separator >> $buildLog

      #Remove the textManip executable if it already exists
   	if [[ -e textManip ]]; then
   		rm textManip
   	fi

      #Verify existence of the src folder and it's required files.
   	if [[ ! -e src ]]; then
   		echo "Missing src folder. Exiting...">> $buildLog
   		exit 1
   	else 
         if [[ ! -e src/makefile ]]; then
            echo "Missing makefile from src. Exiting...">> $buildLog
            exit 1
         fi
         if [[ ( ! -e src/main.c ) || ( ! -e src/main.h ) ]]; then
            echo "Missing required file in src. Exiting...">> $buildLog
            exit 1
         fi
      fi

      #Verify the existence of the lib folder and it's required files
   	if [[ ! -e lib ]]; then
   		echo "Missing lib folder. Exiting...">> $buildLog
   		exit 1
   	else
         if [[ ! -e lib/CLogger ]]; then
            echo "Missing CLogger library. Exiting...">> $buildLog
            exit 1
         fi
      fi
      
      #verify the existence of the res folder and it's required resources
   	if [[ ! -e res ]]; then
   		echo "Missing res folder. Exiting..."
   		exit 1
      else
         if [[ ( ! -e res/positive.txt ) || ( ! -e res/negative.txt ) ]]; then
            echo "Missing require file in res. Exiting...">> $buildLog
            exit 1
         fi
   	fi

      echo "Finished verifying files in project.">> $buildLog
      echo "Building project to /"$buildDir>> $buildLog

      #Clear the buildDir if it exists
      if [[ -d $buildDir ]]; then
         rm -Rf ./$buildDir/*
      else
         mkdir $buildDir
      fi

      #Move source files into the buildDir
      cp src/* $buildDir
      cp lib/*/*.a $buildDir 

      #Move to the build directory
      cd ./$buildDir

         # Verify we have a makefile
      if [[ ! -e makefile ]] && [[ ! -e Makefile ]] && [[ ! -e GNUmakefile ]]; then
         echo "There is no makefile in the build directory">> ../$buildLog
         exit 1
      fi

      #Index the libraries
      ranlib *.a

      echo "Invoking:  make $makeTarget" >> ../$buildLog
      make $makeTarget >> ../$buildLog 

      # Verify existence of executable
      if [[ ! -e $exeName ]]; then
         # Try default make
         make
         if [[ ! -e $exeName ]]; then
            echo "Build failed; the file $exeName does not exist" >> ../$buildLog
            echo $Separator >> ../$buildLog
            mv ../$buildLog ../$spid.txt
            exit 7
         fi
      fi

      echo "Build succeeded..." >> ../$buildLog

      # Move executable up to test directory and return there
      echo "Moving the executable $exeName to the test directory." >> ../$buildLog
      mv ./$exeName .. 
      cd .. 

      echo $separator >> $buildLog

      echo "Running the executable - output located in: "$outputLog >> $buildLog

      #Begin outputting to the outputLog
      echo "Running the executable..." > $outputLog
      echo $separator >> $outputLog
 
      #Run the exe using the given text field param 
      ./$exeName $1 >> $outputLog

      echo "Finished." >> $outputLog

exit 0