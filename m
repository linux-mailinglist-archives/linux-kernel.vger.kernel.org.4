Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24A644ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLFW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLFW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:56:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D194A056;
        Tue,  6 Dec 2022 14:56:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so19413301pje.5;
        Tue, 06 Dec 2022 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCtW+MA1B2sGv6cbDKFnxVnKAKT7UQXyOCBUBu2RYBQ=;
        b=m+ogv/Qvnsr9dPyrYaqWb9CWuyH0R+XVDxQFi135JzdHs3k1U3H5kel3PcvqiQalDr
         gxz7txQo94fNHfVP/NYV7cyfj0J/ENrfPArB/+SsTod8Ie3k1NZF0GsajssOtzaeSoAe
         0adGYLiwK7UHoQYblzUd3OeDiHDm2yIOmOoQg8r4AuyiNaBpZIoGyvVVPi7AhzUGv0Jd
         O8nJ0o+AOAo6gtOUGCe4ct6Tn2gQGIbNBv4Se/FL4NndhwcCZDIdpGri78BYFrGoAV5D
         H3N73cLJnxqN6QwK5Em+/uHG1WsghkDQtFKiUyzSaOcJnL0GfQOiaNnjl9eyUxJy2LOu
         3E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCtW+MA1B2sGv6cbDKFnxVnKAKT7UQXyOCBUBu2RYBQ=;
        b=2ZZ3dU62DVDFlGXxWBd0/d0tZ2wSnJWtKoeFk+JPNh3UETwbIVPhtlNS0jUxJTkRhH
         qtesf7WLvn25eUrFNBmGStWpiGzlojnizALk+ecX3f3vpqTOpwTlQ26WczOseYDb7yLg
         PPPMihJ5zIaL8FSvUQTMpgpfLUwUKkzUMfWsZelXTvMZNl500RyaoVSk2oguQFNuFooc
         QoN1r3UvycOpT8lV4UZ2sWwgO9rabvouscMxq+rQh76Q3siy8Al6TSUfVXUDBvSSH7lY
         O/hvtRlomnP7phbOU4+z6IxjVC0cH6llXy9SotxxEK/VtSiA0jSK+DG3DCC8MeZw6Mev
         wyAg==
X-Gm-Message-State: ANoB5pnHjfVX/G8TK8EhgrUxVFcCLXiHx08fqkMZ23PEcncVYxaxBhIR
        jVYvl5fwpmRf2E4hvYq/FNs9satwezg=
X-Google-Smtp-Source: AA0mqf7+fxL1WGmNTHR1EPWdHlIa1qMLmpJjTGVsj11j8AMLbtFxDUVMUbm4DYiE0mlZumljT5KTRQ==
X-Received: by 2002:a17:902:cccf:b0:187:2f28:bfd6 with SMTP id z15-20020a170902cccf00b001872f28bfd6mr602131ple.21.1670367392639;
        Tue, 06 Dec 2022 14:56:32 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001872999f58esm13103290plk.189.2022.12.06.14.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 14:56:32 -0800 (PST)
Message-ID: <f54802a3-cf2f-8746-2273-0ae462a7f4eb@gmail.com>
Date:   Wed, 7 Dec 2022 07:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221206153151.771038-2-carlos.bilbao@amd.com>
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

On Tue, 6 Dec 2022 09:31:50 -0600, Carlos Bilbao wrote:
> Generate rustdoc documentation with the rest of subsystem's documentation
> in Documentation/output. Add a cross reference to the generated rustdoc in
> Documentation/rust/index.rst.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

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
