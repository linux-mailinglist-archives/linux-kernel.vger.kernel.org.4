Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA464556A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGI1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:27:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E932B9D;
        Wed,  7 Dec 2022 00:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670401639; x=1701937639;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=R/XiBBCtv6aOIMjJO4KmAzY1OO8RFbwEEx7Bwkl7GJ8=;
  b=Iyh6hc9uzicKnzapW9iAOGk7RONCWyAB9iGushUTphUYydASo3bWvZUB
   WAXZ399HiCzApYDUX5pMsuVt9xM+rcS1x7SkWvtUClYpV6wsEtOtMMNrr
   nfvMuBUdgAoWYLw6Ti77uG+LrYZZRaIhEViXx6TQmNbr1Azha2BUCVXO8
   xkrqxnC6UR9UEazB3wO42jbnQgWfvIqt/x6wdxNSW5s782qtakwE/e5Iq
   gzYfLecBN2fKRtQhzbhTSwIdqJpOhi/DWNPDSPhAHvdIaa1NdaCgkHaSP
   plyIo/QdK/mgRwq16GrVMnuWtnGXYXTvlab1K6zt7zRmxXIucNi/ZpM8a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="300255826"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="300255826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 00:27:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820880970"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820880970"
Received: from fbackhou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 00:27:14 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        akiyks@gmail.com, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
In-Reply-To: <20221206153151.771038-2-carlos.bilbao@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com>
Date:   Wed, 07 Dec 2022 10:27:11 +0200
Message-ID: <87359r39gg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022, Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> Generate rustdoc documentation with the rest of subsystem's documentation
> in Documentation/output. Add a cross reference to the generated rustdoc in
> Documentation/rust/index.rst.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/rust/index.rst |  5 +++++
>  rust/Makefile                | 15 +++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index 4ae8c66b94fa..416d6b3de1e4 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,6 +6,11 @@ Rust
>  Documentation related to Rust within the kernel. To start using Rust
>  in the kernel, please read the quick-start.rst guide.
>  
> +.. only:: html
> +
> +	If this documentation includes rustdoc-generated HTML, the entry
> +	point can be found `here <rustdoc/kernel/index.html>`_.
> +

It's a bit meh to have documentation that points to places that might
404 and the user has to figure it out.

We can do better than that.

You could use CONFIG_RUST to pass e.g. "-t rustdoc" to Sphinx in the
Makefile, and use:

.. only:: rustdoc

and

.. only:: not rustdoc

And document accordingly.

Also, please don't use "here" as the link text.

BR,
Jani.


>  .. toctree::
>      :maxdepth: 1
>  
> diff --git a/rust/Makefile b/rust/Makefile
> index 7700d3853404..080c07048065 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +# Where to place rustdoc generated documentation
> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
> +
>  always-$(CONFIG_RUST) += target.json
>  no-clean-files += target.json
>  
> @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>  	OBJTREE=$(abspath $(objtree)) \
>  	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>  		$(rustc_target_flags) -L$(objtree)/$(obj) \
> -		--output $(objtree)/$(obj)/doc \
> +		--output $(RUSTDOC_OUTPUT) \
>  		--crate-name $(subst rustdoc-,,$@) \
>  		@$(objtree)/include/generated/rustc_cfg $<
>  
> @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>  # and then retouch the generated files.
>  rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>      rustdoc-alloc rustdoc-kernel
> -	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
> -	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
> -	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
> +	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
> +	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
> +	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>  		-e 's:rust-logo\.svg:logo.svg:g' \
>  		-e 's:rust-logo\.png:logo.svg:g' \
>  		-e 's:favicon\.svg:logo.svg:g' \
>  		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>  	$(Q)echo '.logo-container > img { object-fit: contain; }' \
> -		>> $(objtree)/$(obj)/doc/rustdoc.css
> +		>> $(RUSTDOC_OUTPUT)/rustdoc.css
>  
>  rustdoc-macros: private rustdoc_host = yes
>  rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>  		@$(objtree)/include/generated/rustc_cfg \
>  		$(rustc_target_flags) $(rustdoc_test_target_flags) \
>  		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
> -		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
> +		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>  		--crate-name $(subst rusttest-,,$@) $<
>  
>  # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,

-- 
Jani Nikula, Intel Open Source Graphics Center
