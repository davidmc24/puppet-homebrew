class homebrew(
  $command_line_tools_package = $homebrew::params::command_line_tools_package,
  $command_line_tools_source  = $homebrew::params::command_line_tools_source,
  $user                       = $homebrew::params::user,
  $prefix                     = $homebrew::params::prefix,
  $group_accessible           = $homebrew::params::group_accessible,
) inherits homebrew::params {
  include homebrew::compiler
  class { 'homebrew::install':
    prefix           => $prefix,
    group_accessible => $group_accessible,
  }
}
