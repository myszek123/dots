class workstation {
  package{["xmonad","xsel","gnome-do","gnome-do-plugins","gnome-panel","parcellite","vlc","firefox","vim-gnome","xvfb"]:
    ensure	=> present
  }

  package { 'bcat':
    ensure	=> present,
    provider => 'gem',
  }

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
}
