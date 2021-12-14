#!/bin/bash

v3_dir=${1}
wav_dir=${2}
wox_ext=${3}

if [[ -z ${v3_dir} ]]; then
  echo "[ERROR] no argument variable is passed as a directory, exiting ..."
  exit 64
fi

if [[ ! -d ${v3_dir} ]]; then
  echo "[ERROR] There is no ${v3_dir} directory"
  exit 64
fi

if [[ -z ${wav_dir} ]]; then
  echo "[ERROR] no argument variable is passed as an output directory, exiting ..."
  exit 64
fi

if [[ ! -d ${wav_dir} ]]; then
  echo "[INFO] Creating ${wav_dir} directory"
  mkdir $wav_dir
fi

echo "[INFO] Converting v3 files in directory ${v3_dir}"
for sound_file in $(ls ${v3_dir}); do
  # get the full path
  if [[ ! $sound_file == *${wox_ext} ]]; then
    echo "[INFO] ${sound_file} is not valid"
    continue
  fi
  sound_path="${v3_dir}/${sound_file}"
  wav_path="${wav_dir}/${sound_file%${wox_ext}}.wav"
  ffmpeg -f u8 -c adpcm_ima_oki -ar 6.0k -ac 1 -i $sound_path $wav_path
  echo "[INFO] Converted ${sound_path} to ${wav_path}"
done


