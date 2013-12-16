class people::tikitikipoo {

  ## osx
  #
  # Finder
  include osx::finder::unhide_library
  class osx::finder::show_all_files {
    include osx::finder
    boxen::osx_defaults { 'Show all files':
      user   => $::boxen_user,
      domain => 'com.apple.finder',
      key    => 'AppleShowAllFiles',
      value  => true,
      notify => Exec['killall Finder'];
    }
  }
  include osx::finder::show_all_files

  # Dock
  include osx::dock::autohide
  class osx::dock::kill_dashbord{
    include osx::dock
    boxen::osx_defaults { 'kill dashbord':
      user   => $::boxen_user,
      domain => 'com.apple.dashboard',
      key    => 'mcx-disabled',
      value  => YES,
      notify => Exec['killall Dock'];
    }
  }
  include osx::dock::kill_dashbord

  # Universal Access
  include osx::universal_access::ctrl_mod_zoom
  include osx::universal_access::enable_scrollwheel_zoom

  # Miscellaneous
  include osx::no_network_dsstores # disable creation of .DS_Store files on network shares
  include osx::software_update # download and install software updates


  ## lib
  #
  include java
  include wget
  include imagemagick

#  include zsh
#  include redis
#  include phantomjs
#  phantomjs::version { '1.9.2': }
#  include heroku

  # ruby
  ruby::gem { "git-issue for 2.0.0-p247":
    gem     => 'git-issue',
    ruby    => '2.0.0-p247'
  }
  ruby::gem { "chef for 2.0.0-p247":
    gem     => 'chef',
    ruby    => '2.0.0-p247'
  }
  ruby::gem { "knife-solo for 2.0.0-p247":
    gem     => 'knife-solo',
    ruby    => '2.0.0-p247'
  }

  ## local application for develop
  #
  include pgadmin3
  include sequel_pro
  include virtualbox
  include vagrant
  vagrant::plugin { 'vagrant-berkshelf': }
  include sublime_text_2
  sublime_text_2::package { 'Emmet':
    source => 'sergeche/emmet-sublime'
  }
  include cyberduck
  include firefox
  include chrome

  ## local application for utility
  #
  include skype

  ## via homebrew
  #
  homebrew::tap { 'homebrew/binary': }
  homebrew::tap { 'homebrew/dupes': }
  package {
    [
      'httpd',                      # apache
      'tree',                       # linux tree cmd
      'proctools',                  # kill by process name. like $ pkill firefox
      'packer'                      # vagrant box maker

#      'readline',                   # use for ruby compile
#      'coreutils',                  # change mac command to like GNU Linux
#      'z',                          # shortcut change dir
#      'the_silver_searcher',        # alternative grep
#      'graphviz',                   # graph generator (use for rails-erd)
#      'ctags',                      # vim compel
#      'tmux',                       # terminal session
#      'reattach-to-user-namespace', # use tmux to clipbord
#      'tig',                        # git cui client
#      'git-extras',                 # git command extend
#      'ec2-api-tools',              # aws cli tools
#      'ec2-ami-tools',              # aws cli tools
#      'putty',                      # use convert ppk key to OpenSSH format
#       'ghc',
#       'haskell-platform'
    ]:
  }

  ## packages
  #
  package {
   'ClamXav':
      source   => "http://www.clamxav.com/downloads/ClamXav_2.6.1.dmg",
      provider => appdmg;
  }

  package { 
    'GoogleJapaneseInput':                                                           
      source => "http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg",
      provider => pkgdmg;                                                          
  }

  package { 
    'TotalTerminal':                                                           
      source => "http://downloads.binaryage.com/TotalTerminal-1.4.6.dmg",
      provider => pkgdmg;                                                          
  }

  ## dotfile setting
  #
  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/dotfiles"

}
