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

env.keyOn();

while(true) {
  1::second => now;	
}