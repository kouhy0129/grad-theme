#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib ("/home/nanzan/teba-1.11/TEBA","$Bin/../Extension");

use CommonModel;

my @tk = <>;
print CommonModel->new()->set_teba(\@tk)->rewrite();
