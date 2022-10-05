Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30C5F58B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJEQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJEQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:58:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5D5FF48;
        Wed,  5 Oct 2022 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664989124; x=1696525124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SqbizTKYqT68rLHi+AgQ9y3XnriYji1uZnLd2r29nsw=;
  b=O0H8CDNnUvEI1WHIlAQYNvliS7qipixwqGJSgQGhcBJwiontK6ID841J
   Voa7rFQablN0FFlGkfb4xklYKiDa3Dn7I33oyUmZvW4Q+CT3yu+XPLIjY
   fH0oY+B+Dpc33e/2kIDYtbtXQWqGCm8Gb0JXSJMOGcxxrT5rlKwROgyQb
   nXfKUSnZmN2Lke8QFgGEMySaBqSH8dXFRMUZpQZYufvteI06s7j0WrDIk
   KQYUl5uv6jFnVbIaKkmcHoPaRl6cpWI9KJOQ+c3YfnDxr9Mosw/2Mpeso
   ltZw0GHiY/8a33m7dcSzoYkfXm/YyIOeH6we0RdZR1Psv8JXux4xuhcS8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="300810654"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="300810654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 09:58:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="713479829"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="713479829"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.39.173])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 09:58:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
In-Reply-To: <20221004201222.281845-6-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221004201222.281845-6-corbet@lwn.net>
Date:   Wed, 05 Oct 2022 19:58:39 +0300
Message-ID: <87r0zmqkao.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022, Jonathan Corbet <corbet@lwn.net> wrote:
> Make a few changes to cause functions documented by kerneldoc to stand out
> better in the rendered documentation.  Specifically, change kernel-doc to
> put the description section into a ".. container::" section, then add a bit
> of CSS to indent that section relative to the function prototype (or struct
> or enum definition).  Tweak a few other CSS parameters while in the
> neighborhood to improve the formatting.

Way back I tried to keep the formatting changes minimal to avoid opening
that particular can of worms along with the rest of the Sphinx
transition.

But I do wonder if people find value in repeating e.g. the struct
definitions in the documentation. I'd argue the rendered documentation
is more for an overview, and if you need to know the exact details,
you'll be in the editor typing code and you can look up the actual
definition in source. Having the definition feels maybe a bit excessive.

We also don't use Sphinx C Domain's ".. c:member::" for struct/union
members, or ".. c:enumerator::" for enumeration contants. They provide
arguably nicer rendering out of the box than our stuff.

The Sphinx way to do parameter lists would be field lists i.e. ":param
foo: description". Ditto for return values ":return: description". (Not
saying we should convert the comments, but kernel-doc the script could
emit those.)

Perhaps we'd be better off going towards Sphinx standard usage than
tweaking our own thing?

I'm afraid I don't have the time to work on this. Talk is cheap and all
that. My two cents.

Anyway, here are some examples how this might look like: [1].


BR,
Jani.



[1] https://hawkmoth.readthedocs.io/en/latest/examples.html


