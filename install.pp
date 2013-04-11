Exec { path =>  [ "/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"] }

$user   = "jmyszka"
$home   = "/home/${user}/"
$source = "/home/${user}/dots/dots/"

filebucket { 'main':
  path => '/tmp/',
}

#terminal
package{["colordiff","curl","rake","rubygems","git-core","tig","subversion","subversion-tools","htop","exuberant-ctags","ack-grep","wget","build-essential"]:
  ensure	=> present
}

#development
package{["apache2","postgresql","nodejs", "memcached","php-pear","php5-dev"]:
  ensure	=> present
}

exec { 'phpqatools':
  command => "pear upgrade PEAR; pear config-set auto_discover 1; pear install pear.phpqatools.org/phpqatools",
}

exec { 'phing':
  command => "pear channel-discover pear.phing.info; pear install --alldeps phing/phing",
}

#others
package{["xmonad","xsel","gnome-do","gnome-do-plugins","gnome-panel","parcellite","vlc","firefox","vim-gnome","xvfb","apt-fast"]:
  ensure	=> present
}

package { 'bcat':
  ensure	=> present,
  provider => 'gem',
}

exec { 'divert ack':
  command => "dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep",
  creates => "/usr/bin/ack",
  require => Package["ack-grep"],
}

require 'tmux'

exec { 'apt-fast':
  command => "add-apt-repository ppa:apt-fast/stable; apt-get update",
  require => Package["ack-grep"],
}

Exec["apt-fast"] -> Package["apt-fast"]
Package["rubygems"] -> Package["bcat"]


exec{ "git_repos_folder":
  command => "mkdir -p ${home}/projects/github/",
  unless  => "[ -d ${home}/projects/github/ ]",
}

vcsrepo { "${home}/projects/github/pgbadger":
  ensure => present,
  provider => git,
  source => 'git@github.com:dalibo/pgbadger.git',
}

file{"${home}.pentadactylrc":
  ensure => 'link',
  target => "${source}.pentadactylrc",
}

file{"${home}.pentadactyl":
  ensure => 'link',
  target => "${source}.pentadactyl",
}

file{"${home}.tmux.conf":
  ensure => 'link',
  target => "${source}.tmux.conf",
}
