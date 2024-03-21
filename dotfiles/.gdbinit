# Useful reference for several gdbinit commands

## Define function with arguments
# define myfun
#   print $arg1
#   print $arg2
# end



## Configuration options
# set follow-fork-mode child
# set detach-on-fork off
# set breakpoing pending on
# set print pretty on
## Catch multiprocessing before they complete
# catch exec
# catch fork
## Print environment variables
# print environ["VAR"]

## Tips
# - Remember to use gdb checkpoints to go back in time
