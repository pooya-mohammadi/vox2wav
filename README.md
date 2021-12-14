# vox2wav

Converting Vox files to Wav or other formats that are easy to workaround.


## What are Vox files?

VOX files are audio files used in speech applications. Usually they contain pre-recorded voice prompts. Because voice networks have relatively low bandwidth the audio used can be sampled at a fairly low rate (an ISDN "B" channel carries only 8kHz voice). Consequently, VOX files are often 8kHz (although 6kHz is also possible).

VOX files can contain audio in different formats. There are at least four different formats:

    Raw A-law
    Raw mu-law
    8kHz 4-bit ADPCM (also known as IMA/OKI ADPCM)
    6kHz 4-bit ADPCM

There is no file header inside a VOX file, only audio samples, so there is no way to know which format a particular file contains. If you play it and it sounds bad (i.e. distorted, wrong speed/pitch, or just ‘noise’), then you are not playing it back in the same way that it was recorded. 

VOX files have been long associated with the Dialogic® DMV and JCT Media Boards, and customers often have collections of recorded prompts stored in "VOX format".

Using this bash file you can convert a directory full of vox files ending with .V3(this is the default value you can change it) to wav or other formats.
[reference](https://www.dialogic.com/support/helpweb/helpweb.aspx/394/vox_and_vap_files/en)

#Installation
In case you don't have ffmpeg installed on you os, install with the following commands:

```terminal
sudo apt update
sudo apt install ffmpeg
```

# Converting a single file
To check all the supported codecs by ffmpeg run the following command:
```
ffmpeg -codecs
# or grep a specific keyword
ffmpeg -codecs | grep adpcm 
```
Based on the description choose a codecs that satisfies your needs.

```bash
vox_path=path-to-vox-file
wav_path=output-path
ffmpeg -f u8 -c adpcm_ima_oki -ar 6.0k -ac 1 -i $vox_path $wav_path
```
Name | description 
--- |-------------|
-f | file format, u8: unsigned 8-bit
-c | file codec, adpcm_ima_oki: ADPCM IMA Dialogic OKI
-ar | rate, set audio sampling rate (in Hz)
-ac | channels, set number of audio channels
-i | input file path


# Converting a directory of vox files
```bash
vox_dir=path-to-vox-dir
wav_dir=output-dir
vox_ext=.V3
bash Vox2Wav.sh $vox_dir $wav_dir $vox_ext
```