// choose a file, hardcoding for now
me.sourceDir() + "samples/flute.wav" => string filename;

//the patch
SndBuf buf => Envelope env => dac;

// load the sample
filename => buf.read;

// set some stuff
0.2 => buf.gain;
1 => buf.loop;
0 => buf.pos;

// turn the envelope on
env.keyOn();

// for now, we will assume that the sample played back at its natural speed
// is middle C (MIDI value 60, actual frequency 261.625565)

// so to determine playback rate, we will divide Std.mtof(input_note) by Std.mtof(60).
// maybe the denominator will later be set in a config file, along with other stuff.

fun void setRate(int midiNote) {
  Std.mtof(midiNote) / Std.mtof(60) => buf.rate;
}

// test some random midi notes
while(true) {
  setRate(Math.random2(50, 70));
  3::second => now;
}
