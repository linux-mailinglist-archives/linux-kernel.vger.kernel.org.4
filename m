Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A96420F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiLEBGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiLEBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:06:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FF12AB4;
        Sun,  4 Dec 2022 17:06:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so9108057pgr.12;
        Sun, 04 Dec 2022 17:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JcTA+lzhR3ar+0ip03v9kDBhC+z8PXGNGAXFJN8VUu8=;
        b=UsjQtVaPLZd4nN/BoxX4Fy97ZmOLjsn1F0zMtGRioYj+MkuVQ8HpjdQwbBXsBfMQoa
         BXj8Iu7ZK8ywiikOrn0t6MGmystj5e9x7+7HKzEPC98Yh7dFWuhn/gWxhq2EFHZBOq9+
         1vhZslGUilYaLBmo4MAiXQcQoGZmsvx3kwmTA6YkpgEPMXQstYG79gq3+2UJTALV9aNd
         7MVzZ3ApHObDZyJbaVeEUd3vulfl4wB38JyG600S5vjrUa45nvaMJRcF1YByrShfoM/w
         HuehfLwHiKexh3AyRandYqsjpQfRkZ9NhUs+ISTV2e2Ni7SRX/aG1+d0ifla+rAUp7XT
         vh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcTA+lzhR3ar+0ip03v9kDBhC+z8PXGNGAXFJN8VUu8=;
        b=xCmVkCszUOFciCPnlD8KloiHySJg0iFxwpWqtEWIUy/GX1mffYUM7+I+LClPKj1bHB
         hNndInHuMljDUY5/+Ccj26m851lGdYWrcgg1c9Cz9cuJRo8j6vuX7U1dxDGzBTBbaOyi
         LkPCko9AXK/zAe0PAnwBlSKBCOAIkZ2xR6HPircYHx1NCPeVyGjHGlhHvNtYXbrNTMFm
         tkokd1iTb5c7/dEZt7b4YULL8eCeTomEnEBlhxPrxpmzZvgXcdQRMUcfh8crwlMvwrzR
         IZBrsuh1+TpeqslVIF4CFQqLt9TYU12BS0wWQn9qOm7OPxbCawpLzAFlHFaTmXzQmD+m
         8arg==
X-Gm-Message-State: ANoB5plhGXv56ZXP55Ps2Ss1LkYPc/80/LOOZrHCkk8t//Tj4QvU5nOT
        BNA5aCNH09vZk/0iXEzmZv8=
X-Google-Smtp-Source: AA0mqf7WmE1btk4IzBiwD2NejRa0hmjHYYEN12TC5JcPJkyLBW9u7TwyqPVv5MqvOhqsI2KI+Hmfaw==
X-Received: by 2002:aa7:815a:0:b0:562:d99c:2f66 with SMTP id d26-20020aa7815a000000b00562d99c2f66mr68703284pfn.42.1670202394892;
        Sun, 04 Dec 2022 17:06:34 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79991000000b00574ab0e053bsm3285064pfh.187.2022.12.04.17.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 17:06:34 -0800 (PST)
Message-ID: <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
Date:   Mon, 5 Dec 2022 10:06:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
Content-Language: en-US
In-Reply-To: <20221201204814.2141401-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2022 14:48:14 -0600, Carlos Bilbao wrote:
> Include HTML output generated with rustdoc into the Linux kernel
> documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
> and the generation of Rust documentation, when support is available.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> 
> Changes since V1:
>  - Work on top of v6.1-rc1.

Thank you for the rebase.

>  - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
>  - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
>  - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
>  - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.
> 
> ---
>  Documentation/Makefile       |  4 ++++
>  Documentation/rust/index.rst |  3 +++
>  rust/Makefile                | 15 +++++++++------
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 64d44c1ecad3..f537cf558af6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	fi
>  
>  htmldocs:
> +# If Rust support is available, add rustdoc generated contents
> +ifdef CONFIG_RUST
> +	$(Q)$(MAKE) rustdoc
> +endif
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))

So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
I'm not sure this new requirement is acceptable for kernel documentation
testers who just want to build kernel documentation.

You are doing three things in this patch.

 1) Change the destination of rustdoc to under Documentation/output/
 2) Add a cross reference to the generated rustdoc in
    Documentation/rust/index.rst.
 3) Integrate rustdoc generation into htmldocs.

I'm OK with 1) and 2).
Can you separate 3) into another patch and respin?

By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
In other words, are contents of rustdoc affected by other config settings?

If not, I think rustdoc can be generated regardless of config settings as
far as necessary tools (rustc, bindgen, etc.) are available.

>  
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index 4ae8c66b94fa..4005326c3ba9 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,6 +6,9 @@ Rust
>  Documentation related to Rust within the kernel. To start using Rust
>  in the kernel, please read the quick-start.rst guide.
>  
> +If this documentation includes rustdoc-generated HTML, the entry point can
> +be found `here. <rustdoc/kernel/index.html>`_

This cross reference will only make sense in htmldocs build.
Perhaps, you can use the "only::" directive [1] as follows:

.. only:: html

    If this documentation includes rustdoc-generated HTML, the entry point can
    be found `here. <rustdoc/kernel/index.html>`_

[1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-only

        Thanks, Akira

> +
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
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
