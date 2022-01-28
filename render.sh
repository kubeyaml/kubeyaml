#!/bin/bash

cd $(dirname $0)/
ROOT=$(pwd)

cd kustomizations/
YAMLS=$(ls *.yaml)

cd ..
select YAML in $YAMLS; do
NAME=$(basename $YAML .yaml)
rm -rf   _temp
mkdir -p _temp/_rendered

cd _temp
cp $ROOT/kustomizations/$YAML kustomization.yaml
kubectl kustomize --enable-helm . -o _rendered/

cd _rendered/
FILES=$(ls *.yaml)
for FILE in $FILES; do
    KIND=$(grep ^kind: $FILE | awk '{print tolower($2)}')
    NEWFILE=$(echo $FILE | grep -o $KIND.*)
    mv $FILE $NEWFILE
done

cd $ROOT
rm -rf             yamls/$NAME
mv _temp/_rendered yamls/$NAME

rm -rf   _temp
exit
done

