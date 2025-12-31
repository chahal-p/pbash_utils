#!/usr/bin/env bash
function _complete_pbu.openssl.decode-cert() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform" -- "$cur") )
}
complete -F _complete_pbu.openssl.decode-cert pbu.openssl.decode-cert

function _complete_pbu.openssl.decode-csr() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform" -- "$cur") )
}
complete -F _complete_pbu.openssl.decode-csr pbu.openssl.decode-csr

function _complete_pbu.openssl.decode-crl() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file" -- "$cur") )
}
complete -F _complete_pbu.openssl.decode-crl pbu.openssl.decode-crl

function _complete_pbu.openssl.decode-key() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform --type" -- "$cur") )
}
complete -F _complete_pbu.openssl.decode-key pbu.openssl.decode-key

function _complete_pbu.openssl.decode-asn1() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform" -- "$cur") )
}
complete -F _complete_pbu.openssl.decode-asn1 pbu.openssl.decode-asn1

function _complete_pbu.openssl.tbs-extract() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform -o --outfile" -- "$cur") )
}
complete -F _complete_pbu.openssl.tbs-extract pbu.openssl.tbs-extract

function _complete_pbu.openssl.signature-extract() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file --inform -o --outfile" -- "$cur") )
}
complete -F _complete_pbu.openssl.signature-extract pbu.openssl.signature-extract

function _complete_pbu.openssl.convert-x509-der-to-pem() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file -o --outfile" -- "$cur") )
}
complete -F _complete_pbu.openssl.convert-x509-der-to-pem pbu.openssl.convert-x509-der-to-pem

function _complete_pbu.openssl.convert-x509-pem-to-der() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file -o --outfile" -- "$cur") )
}
complete -F _complete_pbu.openssl.convert-x509-pem-to-der pbu.openssl.convert-x509-pem-to-der

function _complete_pbu.openssl.publickey-extract() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -f -W "-f --file -o --outfile --inform --outform" -- "$cur") )
}
complete -F _complete_pbu.openssl.publickey-extract pbu.openssl.publickey-extract
