use Mojolicious::Lite;
use DBIx::Custom;
use FindBin;
use lib "lib";
use Mojolicious::Plugin::DBViewer;

my $connector;
plugin(
  'DBViewer',
  dsn => 'dbi:SQLite:dbname=:memory:',
  connector_get => \$connector
);

my $dbi = DBIx::Custom->connect(connector => $connector);
eval {
  $dbi->execute('create table table1 (key1 integer primary key not null, key2 not null, key3)');
  $dbi->insert({key1 => $_, key2 => $_ + 1, key3 => $_ + 2}, table => 'table1') for (1 .. 2510);
};

get '/' => {text => 'a'};

app->start;

