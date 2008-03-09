package Bot::AlterEgo;

use strict;
use warnings;
use utf8;
use Config::Any;
use Net::XMPP2::IM::Connection;

#############################
# Constructor and bot startup

sub new {
  my ($class) = @_;
  
  my $cfg = $class->_load_config;
  
  # Default values
  $cfg->{connection}{resource} ||= 'AlterEgo';
  $cfg->{connection}{initial_presence} = undef; # Disable automatic initial presence

  # ...
}


#######
# Utils

sub _load_config {
  my ($class) = @_;
  
  my $found = Config::Any->load_stems({
    stems   => [ ".alter_ego_cfg", "$ENV{HOME}/.alter_ego_cfg" ],
    use_ext => 1,
  });
  die "Config file not found, " unless @$found;
  
  # right now we use only the first one, we could use all of them and
  # merge the configs in a future version
  my ($file, $config) = %{$found->[0]};
  
  return $config;
}

1;
