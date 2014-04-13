# -*- perl -*-

use strict;
use warnings;
use FindBin '$Bin';
use lib "$Bin/lib";

use Test::More;
use Test::Exception;

use aliased 'DBIx::Class::Schema::Diff::SchemaData';

my $target_data = &_sakila_data_target;

ok(
  my $SD1 =  SchemaData->new( schema => 'TestSchema::Sakila' ),
  "Initialize stand-alone SchemaData object using class name"
);

is_deeply( 
  $SD1->data => $target_data,
  "Saw expected Sakila schema data (1)"
);

ok(
  my $SD2 = SchemaData->new( data => $target_data ),
  "Initialize stand-alone SchemaData object using data"
);

is_deeply( 
  $SD2->data => $target_data,
  "Saw expected Sakila schema data (2)"
);

is_deeply( 
  $SD2->data => $SD1->data,
  "Saw expected Sakila schema data (3)"
);


done_testing;


# This is in a sub at the end just to prevent scrolling since its so long:
sub _sakila_data_target {{
  schema_class => "TestSchema::Sakila",
  sources => {
    Actor => {
      columns => {
        actor_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        first_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "actor_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Actor",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        film_actors => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::FilmActor",
          cond => {
            "foreign.actor_id" => "self.actor_id"
          },
          source => "TestSchema::Sakila::Result::FilmActor"
        }
      },
      table_name => "actor"
    },
    ActorInfo => {
      columns => {
        actor_id => {
          data_type => "smallint",
          default_value => 0,
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        film_info => {
          data_type => "varchar",
          is_nullable => 1,
          size => 341
        },
        first_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::ActorInfo",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "actor_info"
    },
    Address => {
      columns => {
        address => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        address2 => {
          data_type => "varchar",
          is_nullable => 1,
          size => 50
        },
        address_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        city_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        district => {
          data_type => "varchar",
          is_nullable => 0,
          size => 20
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        phone => {
          data_type => "varchar",
          is_nullable => 0,
          size => 20
        },
        postal_code => {
          data_type => "varchar",
          is_nullable => 1,
          size => 10
        }
      },
      constraints => {
        primary => {
          columns => [
            "address_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Address",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        city => {
          attrs => {
            accessor => "single",
            fk_columns => {
              city_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::City",
          cond => {
            "foreign.city_id" => "self.city_id"
          },
          source => "TestSchema::Sakila::Result::City"
        },
        customers => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Customer",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Customer"
        },
        staffs => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Staff",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Staff"
        },
        stores => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Store",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Store"
        }
      },
      table_name => "address"
    },
    Category => {
      columns => {
        category_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 25
        }
      },
      constraints => {
        primary => {
          columns => [
            "category_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Category",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        film_categories => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::FilmCategory",
          cond => {
            "foreign.category_id" => "self.category_id"
          },
          source => "TestSchema::Sakila::Result::FilmCategory"
        }
      },
      table_name => "category"
    },
    City => {
      columns => {
        city => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        city_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        country_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "city_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::City",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        addresses => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Address",
          cond => {
            "foreign.city_id" => "self.city_id"
          },
          source => "TestSchema::Sakila::Result::Address"
        },
        country => {
          attrs => {
            accessor => "single",
            fk_columns => {
              country_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Country",
          cond => {
            "foreign.country_id" => "self.country_id"
          },
          source => "TestSchema::Sakila::Result::Country"
        }
      },
      table_name => "city"
    },
    Country => {
      columns => {
        country => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        country_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "country_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Country",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        cities => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::City",
          cond => {
            "foreign.country_id" => "self.country_id"
          },
          source => "TestSchema::Sakila::Result::City"
        }
      },
      table_name => "country"
    },
    Customer => {
      columns => {
        active => {
          data_type => "tinyint",
          default_value => 1,
          is_nullable => 0
        },
        address_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        create_date => {
          _ic_dt_method => "datetime",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "datetime",
          datetime_undef_if_invalid => 1,
          is_nullable => 0
        },
        customer_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        email => {
          data_type => "varchar",
          is_nullable => 1,
          size => 50
        },
        first_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        store_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "customer_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Customer",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        address => {
          attrs => {
            accessor => "single",
            fk_columns => {
              address_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Address",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Address"
        },
        payments => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Payment",
          cond => {
            "foreign.customer_id" => "self.customer_id"
          },
          source => "TestSchema::Sakila::Result::Payment"
        },
        rentals => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Rental",
          cond => {
            "foreign.customer_id" => "self.customer_id"
          },
          source => "TestSchema::Sakila::Result::Rental"
        },
        store => {
          attrs => {
            accessor => "single",
            fk_columns => {
              store_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Store",
          cond => {
            "foreign.store_id" => "self.store_id"
          },
          source => "TestSchema::Sakila::Result::Store"
        }
      },
      table_name => "customer"
    },
    CustomerList => {
      columns => {
        address => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        city => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        country => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        id => {
          data_type => "smallint",
          default_value => 0,
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        name => {
          data_type => "varchar",
          default_value => "",
          is_nullable => 0,
          size => 91
        },
        notes => {
          data_type => "varchar",
          default_value => "",
          is_nullable => 0,
          size => 6
        },
        phone => {
          data_type => "varchar",
          is_nullable => 0,
          size => 20
        },
        sid => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        "zip code" => {
          accessor => "zip_code",
          data_type => "varchar",
          is_nullable => 1,
          size => 10
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::CustomerList",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "customer_list"
    },
    Film => {
      columns => {
        description => {
          data_type => "text",
          is_nullable => 1
        },
        film_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        language_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        length => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_nullable => 1
        },
        original_language_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 1
        },
        rating => {
          data_type => "enum",
          default_value => "G",
          extra => {
            list => [
              "G",
              "PG",
              "PG-13",
              "R",
              "NC-17"
            ]
          },
          is_nullable => 1
        },
        release_year => {
          data_type => "year",
          is_nullable => 1
        },
        rental_duration => {
          data_type => "tinyint",
          default_value => 3,
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        rental_rate => {
          data_type => "decimal",
          default_value => "4.99",
          is_nullable => 0,
          size => [
            4,
            2
          ]
        },
        replacement_cost => {
          data_type => "decimal",
          default_value => "19.99",
          is_nullable => 0,
          size => [
            5,
            2
          ]
        },
        special_features => {
          data_type => "set",
          extra => {
            list => [
              "Trailers",
              "Commentaries",
              "Deleted Scenes",
              "Behind the Scenes"
            ]
          },
          is_nullable => 1
        },
        title => {
          data_type => "varchar",
          is_nullable => 0,
          size => 255
        }
      },
      constraints => {
        primary => {
          columns => [
            "film_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Film",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        film_actors => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::FilmActor",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::FilmActor"
        },
        film_categories => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::FilmCategory",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::FilmCategory"
        },
        inventories => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Inventory",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::Inventory"
        },
        language => {
          attrs => {
            accessor => "single",
            fk_columns => {
              language_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Language",
          cond => {
            "foreign.language_id" => "self.language_id"
          },
          source => "TestSchema::Sakila::Result::Language"
        },
        original_language => {
          attrs => {
            accessor => "single",
            fk_columns => {
              original_language_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            join_type => "LEFT",
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Language",
          cond => {
            "foreign.language_id" => "self.original_language_id"
          },
          source => "TestSchema::Sakila::Result::Language"
        }
      },
      table_name => "film"
    },
    FilmActor => {
      columns => {
        actor_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        film_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "actor_id",
            "film_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::FilmActor",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        actor => {
          attrs => {
            accessor => "single",
            fk_columns => {
              actor_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Actor",
          cond => {
            "foreign.actor_id" => "self.actor_id"
          },
          source => "TestSchema::Sakila::Result::Actor"
        },
        film => {
          attrs => {
            accessor => "single",
            fk_columns => {
              film_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Film",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::Film"
        }
      },
      table_name => "film_actor"
    },
    FilmCategory => {
      columns => {
        category_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        film_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "film_id",
            "category_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::FilmCategory",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        category => {
          attrs => {
            accessor => "single",
            fk_columns => {
              category_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Category",
          cond => {
            "foreign.category_id" => "self.category_id"
          },
          source => "TestSchema::Sakila::Result::Category"
        },
        film => {
          attrs => {
            accessor => "single",
            fk_columns => {
              film_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Film",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::Film"
        }
      },
      table_name => "film_category"
    },
    FilmList => {
      columns => {
        actors => {
          data_type => "varchar",
          is_nullable => 1,
          size => 341
        },
        category => {
          data_type => "varchar",
          is_nullable => 0,
          size => 25
        },
        description => {
          data_type => "text",
          is_nullable => 1
        },
        fid => {
          data_type => "smallint",
          default_value => 0,
          extra => {
            unsigned => 1
          },
          is_nullable => 1
        },
        length => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_nullable => 1
        },
        price => {
          data_type => "decimal",
          default_value => "4.99",
          is_nullable => 1,
          size => [
            4,
            2
          ]
        },
        rating => {
          data_type => "enum",
          default_value => "G",
          extra => {
            list => [
              "G",
              "PG",
              "PG-13",
              "R",
              "NC-17"
            ]
          },
          is_nullable => 1
        },
        title => {
          data_type => "varchar",
          is_nullable => 1,
          size => 255
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::FilmList",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "film_list"
    },
    FilmText => {
      columns => {
        description => {
          data_type => "text",
          is_nullable => 1
        },
        film_id => {
          data_type => "smallint",
          is_nullable => 0
        },
        title => {
          data_type => "varchar",
          is_nullable => 0,
          size => 255
        }
      },
      constraints => {
        primary => {
          columns => [
            "film_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::FilmText",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "film_text"
    },
    Inventory => {
      columns => {
        film_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        inventory_id => {
          data_type => "mediumint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        store_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "inventory_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Inventory",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        film => {
          attrs => {
            accessor => "single",
            fk_columns => {
              film_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Film",
          cond => {
            "foreign.film_id" => "self.film_id"
          },
          source => "TestSchema::Sakila::Result::Film"
        },
        rentals => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Rental",
          cond => {
            "foreign.inventory_id" => "self.inventory_id"
          },
          source => "TestSchema::Sakila::Result::Rental"
        },
        store => {
          attrs => {
            accessor => "single",
            fk_columns => {
              store_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Store",
          cond => {
            "foreign.store_id" => "self.store_id"
          },
          source => "TestSchema::Sakila::Result::Store"
        }
      },
      table_name => "inventory"
    },
    Language => {
      columns => {
        language_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        name => {
          data_type => "char",
          is_nullable => 0,
          size => 20
        }
      },
      constraints => {
        primary => {
          columns => [
            "language_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Language",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        film_languages => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Film",
          cond => {
            "foreign.language_id" => "self.language_id"
          },
          source => "TestSchema::Sakila::Result::Film"
        },
        film_original_languages => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Film",
          cond => {
            "foreign.original_language_id" => "self.language_id"
          },
          source => "TestSchema::Sakila::Result::Film"
        }
      },
      table_name => "language"
    },
    NicerButSlowerFilmList => {
      columns => {
        actors => {
          data_type => "varchar",
          is_nullable => 1,
          size => 341
        },
        category => {
          data_type => "varchar",
          is_nullable => 0,
          size => 25
        },
        description => {
          data_type => "text",
          is_nullable => 1
        },
        fid => {
          data_type => "smallint",
          default_value => 0,
          extra => {
            unsigned => 1
          },
          is_nullable => 1
        },
        length => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_nullable => 1
        },
        price => {
          data_type => "decimal",
          default_value => "4.99",
          is_nullable => 1,
          size => [
            4,
            2
          ]
        },
        rating => {
          data_type => "enum",
          default_value => "G",
          extra => {
            list => [
              "G",
              "PG",
              "PG-13",
              "R",
              "NC-17"
            ]
          },
          is_nullable => 1
        },
        title => {
          data_type => "varchar",
          is_nullable => 1,
          size => 255
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::NicerButSlowerFilmList",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "nicer_but_slower_film_list"
    },
    Payment => {
      columns => {
        amount => {
          data_type => "decimal",
          is_nullable => 0,
          size => [
            5,
            2
          ]
        },
        customer_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        payment_date => {
          _ic_dt_method => "datetime",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "datetime",
          datetime_undef_if_invalid => 1,
          is_nullable => 0
        },
        payment_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        rental_id => {
          data_type => "integer",
          is_foreign_key => 1,
          is_nullable => 1
        },
        staff_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "payment_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Payment",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        customer => {
          attrs => {
            accessor => "single",
            fk_columns => {
              customer_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Customer",
          cond => {
            "foreign.customer_id" => "self.customer_id"
          },
          source => "TestSchema::Sakila::Result::Customer"
        },
        rental => {
          attrs => {
            accessor => "single",
            fk_columns => {
              rental_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            join_type => "LEFT",
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Rental",
          cond => {
            "foreign.rental_id" => "self.rental_id"
          },
          source => "TestSchema::Sakila::Result::Rental"
        },
        staff => {
          attrs => {
            accessor => "single",
            fk_columns => {
              staff_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Staff",
          cond => {
            "foreign.staff_id" => "self.staff_id"
          },
          source => "TestSchema::Sakila::Result::Staff"
        }
      },
      table_name => "payment"
    },
    Rental => {
      columns => {
        customer_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        inventory_id => {
          data_type => "mediumint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        rental_date => {
          _ic_dt_method => "datetime",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "datetime",
          datetime_undef_if_invalid => 1,
          is_nullable => 0
        },
        rental_id => {
          data_type => "integer",
          is_auto_increment => 1,
          is_nullable => 0
        },
        return_date => {
          _ic_dt_method => "datetime",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "datetime",
          datetime_undef_if_invalid => 1,
          is_nullable => 1
        },
        staff_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        }
      },
      constraints => {
        primary => {
          columns => [
            "rental_id"
          ]
        },
        rental_date => {
          columns => [
            "rental_date",
            "inventory_id",
            "customer_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Rental",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        customer => {
          attrs => {
            accessor => "single",
            fk_columns => {
              customer_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Customer",
          cond => {
            "foreign.customer_id" => "self.customer_id"
          },
          source => "TestSchema::Sakila::Result::Customer"
        },
        inventory => {
          attrs => {
            accessor => "single",
            fk_columns => {
              inventory_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Inventory",
          cond => {
            "foreign.inventory_id" => "self.inventory_id"
          },
          source => "TestSchema::Sakila::Result::Inventory"
        },
        payments => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Payment",
          cond => {
            "foreign.rental_id" => "self.rental_id"
          },
          source => "TestSchema::Sakila::Result::Payment"
        },
        staff => {
          attrs => {
            accessor => "single",
            fk_columns => {
              staff_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Staff",
          cond => {
            "foreign.staff_id" => "self.staff_id"
          },
          source => "TestSchema::Sakila::Result::Staff"
        }
      },
      table_name => "rental"
    },
    SaleByFilmCategory => {
      columns => {
        category => {
          data_type => "varchar",
          is_nullable => 0,
          size => 25
        },
        total_sales => {
          data_type => "decimal",
          is_nullable => 1,
          size => [
            27,
            2
          ]
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::SaleByFilmCategory",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "sales_by_film_category"
    },
    SaleByStore => {
      columns => {
        manager => {
          data_type => "varchar",
          default_value => "",
          is_nullable => 0,
          size => 91
        },
        store => {
          data_type => "varchar",
          default_value => "",
          is_nullable => 0,
          size => 101
        },
        total_sales => {
          data_type => "decimal",
          is_nullable => 1,
          size => [
            27,
            2
          ]
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::SaleByStore",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "sales_by_store"
    },
    Staff => {
      columns => {
        active => {
          data_type => "tinyint",
          default_value => 1,
          is_nullable => 0
        },
        address_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        email => {
          data_type => "varchar",
          is_nullable => 1,
          size => 50
        },
        first_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_name => {
          data_type => "varchar",
          is_nullable => 0,
          size => 45
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        password => {
          data_type => "varchar",
          is_nullable => 1,
          size => 40
        },
        picture => {
          data_type => "blob",
          is_nullable => 1
        },
        staff_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        },
        store_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        username => {
          data_type => "varchar",
          is_nullable => 0,
          size => 16
        }
      },
      constraints => {
        primary => {
          columns => [
            "staff_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Staff",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        address => {
          attrs => {
            accessor => "single",
            fk_columns => {
              address_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Address",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Address"
        },
        payments => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Payment",
          cond => {
            "foreign.staff_id" => "self.staff_id"
          },
          source => "TestSchema::Sakila::Result::Payment"
        },
        rentals => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Rental",
          cond => {
            "foreign.staff_id" => "self.staff_id"
          },
          source => "TestSchema::Sakila::Result::Rental"
        },
        store => {
          attrs => {
            accessor => "single",
            cascade_copy => 0,
            cascade_delete => 0,
            cascade_update => 1,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Store",
          cond => {
            "foreign.manager_staff_id" => "self.staff_id"
          },
          source => "TestSchema::Sakila::Result::Store"
        }
      },
      table_name => "staff"
    },
    StaffList => {
      columns => {
        address => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        city => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        country => {
          data_type => "varchar",
          is_nullable => 0,
          size => 50
        },
        id => {
          data_type => "tinyint",
          default_value => 0,
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        name => {
          data_type => "varchar",
          default_value => "",
          is_nullable => 0,
          size => 91
        },
        phone => {
          data_type => "varchar",
          is_nullable => 0,
          size => 20
        },
        sid => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_nullable => 0
        },
        "zip code" => {
          accessor => "zip_code",
          data_type => "varchar",
          is_nullable => 1,
          size => 10
        }
      },
      constraints => {},
      isa => [
        "TestSchema::Sakila::Result::StaffList",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {},
      table_name => "staff_list"
    },
    Store => {
      columns => {
        address_id => {
          data_type => "smallint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        last_update => {
          _ic_dt_method => "timestamp",
          _inflate_info => {
            deflate => "sub { \"DUMMY\" }",
            inflate => "sub { \"DUMMY\" }"
          },
          data_type => "timestamp",
          datetime_undef_if_invalid => 1,
          default_value => "\\\"current_timestamp\"",
          is_nullable => 0
        },
        manager_staff_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_foreign_key => 1,
          is_nullable => 0
        },
        store_id => {
          data_type => "tinyint",
          extra => {
            unsigned => 1
          },
          is_auto_increment => 1,
          is_nullable => 0
        }
      },
      constraints => {
        idx_unique_manager => {
          columns => [
            "manager_staff_id"
          ]
        },
        primary => {
          columns => [
            "store_id"
          ]
        }
      },
      isa => [
        "TestSchema::Sakila::Result::Store",
        "DBIx::Class::InflateColumn::DateTime",
        "DBIx::Class::Core",
        "DBIx::Class::Relationship",
        "DBIx::Class::Relationship::Helpers",
        "DBIx::Class::Relationship::HasMany",
        "DBIx::Class::Relationship::HasOne",
        "DBIx::Class::Relationship::BelongsTo",
        "DBIx::Class::Relationship::ManyToMany",
        "DBIx::Class::Relationship::Accessor",
        "DBIx::Class::Relationship::CascadeActions",
        "DBIx::Class::Relationship::ProxyMethods",
        "DBIx::Class::Relationship::Base",
        "DBIx::Class::InflateColumn",
        "DBIx::Class::PK::Auto",
        "DBIx::Class::PK",
        "DBIx::Class::Row",
        "DBIx::Class::ResultSourceProxy::Table",
        "DBIx::Class::ResultSourceProxy",
        "DBIx::Class",
        "DBIx::Class::Componentised",
        "Class::C3::Componentised",
        "DBIx::Class::AccessorGroup",
        "Class::Accessor::Grouped"
      ],
      relationships => {
        address => {
          attrs => {
            accessor => "single",
            fk_columns => {
              address_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Address",
          cond => {
            "foreign.address_id" => "self.address_id"
          },
          source => "TestSchema::Sakila::Result::Address"
        },
        customers => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Customer",
          cond => {
            "foreign.store_id" => "self.store_id"
          },
          source => "TestSchema::Sakila::Result::Customer"
        },
        inventories => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Inventory",
          cond => {
            "foreign.store_id" => "self.store_id"
          },
          source => "TestSchema::Sakila::Result::Inventory"
        },
        manager_staff => {
          attrs => {
            accessor => "single",
            fk_columns => {
              manager_staff_id => 1
            },
            is_deferrable => 1,
            is_foreign_key_constraint => 1,
            on_delete => "CASCADE",
            on_update => "CASCADE",
            undef_on_null_fk => 1
          },
          class => "TestSchema::Sakila::Result::Staff",
          cond => {
            "foreign.staff_id" => "self.manager_staff_id"
          },
          source => "TestSchema::Sakila::Result::Staff"
        },
        staffs => {
          attrs => {
            accessor => "multi",
            cascade_copy => 0,
            cascade_delete => 0,
            join_type => "LEFT"
          },
          class => "TestSchema::Sakila::Result::Staff",
          cond => {
            "foreign.store_id" => "self.store_id"
          },
          source => "TestSchema::Sakila::Result::Staff"
        }
      },
      table_name => "store"
    }
  }
}}



# -- for debugging:
#
#use Data::Dumper::Concise;
#sub Dumper { DumperObject->Deparse(0)->Values([ @_ ])->Dump }
#print STDERR "\n\n" . Dumper(
#  $SD1->data
#) . "\n\n";