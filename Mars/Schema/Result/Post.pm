package Mars::Schema::Result::Post;
use strict;
use warnings;

use parent qw( DBIx::Class );
use utf8;

__PACKAGE__->load_components qw/ InflateColumn::DateTime Core /;

__PACKAGE__->table( 'post' );
__PACKAGE__->add_columns(
    id => { 
        data_type         => 'varchar', 
        is_nullable       => 0, 
        size              => 27 
    },
    id_source => { 
        data_type         => 'int', 
        is_nullable       => 0, 
    },
    title => {   
        data_type     => 'varchar',
        is_nullable   => 0,
        size          => 255
    },
    summary => {
        data_type   => 'text',
        is_nullable => 1
    },
    body => {
        data_type   => 'text',
        is_nullable => 1
    },
    url => {   
        data_type     => 'varchar',
        is_nullable   => 0,
        size          => 255
    },
    author => {   
        data_type     => 'varchar',
        is_nullable   => 1,
        size          => 255
    },
    tags => {   
        data_type     => 'varchar',
        is_nullable   => 1,
        size          => 255
    },
    created => { data_type => 'datetime', is_nullable => 1 },
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->resultset_attributes({ order_by => [ 'created DESC' ] });

__PACKAGE__->belongs_to( 'source', 'Mars::Schema::Result::Source', { 'foreign.id' => 'self.id_source' });

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->add_index( name => 'source_idx', fields => [qw/ id_source created /] );
    $sqlt_table->add_index( name => 'create_idx', fields => [qw/ created /] );
}

1;
