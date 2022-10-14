# This here make file contains shortcuts provided by the developer which enable the person presented with
# repository to easily build and launch the project. 
# This in effect enables the user to be oblivious of the right bash commands, and their options.
# If further functionality is required, which surpasses the scope of the functionality provided in this 
# makefile, we encourage you to document yourself about it, and, if considered as a vital addition to the 
# spectrum of commands that ought to be available to the whole user base, to add it.
#
# @author Andrei-Paul Ionescu.

# Build the project, that implies running the main.lua file hence the corresponding bash command for achieving
# that.
build: 
		open -n -a love .