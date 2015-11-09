// command line args
string sampleName;
int deviceID;
60 => int centerNote;

if(me.args() < 2) {
  <<<"Please provide arguments for sample and MIDI device!">>>;
  me.exit();
}

me.arg(0) => sampleName;
Std.atoi(me.arg(1)) => deviceID;

if(me.args() > 2) {
  Std.atoi(me.arg(2)) => centerNote;
}

// MIDI setup
MidiIn min;
MidiMsg msg;
min.open(deviceID);

// load sample and set up patch
me.sourceDir() + "samples/" + sampleName => string filename;
SndBuf buf => Envelope env => dac;
filename => buf.read;

// some more setup
0.3 => buf.gain; // not too loud
1 => buf.loop;
0 => buf.pos;

fun void setRate(int midiNote) {
  Std.mtof(midiNote) / Std.mtof(centerNote) => buf.rate;
}

// TODO: include a flag where user can decide whether sample continuously loops
// regardless of keyOn() / keyOff(), or if the sample restarts at position 0 with
// each key press. right now it just continuously loops.

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