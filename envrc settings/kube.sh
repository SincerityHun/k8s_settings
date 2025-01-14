#!/bin/bash
COMMAND=$1
KUBE_DIR=".kube"
CONFIG_FILE="$KUBE_DIR/config"
HOME_KUBE_DIR="$HOME/.kube"
HOME_CONFIG_FILE="$HOME_KUBE_DIR/config"

# config 명령 처리
if [ "$COMMAND" = "config" ]; then
    echo "Executing 'config' command..."

    # 현재 폴더에 .kube 디렉터리 확인
    if [ ! -d "$KUBE_DIR" ]; then
        echo "Creating $KUBE_DIR directory in the current folder."
        mkdir "$KUBE_DIR"
    else
        echo "$KUBE_DIR directory already exists."
    fi

    # ~/.kube/config 파일 존재 확인
    if [ -f "$HOME_CONFIG_FILE" ]; then
        if [ -f "$CONFIG_FILE" ]; then
            read -p "Do you want to overwrite the existing config file? (y/n): " RESPONSE
            if [ "$RESPONSE" = "y" ]; then
                echo "Overwriting $HOME_CONFIG_FILE."
                cp "$HOME_CONFIG_FILE" "$CONFIG_FILE"
                echo "Config file copied to $CONFIG_FILE."
            else
                echo "Keeping the existing config file. No changes made."
            fi
        else
            echo "Copying $HOME_CONFIG_FILE to $CONFIG_FILE."
            cp "$HOME_CONFIG_FILE" "$CONFIG_FILE"
            echo "Config file copied to $CONFIG_FILE."
        fi
    else
        echo "No kube config file found in $HOME_KUBE_DIR."
    fi
else
    echo "Invalid command. Usage: ./kube.sh config"
fi
