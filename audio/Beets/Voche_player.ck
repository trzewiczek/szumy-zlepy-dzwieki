public class Voche_player extends Player {

    int _was_field;
    int _full_mode;


    {
        0 => _full_mode;
        0 => _was_field;
    }


    fun void stamina_handler( float stm ) {
        if( stm < 0.05 ) {
            0.0 => _stamina;
        }
        else if( stm < 0.6 ) {
            0.5 => _stamina;
            0   => _full_mode; 
        }
        else {
            0.5 => _stamina;
            1   => _full_mode;
        }
    }


    fun void local_loop() {
        // turn off the fields at the beinning
        _field[ 0 ] =< _gain;

        // nested loops for changing sound files
        while( true ) {
            time finito;

            if( _full_mode == 0 ) {
                // print current file name
                <<< "Half mode:", _voche_names[ _cur_voche ] >>>;

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
            else {
                // previously was paused - go for file now
                if( _was_field == 0 ) {
                    // print current file name
                    <<< "Full mode (field):", _field_names[ _cur_field ] >>>;

                    // set the end time for the internal loop
                    now + _field[ _cur_field ].length() => finito;
                    // reset the buffer position
                    0 => _field[ _cur_field ].pos;
                    1 => _was_field;
                    _voche[ _cur_voche ] =< _gain;
                    _field[ _cur_field ] => _gain;
                }
                else {
                    // print current file name
                    <<< "Full mode (voche):", _voche_names[ _cur_voche ] >>>;

                    // set the end time for the internal loop
                    now + _voche[ _cur_voche ].length() => finito;
                    // reset the buffer position
                    0 => _voche[ _cur_voche ].pos;
                    0 => _was_field;
                    _voche[ _cur_voche ] => _gain;
                    _field[ _cur_field ] =< _gain;
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
                if( _was_field == 0 ) {
                    // pick a new file
                    random_field();
                }
                else {
                    random_voche();
                }
            }
        }
    }

}
