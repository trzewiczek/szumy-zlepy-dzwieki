public class Field_player extends Player {

    // fields play with a huge pause inbetween
    // so a new class was established    
    1 => int was_paused;

    fun void local_loop() {
        // nested loops for changing sound files
        while( true ) {
            time finito;

            // previously was paused - go for file now
            if( was_paused == 1 ) {
                // print current file name
                // <<< _field_names[ _cur_field ] >>>;

                // set the end time for the internal loop
                now + _field[ _cur_field ].length() => finito;
                // reset the buffer position
                0 => _field[ _cur_field ].pos;
                0 => was_paused;
            }
            else {
                // 0.5-1.5 minutes of silence
                now + Std.rand2( 30, 90 )::second => finito;
                1 => was_paused;
            }

            while( true ) {
                // when end of file reached
                if( now > finito ) {
                    break;
                }

                _stamina => _gain.gain;
                10::ms => now;
            }

            // after finishing the file, pick another one
            if( was_paused == 0 ) {
                // pick a new file
                random_field();
            }
        }
    }
    
}
