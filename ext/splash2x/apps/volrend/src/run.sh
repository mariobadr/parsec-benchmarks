#!/bin/sh

# Description:
#
# Runs the benchmark with a minimal problem size in a multiprocessor
# simulator.
#
# Usage:
#
# ./run.sh [NUMPROCS]
#

#Some default values
TARGET=volrend

#Arguments
if [ -n "$1" ]
then
  NUMPROCS="$1"
fi

if [ -n "$2" ]
then
  INPUTSIZE="$2"
fi


if [ -n "$3" ]
then
  echo "Error: Too many arguments!"
  echo 
  head -n11 $0 | tail -n9 | sed 's/#//'
  exit 1
fi


#Determine program name, file names & arguments
case "${INPUTSIZE}" in 
"test"	) 
	PROGARGS="${NUMPROCS} head-scaleddown4 4";;
"simdev"	) 
	PROGARGS="${NUMPROCS} head-scaleddown4 4";;
"simsmall"	) 
	PROGARGS="${NUMPROCS} head-scaleddown4 20";;
"simmedium"	) 
	PROGARGS="${NUMPROCS} head-scaleddown2 50";;
"simlarge"	) 
	PROGARGS="${NUMPROCS} head-scaleddown2 100";;
"native"	) 
	PROGARGS="${NUMPROCS} head 1000";;
*)  
	echo "Input size error"
	exit 1;;
esac
 
PROG="${PARSECDIR}/ext/splash2x/apps/${TARGET}/inst/${PARSECPLAT}/bin/${TARGET}"


#Some tests
if [ ! -x "$PROG" ]
then
  echo "Error: Binary ${PROG} does not exist!"
  exit 1
fi


#Execution
echo Generating input file ${INPUTFILE}...

RUN="$INSTRUMENTATION $PROG $PROGARGS"

echo "Running $RUN:"
eval $RUN


