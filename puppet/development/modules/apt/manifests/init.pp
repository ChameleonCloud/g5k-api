class apt {
  Package {
    require => Exec["sources update"]
  }

  exec { "sources update":
      command => "apt-get -o Acquire::Check-Valid-Until=false update",
      path => "/usr/bin:/usr/sbin:/bin",
      #refreshonly => true;
  }
  
}

class apt::allownotvalid inherits apt {

  file { "Apt allow not valid":
      path => "/etc/apt/apt.conf.d/allow-not-valid",
      ensure => file,
      mode => 644, owner => root, group => root,
      content => "Acquire::Check-Valid-Until \"0\";\n";
  }

}

class apt::allowunauthenticated inherits apt {

  file { "Apt allow unauthenticated":
      path => "/etc/apt/apt.conf.d/allow-unauthenticated",
      ensure => file,
      mode => 644, owner => root, group => root,
      content => "APT::Get::AllowUnauthenticated \"true\";\n";
  }
}
