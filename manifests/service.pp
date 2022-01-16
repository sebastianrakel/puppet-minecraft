class minecraft::service {
  case $minecraft::service_provider {
    'rc': {
      file { 'minecraft_init':
        ensure  => file,
        path    => '/etc/init.d/minecraft',
        owner   => 'root',
        group   => 'root',
        mode    => '0744',
        content => template('minecraft/minecraft_init.erb'),
        notify  => Service['minecraft'],
      }  
    }
    'systemd': {
      systemd::unit_file { 'minecraft.service':
        content            => epp('minecraft/minecraft.service.epp', {
          username         => $minecraft::user,
          workingdirectory => $minecraft::install_dir,
          heap_min         => $minecraft::heap_start,
          heap_max         => $minecraft::heap_size,
        }),
        notify             => Service['minecraft'],
      }
    }
  }

  service { 'minecraft':
    ensure    => running,
    enable    => $minecraft::autostart,
  }
}
