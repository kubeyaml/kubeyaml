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

cp $ROOT/kustomizations/$YAML   _temp/kustomization.yaml
kubectl kustomize --enable-helm _temp/ -o _temp/_rendered/
rm -rf             yamls/$NAME
mv _temp/_rendered yamls/$NAME

rm -rf   _temp
exit
done

