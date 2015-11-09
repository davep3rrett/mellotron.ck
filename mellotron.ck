// MIDI setup
MidiIn min;
MidiMsg msg;
min.open(1); // hardcoding device for now - config file?

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

// for now, we will assume that the sample played back at its natural speed
// is middle C (MIDI value 60, actual frequency 261.625565)

// so to determine playback rate, we will divide Std.mtof(input_note) by Std.mtof(60).
// maybe the denominator will later be set in a config file, along with other stuff.

fun void setRate(int midiNote) {
  Std.mtof(midiNote) / Std.mtof(60) => buf.rate;
}

while(true) {

  min => now;
	while(min.recv(msg)) {
    setRate(msg.data2);

  // this is kind of a wack hack - checking if the velocity is 0 or not
	// to toggle keyOn() and keyOff(). i should really be using the status byte
	// to check for note on/off, but this approach is "channel agnostic".
	// i'll dig into the documentation to see if ChucK has a built in way
	// of interpreting the status byte. but this works for now ;)
	
  if(msg.data3 == 0) {
		  env.keyOff();
		}
		else if(msg.data3 != 0) {
		  env.keyOn();
		}
  }

  10::ms => now;
}
