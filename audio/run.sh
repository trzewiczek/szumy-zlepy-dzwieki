#!/bin/sh

UTILS="Utils/Globals Utils/Utils"
LOADERS="Loaders/Loader_noise Loaders/Loader_voche Loaders/Loader_inter Loaders/Loader_field"
BEETS="Beets/Beet Beets/Stammer Beets/Player Beets/Voche_player Beets/Noise_player Beets/Field_player"

## To be used when working with alsa
chuck-alsa $UTILS $BEETS $LOADERS main


