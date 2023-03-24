Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E726C8285
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCXQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCXQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:39:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E01A669;
        Fri, 24 Mar 2023 09:39:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so10324663edo.2;
        Fri, 24 Mar 2023 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679675985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIAsfmm6m/Fp1PHQZYyQjBC+OwJPQOsa4jph1OwAmbQ=;
        b=MtUmN78rzvi8nEoPw2b1lS46b9fmg6ehXMMCeHnXFWCF9wUJvm4CmKLyLulHqbhGts
         LiGB/caa7HWye2wm5m5Z84j8WZIij5Y0AG2DHV2DIX7T9896Hhzfv/IcV+tSI2nQmB7R
         nReCEFq5ewX3EdMap3nlxER3aG77etNI66Euph97FGMM8NG4oC+sf3GxadMAozNIe2Fv
         SxSXdLCKgytZUuxNAOueKJhQnnk8OtO8Yih7MUOltMKDfAeRQl0dHKokEG3C7xMuOaok
         LoAwt7c1vt14cqaj+BmvegBjt6BeBqk7rLStb7I4AmuAVSWIyDNTJG5gx4tvnXGGfi0g
         8NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679675985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIAsfmm6m/Fp1PHQZYyQjBC+OwJPQOsa4jph1OwAmbQ=;
        b=pXN9HWXpJRkfTOEya88P/U5awufKK8ZuxuPcLCTzauBJWyA+IXVCrrSQTaxDOF0pv/
         aX3O9pg3SIgKZi7Zgt8k5pOhP8H2n1SEF3ALUogBnXnL9XYSM+X6G/1dpCu+66gt3PDx
         rw09SdcjuTtEfJzMSsEh1np9I5Tl8PntRaaqIJbax1NkE1Z1m2pjxep61Wg3/Npcqu6U
         5SMleFoEw/45QDJzVyMm6cijCBlGKhSNP7JqTIEMz4TL9tVnBxT0L0/DlmOJxIHFgEjY
         88S/Im9BRDZZnUeIFq4eTEjXXMTjbC6j1oPQI2Z4UZYsfjEQFu/115TjrJ5y2sZF6t4V
         99+w==
X-Gm-Message-State: AAQBX9cmeIDWn6K0nhWfsKOMHujYVxwgRWNqt+vblZTPoCzKn07TaLZC
        Y9kMOm5DzrFMshKmXnOeZ6q3GtCejxU12/Wg
X-Google-Smtp-Source: AKy350avxYv5rn72v71z0Nv7J1Ki1mKAA4ifHGmAC0TtuoulxFajx9akyfXYblEU8wmRE8ouwx3o6A==
X-Received: by 2002:a17:906:2547:b0:931:e5de:d28d with SMTP id j7-20020a170906254700b00931e5ded28dmr3246244ejb.33.1679675985577;
        Fri, 24 Mar 2023 09:39:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709061e0800b0093bd173baa6sm3860152ejj.202.2023.03.24.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:39:45 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:39:40 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Zhe <yuzhe@nfschina.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
Message-ID: <528343af-50be-45dd-b34f-c8bc641f984c@kili.mountain>
References: <20230317064729.24407-1-yuzhe@nfschina.com>
 <CGME20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5@eucas1p2.samsung.com>
 <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OjI+tStzI9uSbnvV"
