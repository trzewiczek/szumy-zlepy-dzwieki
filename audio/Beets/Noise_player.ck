public class Noise_player extends Player {
    
    fun void local_loop() {
        // nested loops for changing sound files
        while( true ) {
            // print current file name
            // <<< _voche_names[ _cur_voche ] >>>;

            // set the end time for the internal loop
            now + _voche[ _cur_voche ].length() => time finito;
            // reset the buffer position
            0 => _voche[ _cur_voche ].pos;

            while( true ) {
                // when end of file reached
                if( now > finito ) {
                    break;
                }
                // update the gain level according to current stamina value
                _stamina => _gain.gain;
                10::ms => now;
            }

            // pick a new file
            random_voche();
        }
    }
}
