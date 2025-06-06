#!/usr/bin/env bash

complete -d -f -W "-f --file --inform" openssl-decode-cert 
complete -d -f -W "-f --file --inform" openssl-decode-csr
complete -d -f -W "-f --file" openssl-decode-crl
complete -d -f -W "-f --file --inform --type" openssl-decode-key
complete -d -f -W "-f --file --inform" openssl-decode-asn1
complete -d -f -W "-f --file --inform -o --outfile" openssl-tbs-extract
complete -d -f -W "-f --file --inform -o --outfile" openssl-signature-extract
complete -d -f -W "-f --file -o --outfile" openssl-convert-x509-der-to-pem
complete -d -f -W "-f --file -o --outfile" openssl-convert-x509-pem-to-der
complete -d -f -W "-f --file -o --outfile --inform --outform" openssl-publickey-extract