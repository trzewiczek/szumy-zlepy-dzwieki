public class Player extends Beet
{
    // this should be reimplemented with a new 
    // buffer list objects - next time

    // fields track
    int _num_field;
    int _cur_field;
    SndBuf _field[ Globals.MAX_BUFFERS ];
    string _field_names[ Globals.MAX_BUFFERS ];

    // voice track
    int _num_voche;
    int _cur_voche;
    SndBuf _voche[ Globals.MAX_BUFFERS ];
    string _voche_names[ Globals.MAX_BUFFERS ];

    Gain _gain;
    float _stamina;


    // Constructor
    { 
        0.0 => _stamina;
        0.5 => _gain.gain;

        _voche[0] => _gain; 
        _field[0] => _gain;
        
        _gain    @=> _output;
         dac     @=> _connect;
         
         _output  => _connect;
    }

    
    // see the comment on top!
    fun int add_field( string file_name )
    {
        file_name  => _field[ _num_field ].read;
        file_name @=> _field_names[ _num_field ];
        1 +=> _num_field;

        return _num_field;
    }

    
    fun int add_voche( string file_name )
    {
        file_name  => _voche[ _num_voche ].read;
        file_name @=> _voche_names[ _num_voche ];
        1 +=> _num_voche;

        return _num_voche;
    }


    fun int random_field()
    {
        int new_file;
        // circular buffer used not to pick the same file twce in a row
        ( Std.rand2( 1, _num_field-1 ) + _cur_field ) % _num_field => new_file;

        _field[ _cur_field ] =< _output;
        new_file => _cur_field;
        _field[ _cur_field ] => _output;            

        return _cur_field;
    }


    fun int random_voche()
    {
        int new_file;
        // circular buffer used not to pick the same file twce in a row
        ( Std.rand2( 1, _num_voche-1 ) + _cur_voche ) % _num_voche => new_file;

        _voche[ _cur_voche ] =< _output;
        new_file => _cur_voche;
        _voche[ _cur_voche ] => _output;            

        return _cur_voche;
    }

    
    fun void stamina_handler( float stm ) {
        if( stm < 0.05 ) {
            0.0 => _stamina;
        }
        else if( stm < 0.6 ) {
            0.5 => _stamina;
        }
        else {
            Utils.map( stm, 0.4, 1.0, 0.5, 0.0 ) => _stamina;
        }
    }

    // URGENT: no local_loop here --> it should be implemented in subclasses
    //         no abstract method in ChucK though......
}
