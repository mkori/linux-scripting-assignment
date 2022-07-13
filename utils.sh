#!/bin/bash

info ()
{
echo "[INFO] $@"
}

fatal () 
{

echo "[FATAL] $@"
return 123
}

help_info ()
{

echo "Use argument 'gen' to create log files under logs directory"
echo "Use argument 'rotate' to rotate log files having more than 20 lines."
echo "use argument 'clean' to delete all the log files except latest 5 files"

}
