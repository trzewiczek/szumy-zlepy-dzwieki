OscRecv osc_receiver;
5601 => osc_receiver.port;
osc_receiver.listen();
spork ~ get_stamina( osc_receiver.event( "/miron/stamina,f" ) );

Noise wn => LPF f => dac;
4500 => f.freq;
 0.5 => f.Q;

Stammer st;
st.play();

// this section is a shit and should be reimplemented
// this a Player array - to be done next time
Voche_player vp;
Loader_voche.load_voche( vp );
Loader_inter.load_field( vp );
vp.play();

Field_player fp;
Loader_field.load_field( fp );
fp.play();

Noise_player np;
Loader_noise.load_voche( np );
np.play();


// main time loop
while( true ) 
{
    1::samp => now;
}


// OSC handler
fun void get_stamina( OscEvent e ) 
{
    while( true ) {
        e => now;
        
        while( e.nextMsg() != 0 )
        {
            e.getFloat() => float stamina;
            <<< "OSC:", stamina >>>;

            //  make three stages:
            //  0.00-0.05  white noise
            //  0.05-0.40  stamming voices
            //  0.40-1.00  normal voices
            if( stamina < 0.05 ) {
                0.5 => f.gain;
            }
            else if( stamina < 0.4 ) {
                vp.connect( st );
                fp.connect( st );
                np.connect( st );
                
                0.0 => f.gain;
            }
            else {
                vp.connect( dac );
                fp.connect( dac );
                np.connect( dac );
                
                0.0 => f.gain;
            }

            // handle the incoming stamina properly
            vp.stamina_handler( stamina );
            fp.stamina_handler( stamina );
            np.stamina_handler( stamina );
        }

        10::ms => now;
    }
}
