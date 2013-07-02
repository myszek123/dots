class qa {
  package{["phantomjs"]:
    ensure	=> present
  }
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
}
