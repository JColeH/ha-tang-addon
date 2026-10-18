# Home LAN Tang add-on

Source-only Home Assistant add-on repository. Install only on a trusted home LAN. Tang intentionally has no client authentication. Do not forward port 9090 to the internet.

The `tang` add-on uses Debian's upstream C Tang package and a separate persistent database under `/data/tang`. Keys are generated at first start, never during image build. No keys belong in this repository.

Initial deployment: image built successfully on aarch64 Home Assistant OS. Clevis test-string encryption and exact plaintext recovery passed with Tang up, failed cleanly with Tang stopped, and passed again using the original ciphertext after start and restart. The signing fingerprint was compared against authenticated HA logs. Boot auto and watchdog were restored after testing. Disk binding and early-boot integration are separate, untested steps.
