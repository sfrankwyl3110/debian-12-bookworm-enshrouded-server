#!/bin/bash

APP_ID=2278520

SERVER_DIR=/home/enshrouded/enshroudedserver
SERVER_DIR_SAVEGAME=/home/enshrouded/enshroudedserver/savegame
SERVER_DIR_LOGS=/home/enshrouded/enshroudedserver/logs

BACKUP_DIR=/home/enshrouded/enshrouded_Backups

CURRENT_BACKUP_FOLDER=$BACKUP_DIR/enshrouded_$(date '+%Y-%m-%d_%H-%M-%S')

PWD=$(pwd)



# create backup-dir if it does not exist
if [[ ! -d $BACKUP_DIR ]]; then
	mkdir -p $BACKUP_DIR
fi


# update server
/usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir $SERVER_DIR +login anonymous +app_update $APP_ID +quit

mkdir -p $CURRENT_BACKUP_FOLDER

cp -R $SERVER_DIR_SAVEGAME $CURRENT_BACKUP_FOLDER/
cp -R $SERVER_DIR_LOGS $CURRENT_BACKUP_FOLDER/

DIR_NAME=$(basename $CURRENT_BACKUP_FOLDER)

cd $CURRENT_BACKUP_FOLDER

## zip server-dir to backup
tar -czvf $BACKUP_DIR/"${DIR_NAME}.tar.gz" *

cd $PWD

rm -rf $CURRENT_BACKUP_FOLDER

## delete backups
# find ${BACKUP_DIR}/ -mtime +10 -type f -delete
