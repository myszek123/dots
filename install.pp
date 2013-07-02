Exec { path =>  [ "/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"] }

$user   = "jakub.myszka"
$home   = "/home/${user}/"
$source = "/home/${user}/github/dots/"

filebucket { 'main':
  path => '/tmp/',
}

include common 
include server
include workstation
include qa
