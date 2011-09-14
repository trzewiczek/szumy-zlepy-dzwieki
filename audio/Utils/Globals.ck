/*
 * This class provides a collection of common
 * globals. It's static so the initialization
 * happens outside the class code.
 * static constant NONE "overrides" functionally
 * null value, by assigning a stupid never
 * to be used value to this name as null happens
 * to be risky in more dynamic use.
 */

public class Globals
{
    static int MAX_BUFFERS;
    static int NONE;
}


300  => Globals.MAX_BUFFERS;
1410 => Globals.NONE;
