#!/bin/bash
cd $1
bash $2/apply-autostart.sh $3 $4
bash $2/main.sh
exec bash