class minecraft::source {
  $jar_name = 'minecraft_server'

  case $minecraft::framework {
    'vanilla': {
      $download = "https://s3.amazonaws.com/Minecraft.Download/versions/${minecraft::version}/minecraft_server.${minecraft::version}.jar"
    }
    'spigot': {
      $download = "https://download.getbukkit.org/spigot/spigot-${minecraft::version}.jar"
    }
    'craftbukkit': {
      $download = "https://download.getbukkit.org/craftbukkit/craftbukkit-${minecraft::version}.jar"
    }
  }

  archive { 'minecraft_server':
    ensure  => 'present',
    source  => $download,
    path    => "${minecraft::install_dir}/minecraft_server.jar",
    require => [User[$minecraft::user],File[$minecraft::install_dir]],
    user    => $minecraft::user,
  }

  file { "${minecraft::install_dir}/minecraft_server.jar":
    ensure  => 'file',
    owner   => $minecraft::user,
    group   => $minecraft::group,
    mode    => '0644',
    require => [User[$minecraft::user],
      Group[$minecraft::group],
      Archive['minecraft_server'],
    ],
  }

  file { "${minecraft::install_dir}/eula.txt":
    ensure  => file,
    owner   => $minecraft::user,
    group   => $minecraft::group,
    content => template('minecraft/eula.txt.erb'),
  }
}
