# This puppet manifest is just here to configure a vanilla squeeze with the
# required libs and configuration to serve as a production host for the
# g5k-api software.
class production {
  include apt::allownotvalid
  include mysql
  include git
  include dpkg::dev

  exec{ "create production database":
    user => root, group => root,
    require => Exec["allow mysql connections from all"],
    command =>  "/usr/bin/mysql -e \"create database g5kapi_production CHARACTER SET utf8 COLLATE utf8_general_ci;\"",
    creates => "/var/lib/mysql/g5kapi_production"
  }
}

stage { "init": before  => Stage["main"] }

class {"apt":
  stage => init,
}

include production
