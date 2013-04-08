filebucket { 'main':
  path => '/tmp/',
}

#terminal
package{["tmux","colordiff","curl","rake","rubygems","git-core","subversion","subversion-tools","htop","exuberant-ctags"]:
  ensure	=> present
}

#development
package{["apache2","postgresql"]:
  ensure	=> present
}

#others
package{["xmonad","xsel","gnome-do","gnome-do-plugins","gnome-panel","parcellite","vlc","firefox","vim-gnome"]:
  ensure	=> present
}
package { 'bcat':
  ensure	=> present,
  provider => 'gem',
}

Package["rubygems"] -> Package["bcat"]

$user   = "jmyszka"
$home   = "/home/${user}/"
$source = "/home/${user}/dots/dots/"

file{"${home}.pentadactylrc":
  ensure => 'link',
  target => "${source}.pentadactylrc",
}

file{"${home}.pentadactyl":
  ensure => 'link',
  target => "${source}.pentadactyl",
}
