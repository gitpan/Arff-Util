package Arff::Util;

use warnings;
use strict;

use Carp qw(cluck);

use Data::Dumper;
use Devel::Size qw(size total_size);
use String::Util ':all';

=head1 NAME

Arff::Util - ARFF files processing utilities.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Quick summary of what the module does.

  use ARFF::Util;
  
  # load .arff formatted file into the buffer, and return pointer to buffer
  $arff_hash = load_arff($file_address);
  
  # save given buffer into the .arff formatted file
  save_arff($arff_hash, $file_address);

=head1 DESCRIPTION

ARFF::Util provides a collection of methods for processing ARFF formatted files.
"An ARFF (Attribute-Relation File Format) file is an ASCII text file that describes a list of instances sharing a set of attributes."
for more information about ARFF format visit http://weka.sourceforge.net/wekadoc/index.php/en:ARFF_%283.5.1%29

=head1 EXPORT



=head1 FUNCTIONS

=head2 load_arff

Get arff file path and load it in buffer

=cut

sub load_from_file {
	my ($arff_file) = @_;
	local *FILE;
	open(FILE, $arff_file);
	my $status = q/normal/;
 	log_msg("Loading $arff_file ...");
	my $record_count = 0;
	my $attribute_count = 0;
	my $line_counter = 1;

	while (my $current_line = <FILE>)
	{
		$current_line = trim($current_line);
		#Check for comments
		if ($current_line =~ /^\s*%/i)
		{
			$status = q/comment/;
		}
		elsif ($current_line =~ /^\s*\@RELATION\s+(\S*)/i )
		{
			$relation -> {"relation_name"} = $1;
		}
		elsif ($current_line =~ /^\s*\@ATTRIBUTE\s+(\S*)\s+(\S*)/i )
		{
			if(!$relation -> {"attributes"}){
				$relation -> {"attributes"} = [];
			}
			my $attribute = { "attribute_name" => $1, "attribute_type" => $2};
			my $attributes = $relation -> {"attributes"};
 			#log_msg(Dumper $attribute);

			push  @$attributes , $attribute;
			$attribute_count ++;
		}
		elsif ($current_line =~ /^\s*\@DATA(\.*)/i )
		{
			$status = q/data/;
		}
		elsif($status == q/data/ && $current_line != q//){
			if(!$relation -> {"records"}){
				$relation -> {"records"} = [];
			}
			#log_msg("extracting data $current_line");
			my @data_parts = split(/,/, $current_line);

			my $attributes = $relation -> {"attributes"};
 			my $records = $relation -> {"records"};

			my $cur_record={};

 			#log_msg("DATA PARTS".Dumper @data_parts);
			if(scalar @data_parts == $attribute_count){
				for(my $i=0;$i<=$#data_parts;$i++)
				{
					$cur_record->{$$attributes[$i]->{"attribute_name"}} = trim($data_parts[$i]);
				}
				#log_msg("parts: ".$#data_parts);
	
				$record_count ++;
				push  @$records , $cur_record;
			}else
			{
				throw_error("Line $line_counter : Invalid data record: $current_line Containts ".(scalar @data_parts)." Expected $attribute_count");
			}
			
		}
		$line_counter ++;
	}
	
	$relation -> {"data_record_count"} = $record_count;
 	$relation -> {"attribute_count"} = $attribute_count;
 	#log_msg(Dumper $relation);
	log_msg("$arff_file loaded with $error_count error(s).");
	log_msg("Buffer size: ".get_buffer_size()."bytes");
	return 1;
}

=head2 save_arff

Save given buffer into the .arff formatted file. This method is not implemented yet.

=cut

sub save_arff {
	my ($buffer,$file_name) = @_;
	
	throw_error("Not implemented yet!");
	
	return 1;
}

=head1 AUTHOR

Ehsan Emadzadeh, C<< <ehsan0emadzadeh at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-arff-util at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Arff-Util>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Arff::Util


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Arff-Util>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Arff-Util>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Arff-Util>

=item * Search CPAN

L<http://search.cpan.org/dist/Arff-Util/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Ehsan Emadzadeh, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Arff::Util
