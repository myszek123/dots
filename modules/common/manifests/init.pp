class common {
  package{["colordiff","curl","rake","rubygems","git-core","tig","subversion","subversion-tools","htop","exuberant-ctags","ack-grep","wget","build-essential","apt-fast"]:
    ensure	=> present
  }
  #usefull for new tmux config (fox x env)
  #urlview urxvtc(rxvt-unicode)
  exec { 'divert ack':
    command => "dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep",
    creates => "/usr/bin/ack",
    require => Package["ack-grep"],
  }

  exec { 'apt-fast':
    command => "add-apt-repository ppa:apt-fast/stable -y; apt-get update",
    unless  => "dpkg-query -l apt-fast"
  }

  file{"${home}.psqlrc":
    ensure => 'file',
    source => 'puppet:///modules/common/.psqlrc',
  }

  Exec["apt-fast"] -> Package["apt-fast"]

  include common::tmux 

}
