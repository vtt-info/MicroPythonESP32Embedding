SERIALPORT=${1:-COM5}
SERIALBAUD=${2:-2000000}
IPORHOSTNAME=${3:-}
. $HOME/esp/esp-idf/export.sh
idf.py build &&\
python.exe $IDF_PATH/components/esptool_py/esptool/esptool.py -p$SERIALPORT -b$SERIALBAUD --before default_reset --after hard_reset --chip esp32  write_flash --flash_mode dio --flash_size detect --flash_freq 40m 0x1000 build/bootloader/bootloader.bin 0x8000 build/partition_table/partition-table.bin 0xe000 build/ota_data_initial.bin 0x10000 build/MicroPythonEmbedding.bin
if [ $? -eq "0" ] 
  then
    python.exe scripts/SerialMonitor_curses.py $SERIALPORT -g
fi
