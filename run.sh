#!/bin/bash
#declare build path and buildLog name
buildDir="build"
buildLog="buildLog.txt"

#de
makeTarget="main"
makeExe="textManip"

separator="============================================================"


testOk() {
	if [[ ${1: -4} == ".txt" ]]; then
		echo "Found text file: "$1
		return 0
	else
		echo "No text file found. Exiting..."
		return 1
	fi
}
   echo $separator
	#Make sure the necessary text file exists
	testOk $1
   	if [[ ! $? -eq 0 ]]; then
      	echo "The required text file does not exist, or its contents are not valid."
    	echo "Fix this error."
    	exit 1
   	fi

      echo $separator

      #Remove the textManip executable if it already exists
   	if [[ -e textManip ]]; then
   		rm textManip
   	fi

      #Verify existence of the src folder and it's required files.
   	if [[ ! -e src ]]; then
   		echo "Missing src folder. Exiting..."
   		exit 1
   	else 
         if [[ ! -e src/makefile ]]; then
            echo "Missing makefile from src. Exiting..."
            exit 1
         fi
         if [[ ( ! -e src/main.c ) || ( ! -e src/main.h ) ]]; then
            echo "Missing required file in src. Exiting..."
            exit 1
         fi
      fi

      #Verify the existence of the lib folder and it's required files
   	if [[ ! -e lib ]]; then
   		echo "Missing lib folder. Exiting..."
   		exit 1
   	else
         if [[ ! -e lib/CLogger ]]; then
            echo "Missing CLogger library. Exiting..."
            exit 1
         fi
      fi
      
      #verify the existence of the res folder and it's required resources
   	if [[ ! -e res ]]; then
   		echo "Missing res folder. Exiting..."
   		exit 1
      else
         if [[ ( ! -e res/positive.txt ) || ( ! -e res/negative.txt ) ]]; then
            echo "Missing require file in res. Exiting..."
            exit 1
         fi
   	fi

      echo "Finished verifying files in project."
      echo "Building project to /"$buildDir

      #Clear the buildDir if it exists
      if [[ -d $buildDir ]]; then
         rm -Rf ./$buildDir/*
      else
         mkdir $buildDir
      fi

      #Move source files into the buildDir
      cp src/* $buildDir

      #Move to the build directory
      cd $buildDir

         # Verify we have a makefile
      if [[ ! -e makefile ]] && [[ ! -e Makefile ]] && [[ ! -e GNUmakefile ]]; then
         echo "There is no makefile in the build directory" >> ../$buildLog
         echo $Separator >> ../$buildLog
         mv ../$buildLog ../$spid.txt
         exit 6
      fi


exit 0