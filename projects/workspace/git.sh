#!/bin/bash
echo "----------------- RUNNING [git reset --hard HEAD]"
git reset --hard HEAD
echo "----------------- RUNNING [git checkout $1]"
git checkout $1
exec bash