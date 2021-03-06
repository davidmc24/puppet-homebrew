class homebrew::install( $prefix, $group_accessible ) {
  $directories = [ $prefix,
                   "${prefix}/bin",
                   "${prefix}/etc",
                   "${prefix}/include",
                   "${prefix}/lib",
                   "${prefix}/lib/pkgconfig",
                   "${prefix}/Library",
                   "${prefix}/sbin",
                   "${prefix}/share",
                   "${prefix}/var",
                   "${prefix}/var/log",
                   "${prefix}/share/locale",
                   "${prefix}/share/man",
                   "${prefix}/share/man/man1",
                   "${prefix}/share/man/man2",
                   "${prefix}/share/man/man3",
                   "${prefix}/share/man/man4",
                   "${prefix}/share/man/man5",
                   "${prefix}/share/man/man6",
                   "${prefix}/share/man/man7",
                   "${prefix}/share/man/man8",
                   "${prefix}/share/info",
                   "${prefix}/share/doc",
                   "${prefix}/share/aclocal" ]

  file { $directories:
    ensure   => directory,
    owner    => $homebrew::user,
    group    => 'admin',
    mode     => $group_accessible ? {
      true  => 0775,
      false => 0755,
    },
  }

  exec { 'install-homebrew':
    cwd       => $prefix,
    user      => $homebrew::user,
    command   => "/usr/bin/curl -skSfL https://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1",
    creates   => "${prefix}/bin/brew",
    logoutput => on_failure,
    timeout   => 0,
    require   => File[$directories],
  }

  file { "${prefix}/bin/brew":
    owner     => $homebrew::user,
    group     => 'admin',
    mode      => $group_accessible ? {
      true  => 0775,
      false => 0755,
    },
    require   => Exec['install-homebrew'],
  }
}
