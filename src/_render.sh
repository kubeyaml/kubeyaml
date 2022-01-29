#!/bin/bash

cd $(dirname $0)/..
ROOT=$(pwd)

cd src/
PACKAGES=$(python3 list_packages.py)

select PACKAGE in $PACKAGES; do
    rm -rf   _temp
    mkdir -p _temp/_rendered
    
    # python3 render_pacakge.py $PACKAGE
    # exit

    python3 render_pacakge.py $PACKAGE > _temp/kustomization.yaml
    kubectl kustomize --enable-helm _temp/ -o _temp/_rendered/
    
    # exit

    cd _temp/_rendered/
    FILES=$(ls *.yaml)
    for FILE in $FILES; do
        KIND=$(grep ^kind: $FILE | awk '{print tolower($2)}')
        NEWFILE=$(echo $FILE | grep -o ${KIND}_.*)
        mv $FILE $NEWFILE
    done

    cd $ROOT
    rm -rf                     yamls/$PACKAGE
    mv     src/_temp/_rendered yamls/$PACKAGE
    rm -rf src/_temp
    
    echo Done...
    exit
done