Content-Disposition: inline
In-Reply-To: <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OjI+tStzI9uSbnvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 02:28:57PM +0100, Marek Szyprowski wrote:
> On 17.03.2023 07:47, Yu Zhe wrote:
> > Pointer variables of void * type do not require type cast.
> >
> > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > ---
> >   drivers/mmc/core/debugfs.c  | 2 +-
> >   drivers/mmc/core/host.c     | 2 +-
> >   drivers/mmc/core/mmc_test.c | 6 +++---
> >   3 files changed, 5 insertions(+), 5 deletions(-)
> ...
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 096093f7be00..76900f67c782 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> >   
> >   static void devm_mmc_host_release(struct device *dev, void *res)
> >   {
> > -	mmc_free_host(*(struct mmc_host **)res);
> > +	mmc_free_host(res);
> 
> The above chunk is wrong and causes following regression on today's 
> Linux next-20230324:

Ugh...

Ok.  I have a script that I use to help review mechanical patches.  I
have added an '-r cast' option to help review "remove unnecessary cast"
patches.

If you do `cat this_email.txt | rename_rev.pl -r cast` then the output
looks like:

================
 static void devm_mmc_host_release(struct device *dev, void *res)
 {
-       mmc_free_host(*res);
+       mmc_free_host(res);
 }
 
 struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
================

I have gone through all of Yu Zhe's patches and the rest are okay.

I've attached my rename_rev.pl script.

regards,
dan carpenter


--OjI+tStzI9uSbnvV
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="rename_rev.pl"

#!/usr/bin/perl

# This is a tool to help review variable rename patches. The goal is
# to strip out the automatic sed renames and the white space changes
# and leaves the interesting code changes.
#
# Example 1: A patch renames openInfo to open_info:
#     cat diff | rename_review.pl openInfo open_info
#
# Example 2: A patch swaps the first two arguments to some_func():
#     cat diff | rename_review.pl \
#                    -e 's/some_func\((.*?),(.*?),/some_func\($2, $1,/'
#
# Example 3: A patch removes the xkcd_ prefix from some but not all the
# variables.  Instead of trying to figure out which variables were renamed
# just remove the prefix from them all:
#     cat diff | rename_review.pl -ea 's/xkcd_//g'
#
# Example 4: A patch renames 20 CamelCase variables.  To review this let's
# just ignore all case changes and all '_' chars.
#     cat diff | rename_review -ea 'tr/[A-Z]/[a-z]/' -ea 's/_//g'
#
# The other arguments are:
# -nc removes comments
# -ns removes '\' chars if they are at the end of the line.

use strict;
use File::Temp qw/ :mktemp  /;

sub usage() {
    print "usage: cat diff | $0 old new old new old new...\n";
    print "   or: cat diff | $0 -e 's/old/new/g'\n";
    print " -a : auto";
    print " -e : execute on old lines\n";
    print " -ea: execute on all lines\n";
    print " -nc: no comments\n";
    print " -nb: no unneeded braces\n";
    print " -ns: no slashes at the end of a line\n";
    print " -pull: for function pull.  deletes context.\n";
    print " -r <recipe>: NULL, bool, cast";
    exit(1);
}
my @subs;
my @strict_subs;
my @cmds;
my $strip_comments;
my $strip_braces;
my $strip_slashes;
my $pull_context;
my $auto;

sub filter($) {
    my $line = shift();
    my $old = 0;
    if ($line =~ /^-/) {
        $old = 1;
    }
    # remove the first char
    $line =~ s/^[ +-]//;
    if ($strip_comments) {
        $line =~ s/\/\*.*?\*\///g;
        $line =~ s/\/\/.*//;
    }
    foreach my $cmd (@cmds) {
        if ($old || $cmd->[0] =~ /^-ea$/) {
            eval "\$line =~ $cmd->[1]";
        }
    }
    foreach my $sub (@subs) {
        if ($old) {
            $line =~ s/$sub->[0]/$sub->[1]/g;
        }
    }
    foreach my $sub (@strict_subs) {
        if ($old) {
            $line =~ s/\b$sub->[0]\b/$sub->[1]/g;
        }
    }

    # remove the newline so we can move curly braces here if we want.
    $line =~ s/\n//;
    return $line;
}

while (my $param1 = shift()) {
    if ($param1 =~ /^-a$/) {
        $auto = 1;
        next;
    }
    if ($param1 =~ /^-nc$/) {
        $strip_comments = 1;
        next;
    }
    if ($param1 =~ /^-nb$/) {
        $strip_braces = 1;
        next;
    }
    if ($param1 =~ /^-ns$/) {
        $strip_slashes = 1;
        next;
    }
    if ($param1 =~ /^-pull$/) {
        $pull_context = 1;
        next;
    }
    my $param2 = shift();
    if ($param2 =~ /^$/) {
        usage();
    }
    if ($param1 =~ /^-e(a|)$/) {
        push @cmds, [$param1, $param2];
        next;
    }
    if ($param1 =~ /^-r$/) {
        if ($param2 =~ /bool/) {
            push @cmds, ["-e", "s/== true//"];
            push @cmds, ["-e", "s/true ==//"];
            push @cmds, ["-e", "s/([a-zA-Z\-\>\._]+) == false/!\$1/"];
            next;
        } elsif ($param2 =~ /NULL/) {
            push @cmds, ["-e", "s/ != NULL//"];
            push @cmds, ["-e", "s/([a-zA-Z\-\>\._0-9]+) == NULL/!\$1/"];
            next;
        } elsif ($param2 =~ /^BIT$/) {
            push @cmds, ["-e", 's/1[uU]* *<< *(\d+)/BIT($1)/'];
            push @cmds, ["-e", 's/\(1 *<< *(\w+)\)/BIT($1)/'];
            push @cmds, ["-e", 's/\(BIT\((.*?)\)\)/BIT($1)/'];
            next;
        } elsif ($param2 =~ /^HBIT$/) {
            push @cmds, ["-e", 's/0x0*1\b/BIT(0)/'];
            push @cmds, ["-e", 's/0x0*2\b/BIT(1)/'];
            push @cmds, ["-e", 's/0x0*4\b/BIT(2)/'];
            push @cmds, ["-e", 's/0x0*8\b/BIT(3)/'];
            push @cmds, ["-e", 's/0x0*10\b/BIT(4)/'];
            push @cmds, ["-e", 's/0x0*20\b/BIT(5)/'];
            push @cmds, ["-e", 's/0x0*40\b/BIT(6)/'];
            push @cmds, ["-e", 's/0x0*80\b/BIT(7)/'];
            next;
        } elsif ($param2 =~ /cast/) {
            push @cmds, ["-e", 's/\(struct .*?\)//'];
            next;
        }

        usage();
    }

    push @subs, [$param1, $param2];
}

my ($oldfh, $oldfile) = mkstemp("/tmp/oldXXXXX");
my ($newfh, $newfile) = mkstemp("/tmp/newXXXXX");

my @input = <STDIN>;

# auto works on the observation that the - line comes before the + line when we
# rename variables.  Take the first - line.  Find the first + line.  Find the
# one word difference.  Test that the old word never occurs in the new text.
if ($auto) {
    my %c_keywords = (  auto => 1,
                        break => 1,
                        case => 1,
                        char => 1,
                        const => 1,
                        continue => 1,
                        default => 1,
                        do => 1,
                        double => 1,
                        else => 1,
                        enum => 1,
                        extern => 1,
                        float => 1,
                        for => 1,
                        goto => 1,
                        if => 1,
                        int => 1,
                        long => 1,
                        register => 1,
                        return => 1,
                        short => 1,
                        signed => 1,
                        sizeof => 1,
                        static => 1,
                        struct => 1,
                        switch => 1,
                        typedef => 1,
                        union => 1,
                        unsigned => 1,
                        void => 1,
                        volatile => 1,
                        while => 1);
    my %old_words;
    my %new_words;
    my %added_cmds;
    my @new_subs;

    my $inside = 0;
    foreach my $line (@input) {
        if ($line =~ /^(---|\+\+\+)/) {
            next;
        }

        if ($line =~ /^@/) {
            $inside = 1;
        }
        if ($inside && !(($_ =~ /^[- @+]/) || ($_ =~ /^$/))) {
            $inside = 0;
        }
        if (!$inside) {
            next;
        }

        if ($line =~ /^-/) {
            s/-//;
            my @words = split(/\W+/, $line);
            foreach my $word (@words) {
                $old_words{$word} = 1;
            }
        } elsif ($line =~ /^\+/) {
            s/\+//;
            my @words = split(/\W+/, $line);
            foreach my $word (@words) {
                $new_words{$word} = 1;
            }
        }
    }

    my $old_line;
    my $new_line;
    $inside = 0;
    foreach my $line (@input) {
        if ($line =~ /^(---|\+\+\+)/) {
            next;
        }

        if ($line =~ /^@/) {
            $inside = 1;
        }
        if ($inside && !(($_ =~ /^[- @+]/) || ($_ =~ /^$/))) {
            $inside = 0;
        }
        if (!$inside) {
            next;
        }


        if ($line =~ /^-/ && !$old_line) {
            s/^-//;
            $old_line = $line;
            next;
        } elsif ($old_line && $line =~ /^\+/) {
            s/^\+//;
            $new_line = $line;
        } else {
            next;
        }

        my @old_words = split(/\W+/, $old_line);
        my @new_words = split(/\W+/, $new_line);
        my @new_cmds;

        my $i;
        my $diff_count = 0;
        for ($i = 0; ; $i++) {
            if (!defined($old_words[$i]) && !defined($new_words[$i])) {
                last;
            }
            if (!defined($old_words[$i]) || !defined($new_words[$i])) {
                $diff_count = 1000;
                last;
            }
            if ($old_words[$i] eq $new_words[$i]) {
                next;
            }
            if ($c_keywords{$old_words[$i]}) {
                $diff_count = 1000;
                last;
            }
            if ($new_words{$old_words[$i]}) {
                $diff_count++;
            }
            push @new_cmds, [$old_words[$i], $new_words[$i]];
        }
        if ($diff_count <= 2) {
            foreach my $sub (@new_cmds) {
                if ($added_cmds{$sub->[0] . $sub->[1]}) {
                    next;
                }
                $added_cmds{$sub->[0] . $sub->[1]} = 1;
                push @new_subs, [$sub->[0] , $sub->[1]];
            }
        }

        $old_line = 0;
    }

    if (@new_subs) {
        print "RENAMES:\n";
        foreach my $sub (@new_subs) {
            print "$sub->[0] => $sub->[1]\n";
            push @strict_subs, [$sub->[0] , $sub->[1]];
        }
        print "---\n";
    }
}

my $output;

#recreate an old file and a new file
my $inside = 0;
foreach (@input) {
    if ($pull_context && !($_ =~ /^[+-@]/)) {
        next;
    }

    if ($_ =~ /^(---|\+\+\+)/) {
        next;
    }

    if ($_ =~ /^@/) {
        $inside = 1;
    }
    if ($inside && !(($_ =~ /^[- @+]/) || ($_ =~ /^$/))) {
        $inside = 0;
    }
    if (!$inside) {
        next;
    }

    $output = filter($_);

    if ($strip_braces && $_ =~ /^(\+|-)\W+{/) {
        $output =~ s/^[\t ]+(.*)/ $1/;
    } else {
        $output = "\n" . $output;
    }

    if ($_ =~ /^-/) {
        print $oldfh $output;
        next;
    }
    if ($_ =~ /^\+/) {
        print $newfh $output;
        next;
    }
    print $oldfh $output;
    print $newfh $output;

}
print $oldfh "\n";
print $newfh "\n";
# git diff puts a -- and version at the end of the diff.  put the -- into the
# new file as well so it's ignored
if ($output =~ /\n-/) {
    print $newfh "-\n";
}

my $hunk;
my $old_txt;
my $new_txt;

open diff, "diff -uw $oldfile $newfile |";
while (<diff>) {
    if ($_ =~ /^(---|\+\+\+)/) {
        next;
    }

    if ($_ =~ /^@/) {

        if ($strip_comments) {
            $old_txt =~ s/\/\*.*?\*\///g;
            $new_txt =~ s/\/\*.*?\*\///g;
        }
        if ($strip_braces) {
            $old_txt =~ s/{([^;{]*?);}/$1;/g;
            $new_txt =~ s/{([^;{]*?);}/$1;/g;
            # this is a hack because i don't know how to replace nested
            # unneeded curly braces.
            $old_txt =~ s/{([^;{]*?);}/$1;/g;
            $new_txt =~ s/{([^;{]*?);}/$1;/g;
        }

        if ($old_txt ne $new_txt) {
            print $hunk;
            print $_;
        }
        $hunk = "";
        $old_txt = "";
        $new_txt = "";
        next;
    }

    $hunk = $hunk . $_;

    if ($strip_slashes) {
        s/\\$//;
    }

    if ($_ =~ /^-/) {
        s/-//;
        s/[ \t\n]//g;
        $old_txt = $old_txt . $_;
        next;
    }
    if ($_ =~ /^\+/) {
        s/\+//;
        s/[ \t\n]//g;
        $new_txt = $new_txt . $_;
        next;
    }
    if ($_ =~ /^ /) {
        s/^ //;
        s/[ \t\n]//g;
        $old_txt = $old_txt . $_;
        $new_txt = $new_txt . $_;
    }
}

if ($old_txt ne $new_txt) {
    if ($strip_comments) {
        $old_txt =~ s/\/\*.*?\*\///g;
        $new_txt =~ s/\/\*.*?\*\///g;
    }
    if ($strip_braces) {
        $old_txt =~ s/{([^;{]*?);}/$1;/g;
        $new_txt =~ s/{([^;{]*?);}/$1;/g;
        $old_txt =~ s/{([^;{]*?);}/$1;/g;
        $new_txt =~ s/{([^;{]*?);}/$1;/g;
    }

    print $hunk;
}

unlink($oldfile);
unlink($newfile);

print "\ndone.\n";

--OjI+tStzI9uSbnvV--
