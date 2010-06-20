package Mars::Schema::Result::Source;
use strict;
use warnings;

use parent qw( DBIx::Class );
use utf8;

__PACKAGE__->load_components qw/ TimeStamp Core /;

__PACKAGE__->table( 'source' );
__PACKAGE__->add_columns(
    id => { 
        data_type         => 'int', 
        is_nullable       => 0, 
        is_auto_increment => 1 
    },
    title => {   
        data_type     => 'varchar',
        is_nullable   => 0,
        size          => 255
    },
    description => {
        data_type   => 'text',
        is_nullable => 1
    },
    url => {   
        data_type     => 'varchar',
        is_nullable   => 0,
        size          => 255
    },
    url_feed => {   
        data_type     => 'varchar',
        is_nullable   => 0,
        size          => 255
    },
    created => { data_type => 'datetime', set_on_create => 1 },
    updated => { data_type => 'datetime', set_on_create => 1, set_on_update => 1 },
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->has_many( 'posts', 'Mars::Schema::Result::Post', { 'foreign.id_source' => 'self.id' } );

1;
