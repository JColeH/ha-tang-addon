# Home LAN Tang add-on

Source-only Home Assistant add-on repository. Install only on a trusted home LAN. Tang intentionally has no client authentication. Do not forward port 9090 to the internet.

The `tang` add-on uses Debian's upstream C Tang package and a separate persistent database under `/data/tang`. Keys are generated at first start, never during image build. No keys belong in this repository.

Development status: prepared, shell syntax checked, image not built or runtime-tested yet. Do not use for disk binding until test-string up/down/restart checks pass.
