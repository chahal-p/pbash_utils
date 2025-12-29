#!/usr/bin/env bash

complete -d -f -W "-f --file --inform" pbu.openssl.decode-cert 
complete -d -f -W "-f --file --inform" pbu.openssl.decode-csr
complete -d -f -W "-f --file" pbu.openssl.decode-crl
complete -d -f -W "-f --file --inform --type" pbu.openssl.decode-key
complete -d -f -W "-f --file --inform" pbu.openssl.decode-asn1
complete -d -f -W "-f --file --inform -o --outfile" pbu.openssl.tbs-extract
complete -d -f -W "-f --file --inform -o --outfile" pbu.openssl.signature-extract
complete -d -f -W "-f --file -o --outfile" pbu.openssl.convert-x509-der-to-pem
complete -d -f -W "-f --file -o --outfile" pbu.openssl.convert-x509-pem-to-der
complete -d -f -W "-f --file -o --outfile --inform --outform" pbu.openssl.publickey-extract