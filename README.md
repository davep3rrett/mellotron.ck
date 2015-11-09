#mellotron.ck

###a soft-mellotron written in ChucK

This project aims to provide a simple mellotron emulator to be played using a keyboard MIDI controller. `mellotron.ck` can use any arbitrary sample in `.wav` format as its voice.

Samples need to be stored in a directory named "samples", which should live in the same directory that `mellotron.ck` is being run from.

`mellotron.ck` is intended to be used on a Linux system with JACK running. This document assumes you aready have JACK and ChucK installed and know something about using them.

Telling `mellotron.ck` which MIDI device to take input from requires a little bit of work on the part of the user:

You should run `chuck --probe` to output a list of available MIDI devices, and determine the integer ID of the device you want to use.

####directory layout

```
| mellotron.ck
| samples/
|--- flute.wav
|--- oboe.wav
```
####command line arguments

invoking `mellotron.ck` requires at least two command line arguments - the filename of the sample to be loaded, and the integer ID number of the MIDI device to be used.

Optionally, as a third argument, the user can provide an integer to change the 'offset' - a higher integer results in lower pitch, and a lower integer results in a higher pitch. This could possibly come in handy if you're using a MIDI controller with no octave switching.

####running mellotron.ck

a sample invocation:

`chuck mellotron.ck:flute.wav:1`

once the program is running, you may jam ;)