# Tang setup and recovery

1. Install, enable start-on-boot and watchdog, then start. No options or privileged access are needed. Endpoint is `http://<HA LAN address>:9090`.
2. Compare the LAN signing fingerprint with one of the `Tang public key thumbprint:` lines in the add-on's authenticated HA logs. The server logs fingerprints of both its keys; the client must select its advertised signing key. These are public fingerprints, not keys. Alternatively use `tang-show-keys 9090` inside the container through an authorized management session. Do not paste keys or the database into chat.
3. Test only a nonsecret string first: encrypt/decrypt, stop the service and confirm failure, restore/restart and decrypt the original ciphertext again. Disable watchdog temporarily for a deliberate outage and restore it afterward.
4. The database in `/data/tang` survives restart and add-on updates, but may be deleted on uninstall. Protect HA backups with encryption. A backup holding this database is unlock-enabling material.
5. If startup reports an incomplete database, missing keys or invalid keys, stop and investigate. Do not delete the database or generate replacements to silence the error. Restore only through an approved secure backup procedure. Never change the existing disk passphrase slot.
6. This initial version expects exactly two key files. Key rotation requires a reviewed update; do not add/rename/delete key files casually.
7. HA availability will be required for automatic unlock. Passphrase fallback and early-boot networking must be configured and tested separately. Installing this server makes no changes to colarchy's disk or boot configuration.
