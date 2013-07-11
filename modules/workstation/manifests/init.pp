class workstation {
  package{["xmonad","xsel","gnome-do","gnome-do-plugins","gnome-panel","parcellite","vlc","firefox","vim-gnome","xvfb","python-rbtools"]:
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
    ensure   => present,
    provider => git,
    source   => 'git@github.com:dalibo/pgbadger.git',
  }

  file{"${home}.pentadactylrc":
    ensure => 'file',
    source => 'puppet:///modules/workstation/.pentadactylrc',
  }

  file{"${home}.pentadactyl":
    ensure  => 'directory',
    source  => 'puppet:///modules/workstation/.pentadactyl',
    recurse => true,
  }

  file{"${home}/.xmonad":
    ensure => 'directory',
  }

  file{"${home}/.xmonad/xmonad.hs":
    ensure => 'file',
    source => 'puppet:///modules/workstation/xmonad.hs',
  }

  File["${home}/.xmonad"] -> File["${home}/.xmonad/xmonad.hs"]

  # because of xmonad i need haskell so it would be nice to have haskell suppot in vim 
  # because of that, in spf13 haskell group installs things that requie to install hdevtools and addional setup handled in the dots repo

  # font for terminal
  # wget http://www.levien.com/type/myfonts/Inconsolata.otf ~/.fonts/
  # gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/font "Inconsolata Medium 10"


  # this is done as a sort of interesting excercise
  # here is how to install firefox plugin 'manually ' http://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
  # and below is fairly simple way to do it (but probably this will not work with all available plugins.. )
  # mv extensions.xpi /usr/share/mozilla/extensions/`unzip -c extensions.xpi install.rdf | egrep "em:id.*{" | sed 's/.*\({.*}\).*/\1/' | head -1`.xpi
  # this needs to be tested
}
