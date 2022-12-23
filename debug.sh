#!/bin/bash
version="$(date +%F_T"%H-%M-%S")"
out="$(pwd)/out-ide"

rm -rf $out
mkdir $out
docker build . -f Dockerfile -t ide:$version
docker create --name $version ide:$version sh
docker export $version -o=$out/ide.tar
tar -C $out -xvf $out/ide.tar ide
rm -rf $out/ide.tar
docker rm $version
gp-run --ide-path /workspace/ide
