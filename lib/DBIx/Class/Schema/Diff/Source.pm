package DBIx::Class::Schema::Diff::Source;
use strict;
use warnings;

use Moo;
use MooX::Types::MooseLike::Base 0.25 qw(:all);
use Try::Tiny;

use DBIx::Class::Schema::Diff::InfoPacket;

has 'old_source', required => 1, is => 'ro', isa => Maybe[InstanceOf[
  'DBIx::Class::ResultSource'
]];

has 'new_source', required => 1, is => 'ro', isa => Maybe[InstanceOf[
  'DBIx::Class::ResultSource'
]];

has 'schema_diff', required => 1, is => 'ro', isa => InstanceOf[
  'DBIx::Class::Schema::Diff'
];

has 'old_class', is => 'ro', lazy => 1, default => sub {
  my $self = shift;
  return undef unless ($self->old_source);
  $self->old_source->schema->class( $self->old_source->source_name );
}, init_arg => undef, isa => Maybe[Str];

has 'new_class', is => 'ro', lazy => 1, default => sub {
  my $self = shift;
  return undef unless ($self->new_source);
  $self->new_source->schema->class( $self->new_source->source_name );
}, init_arg => undef, isa => Maybe[Str];

has 'name', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  # TODO: handle new_source/old_source with different names
  # (shouldn't need to worry about it currently)
  $self->new_source ? 
    $self->new_source->source_name : $self->old_source->source_name
}, init_arg => undef, isa => Str;


has 'added', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  defined $self->new_source && ! defined $self->old_source
}, init_arg => undef, isa => Bool;

has 'deleted', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  defined $self->old_source && ! defined $self->new_source
}, init_arg => undef, isa => Bool;


has 'columns', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  
  my ($o,$n) = ($self->old_source,$self->new_source);
  
  # List of all columns in old, new, or both:
  my %seen = ();
  my @columns = grep {!$seen{$_}++} (try{$o->columns}, try{$n->columns});
  
  return {
    map { $_ => DBIx::Class::Schema::Diff::InfoPacket->new(
      name        => $_,
      old_info    => $o && $o->has_column($_) ? $o->column_info($_) : undef,
      new_info    => $n && $n->has_column($_) ? $n->column_info($_) : undef,
      source_diff => $self
    ) } @columns 
  };

}, init_arg => undef, isa => HashRef;


has 'relationships', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  
  my ($o,$n) = ($self->old_source,$self->new_source);
  
  # List of all relationships in old, new, or both:
  my %seen = ();
  my @rels = grep {!$seen{$_}++} (try{$o->relationships},try{$n->relationships});
  
  return {
    map { $_ => DBIx::Class::Schema::Diff::InfoPacket->new(
      name        => $_,
      old_info    => $o && $o->has_relationship($_) ? $o->relationship_info($_) : undef,
      new_info    => $n && $n->has_relationship($_) ? $n->relationship_info($_) : undef,
      source_diff => $self
    ) } @rels
  };
  
}, init_arg => undef, isa => HashRef;


has 'unique_constraints', is => 'ro', lazy => 1, default => sub { 
  my $self = shift;
  
  my ($o,$n) = ($self->old_source,$self->new_source);
  
  # List of all unique_constraint_names in old, new, or both:
  my %seen = ();
  my @consts = grep {!$seen{$_}++} (
    try{$o->unique_constraint_names},
    try{$n->unique_constraint_names}
  );
  
  return {
    map { 
      my @o_uc_cols = try{$o->unique_constraint_columns($_)};
      my @n_uc_cols = try{$n->unique_constraint_columns($_)};
      $_ => DBIx::Class::Schema::Diff::InfoPacket->new(
        name        => $_,
        old_info    => scalar(@o_uc_cols) > 0 ? { columns => \@o_uc_cols } : undef,
        new_info    => scalar(@n_uc_cols) > 0 ? { columns => \@n_uc_cols } : undef,
        source_diff => $self
      ) 
    } @consts
  };
  
}, init_arg => undef, isa => HashRef;


has 'isa_diff', is => 'ro', lazy => 1, default => sub {
  my $self = shift;

  my ($o,$n) = ($self->old_class,$self->new_class);
  my $o_isa = $o ? mro::get_linear_isa($o) : [];
  my $n_isa = $n ? mro::get_linear_isa($n) : [];

  # Normalize namespaces which match the old/new schema class
  my $o_class = $self->schema_diff->old_schemaclass;
  my $n_class = $self->schema_diff->new_schemaclass;
  $_ =~ s/^${n_class}/\*/ for (@$n_isa);
  $_ =~ s/^${o_class}/\*/ for (@$o_isa);

  my $AD = Array::Diff->diff($o_isa,$n_isa);
  my $diff = [
    (map {'-'.$_} @{$AD->deleted}),
    (map {'+'.$_} @{$AD->added})
  ];

  return scalar(@$diff) > 0 ? $diff : undef;

}, init_arg => undef, isa => Maybe[ArrayRef];



has 'diff', is => 'ro', lazy => 1, default => sub {
  my $self = shift;
  
  # There is no reason to diff in the case of added/deleted:
  return { _event => 'added'   } if ($self->added);
  return { _event => 'deleted' } if ($self->deleted);
  
  my $diff = {};
  
  $diff->{columns} = { map {
    $_->diff ? ($_->name => $_->diff) : ()
  } values %{$self->columns} };
  delete $diff->{columns} unless (keys %{$diff->{columns}} > 0);
  
  $diff->{relationships} = { map {
    $_->diff ? ($_->name => $_->diff) : ()
  } values %{$self->relationships} };
  delete $diff->{relationships} unless (keys %{$diff->{relationships}} > 0);
  
  $diff->{unique_constraints} = { map {
    $_->diff ? ($_->name => $_->diff) : ()
  } values %{$self->unique_constraints} };
  delete $diff->{unique_constraints} unless (keys %{$diff->{unique_constraints}} > 0);
  
  my $o_tbl = try{$self->old_source->from};
  my $n_tbl = try{$self->new_source->from};
  $diff->{table_name} = $n_tbl unless ($self->_is_eq($o_tbl,$n_tbl));
  
  $diff->{isa} = $self->isa_diff if ($self->isa_diff);
  
  # TODO: other data points TDB 
  # ...
  
  # Remove items specified in ignore:
  $self->_is_ignore($_) and delete $diff->{$_} for (keys %$diff);
  
  # No changes:
  return undef unless (keys %$diff > 0);
  
  $diff->{_event} = 'changed';
  return $diff;
  
}, init_arg => undef, isa => Maybe[HashRef];

sub _info_diff { (shift)->schema_diff->_info_diff(@_) }
sub _is_eq     { (shift)->schema_diff->_is_eq(@_) }
sub _is_ignore { (shift)->schema_diff->_is_ignore(@_) }



1;