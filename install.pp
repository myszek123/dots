Exec { path =>  [ "/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"] }

$user   = "jmyszka"
$home   = "/home/${user}/"
$source = "/home/${user}/dots/dots/"

filebucket { 'main':
  path => '/tmp/',
}

include common 
include server
include workstation

exec { 'pear upgrade':
  command => "pear upgrade PEAR",
}

exec { 'phpqatools':
  command => "pear config-set auto_discover 1; pear install pear.phpqatools.org/phpqatools",
  unless  => "pear list -c phpqatools"
}

exec { 'phing':
  command => "pear channel-discover pear.phing.info; pear install --alldeps phing/phing",
  unless  => "pear list -c phing"
}


#import 'modules/workstation.pp'
#import 'modules/common.pp'
#import 'modules/workstation.pp'
