import os, sys

def header():
    return """/**
 *  This file has been generated by the Loader Generator script.
 *
 *  Example:
 *      my_player => Loader_"""+ sys.argv[2] +""".load_"""+ sys.argv[2] +""";
 */

public class Loader_"""+ sys.argv[2] +"""
{
    // load my smaples into the Looper
    fun static void load_"""+ sys.argv[2] +"""( Player player )
    {
        <<< "Loading", "sound files - relax!" >>>;

"""


def footer():
    return """
        <<< "Superb!!", "Sound files loaded!" >>>;
    }
}
"""


if __name__ == '__main__':

    if len( sys.argv ) < 3:
        print "python loader_generator.py <audio_files_path> <file_name>"
        sys.exit(-1)

    # audio files dir
    in_path = sys.argv[1]

    # create an output file
    out_path = './Loader_' + sys.argv[2] + '.ck'

    out_file = open( out_path, 'w' )

    # write file header
    out_file.write( header() )

    # load file names and sort them alphabeticaly
    files = os.listdir( in_path )
    files.sort()

    # add files with a <<< >>> debug string
    indent = '        '
    for f in files:
        if '.wav' in f or '.aiff' in f:
            file_path = in_path + f
            out_file.write( indent + '<<< "Loading", "' + f + '" >>>;\n' )
            out_file.write( indent + '"' + file_path )
            out_file.write( '" => player.add_' + sys.argv[2] + ';' )
            out_file.write( '\n\n' )

    # add footer and close file
    out_file.write( footer() )
    out_file.close()