>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/sphinx-static/custom.css | 13 +++++++
>  scripts/kernel-doc                     | 52 ++++++++++++++++----------
>  2 files changed, 45 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
> index c465251e840a..d8823fbbd27b 100644
> --- a/Documentation/sphinx-static/custom.css
> +++ b/Documentation/sphinx-static/custom.css
> @@ -10,3 +10,16 @@ div.body h3 { font-size: 130%; }
>  
>  /* Tighten up the layout slightly */
>  div.body { padding: 0 15px 0 10px; }
> +
> +/* Don't force the document width */
> +div.document { width: auto; max-width: 60em; }
> +
> +/*
> + * Parameters for the display of function prototypes and such included
> + * from C source files.
> + */
> +dl.function, dl.struct, dl.enum { margin-top: 2em; background-color: #ecf0f3; }
> +/* indent lines 2+ of multi-line function prototypes */
> +dl.function dt { margin-left: 10em; text-indent: -10em; }
> +dt.sig-object { font-size: larger; }
> +div.kernelindent { margin-left: 2em; margin-right: 4em; }
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index aea04365bc69..13d42857bce2 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -866,48 +866,53 @@ sub output_function_rst(%) {
>  	print "\n";
>      }
>  
> -    print "**Parameters**\n\n";
> +    #
> +    # Put our descriptive text into a container (thus an HTML <div> to help
> +    # set the function prototypes apart.
> +    #
> +    print ".. container:: kernelindent\n\n";
>      $lineprefix = "  ";
> +    print $lineprefix . "**Parameters**\n\n";
>      foreach $parameter (@{$args{'parameterlist'}}) {
>  	my $parameter_name = $parameter;
>  	$parameter_name =~ s/\[.*//;
>  	$type = $args{'parametertypes'}{$parameter};
>  
>  	if ($type ne "") {
> -	    print "``$type``\n";
> +	    print $lineprefix . "``$type``\n";
>  	} else {
> -	    print "``$parameter``\n";
> +	    print $lineprefix . "``$parameter``\n";
>  	}
>  
>          print_lineno($parameterdesc_start_lines{$parameter_name});
>  
> +	$lineprefix = "    ";
>  	if (defined($args{'parameterdescs'}{$parameter_name}) &&
>  	    $args{'parameterdescs'}{$parameter_name} ne $undescribed) {
>  	    output_highlight_rst($args{'parameterdescs'}{$parameter_name});
>  	} else {
> -	    print "  *undescribed*\n";
> +	    print $lineprefix . "*undescribed*\n";
>  	}
> +	$lineprefix = "  ";
>  	print "\n";
>      }
>  
> -    $lineprefix = $oldprefix;
>      output_section_rst(@_);
> +    $lineprefix = $oldprefix;
>  }
>  
>  sub output_section_rst(%) {
>      my %args = %{$_[0]};
>      my $section;
>      my $oldprefix = $lineprefix;
> -    $lineprefix = "";
>  
>      foreach $section (@{$args{'sectionlist'}}) {
> -	print "**$section**\n\n";
> +	print $lineprefix . "**$section**\n\n";
>          print_lineno($section_start_lines{$section});
>  	output_highlight_rst($args{'sections'}{$section});
>  	print "\n";
>      }
>      print "\n";
> -    $lineprefix = $oldprefix;
>  }
>  
>  sub output_enum_rst(%) {
> @@ -915,6 +920,7 @@ sub output_enum_rst(%) {
>      my ($parameter);
>      my $oldprefix = $lineprefix;
>      my $count;
> +    my $outer;
>  
>      if ($sphinx_major < 3) {
>  	my $name = "enum " . $args{'enum'};
> @@ -924,14 +930,17 @@ sub output_enum_rst(%) {
>  	print "\n\n.. c:enum:: " . $name . "\n\n";
>      }
>      print_lineno($declaration_start_line);
> -    $lineprefix = "   ";
> +    $lineprefix = "  ";
>      output_highlight_rst($args{'purpose'});
>      print "\n";
>  
> -    print "**Constants**\n\n";
> -    $lineprefix = "  ";
> +    print ".. container:: kernelindent\n\n";
> +    $outer = $lineprefix . "  ";
> +    $lineprefix = $outer . "  ";
> +    print $outer . "**Constants**\n\n";
>      foreach $parameter (@{$args{'parameterlist'}}) {
> -	print "``$parameter``\n";
> +	print $outer . "``$parameter``\n";
> +
>  	if ($args{'parameterdescs'}{$parameter} ne $undescribed) {
>  	    output_highlight_rst($args{'parameterdescs'}{$parameter});
>  	} else {
> @@ -939,7 +948,7 @@ sub output_enum_rst(%) {
>  	}
>  	print "\n";
>      }
> -
> +    print "\n";
>      $lineprefix = $oldprefix;
>      output_section_rst(@_);
>  }
> @@ -982,18 +991,19 @@ sub output_struct_rst(%) {
>  	}
>      }
>      print_lineno($declaration_start_line);
> -    $lineprefix = "   ";
> +    $lineprefix = "  ";
>      output_highlight_rst($args{'purpose'});
>      print "\n";
>  
> -    print "**Definition**\n\n";
> -    print "::\n\n";
> +    print ".. container:: kernelindent\n\n";
> +    print $lineprefix . "**Definition**::\n\n";
>      my $declaration = $args{'definition'};
> -    $declaration =~ s/\t/  /g;
> -    print "  " . $args{'type'} . " " . $args{'struct'} . " {\n$declaration  };\n\n";
> +    $lineprefix = $lineprefix . "  ";
> +    $declaration =~ s/\t/$lineprefix/g;
> +    print $lineprefix . $args{'type'} . " " . $args{'struct'} . " {\n$declaration" . $lineprefix . "};\n\n";
>  
> -    print "**Members**\n\n";
>      $lineprefix = "  ";
> +    print $lineprefix . "**Members**\n\n";
>      foreach $parameter (@{$args{'parameterlist'}}) {
>  	($parameter =~ /^#/) && next;
>  
> @@ -1003,8 +1013,10 @@ sub output_struct_rst(%) {
>  	($args{'parameterdescs'}{$parameter_name} ne $undescribed) || next;
>  	$type = $args{'parametertypes'}{$parameter};
>          print_lineno($parameterdesc_start_lines{$parameter_name});
> -	print "``" . $parameter . "``\n";
> +	print $lineprefix . "``" . $parameter . "``\n";
> +	$lineprefix = "    ";
>  	output_highlight_rst($args{'parameterdescs'}{$parameter_name});
> +	$lineprefix = "  ";
>  	print "\n";
>      }
>      print "\n";

-- 
Jani Nikula, Intel Open Source Graphics Center
