#!/bin/bash
cd /Volumes/Daten/VMs/ocr

export PATH=$PATH:/usr/local/bin

docker-compose run --rm docker-ocr pdfocr

echo Done.
