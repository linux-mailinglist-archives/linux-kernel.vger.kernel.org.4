Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B76676564
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAUJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:18:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4B4F84B;
        Sat, 21 Jan 2023 01:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76E35B82841;
        Sat, 21 Jan 2023 09:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25334C433A1;
        Sat, 21 Jan 2023 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674292719;
        bh=mA9ejibVRK+MNBY1BLKv1msYutJZL66f/w8OohSF5UU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbQpInJVCXxBiCnrM72P5EMfLfGcbmhmvXOsmiJdmga77QV2yGi9oWLmTVhnI0x9O
         1v7fqVDQizG1y0GesYFU9VFKLlBai2uX9G0xDltEkECPyG+PEwiJ8p73cRe1Bji9Qs
         g8ylOuvB5sHzH7pFf5JuzutVQxOBzE7qw3jhIyDap6gOcxjwtiqkqhK4AzHcOef8Y5
         kWTHcvQJLdq3asdkXONcq3NS02tHieofMCDkjgMBXeeabcaTq0TpOdKV3zXC3ZDZ9/
         7OZ7GRVJba5B/f7zBV0bJn5tzzX9ck22P/Z67Ol/l3i78bbzgBGBAPVXVMMzHblQ4y
         j+pOYkeF65MfA==
Received: by mail-oi1-f178.google.com with SMTP id d188so6394669oia.3;
        Sat, 21 Jan 2023 01:18:39 -0800 (PST)
X-Gm-Message-State: AFqh2kr3lBQDmQf2Ftyd5kDru+WrbwD3ii8ecdCSKmI5j2HE2leDCXEW
        tHKWWG1FJ4AfYI82UlgyOGnTkT31T6i+hUMciOw=
X-Google-Smtp-Source: AMrXdXt+F5bbCs8MzG9OBYDwkbIvrl3ZFfBp/R35/JSvzdbV1ONH6mEfqfN5OauMEtnHWaNJ5c48CsOzQqtPinEcESY=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr1077897oib.287.1674292718293; Sat, 21
 Jan 2023 01:18:38 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
 <20230121052507.885734-1-varmavinaym@gmail.com>
In-Reply-To: <20230121052507.885734-1-varmavinaym@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 21 Jan 2023 18:18:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
Message-ID: <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     alicef@alicef.me, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 2:25 PM Vinay Varma <varmavinaym@gmail.com> wrote:
>
> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.
>
> The change involves adding an optional parameter `external_src` to the
> `generate_rust_analyzer.py` which expects the path to the out-of-tree
> module's source directory. When this parameter is passed, I have chosen
> not to add the non-core modules (samples and drivers) into the result
> since these are not expected to be used in third party modules. Related
> changes are also made to the Makefile and rust/Makefile allowing the
> `rust-analyzer` target to be used for out-of-tree modules as well.
>
> Link: https://github.com/Rust-for-Linux/linux/pull/914
> Link: https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2
>
> Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
> ---
>  Makefile                          | 12 +++++++-----
>  rust/Makefile                     |  6 ++++--
>  scripts/generate_rust_analyzer.py | 31 ++++++++++++++++++-------------
>  3 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f41ec8c8426b..a055a316d2a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1831,11 +1831,6 @@ rustfmt:
>  rustfmtcheck: rustfmt_flags = --check
>  rustfmtcheck: rustfmt
>
> -# IDE support targets
> -PHONY += rust-analyzer
> -rust-analyzer:
> -       $(Q)$(MAKE) $(build)=rust $@
> -
>  # Misc
>  # ---------------------------------------------------------------------------
>
> @@ -1888,6 +1883,7 @@ help:
>         @echo  '  modules         - default target, build the module(s)'
>         @echo  '  modules_install - install the module'
>         @echo  '  clean           - remove generated files in module directory only'
> +       @echo  '  rust-analyzer   - generate rust-project.json rust-analyzer support file'
>         @echo  ''
>
>  endif # KBUILD_EXTMOD
> @@ -2022,6 +2018,12 @@ quiet_cmd_tags = GEN     $@
>  tags TAGS cscope gtags: FORCE
>         $(call cmd,tags)
>
> +# IDE support targets
> +PHONY += rust-analyzer
> +rust-analyzer:
> +       $(Q)$(MAKE) $(build)=rust $@
> +
> +


Extra empty line.


>  # Script to generate missing namespace dependencies
>  # ---------------------------------------------------------------------------
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 8f598a904f38..41c1435cd8d4 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -389,8 +389,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
>         $(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>
>  rust-analyzer:
> -       $(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
> -               $(RUST_LIB_SRC) > $(objtree)/rust-project.json
> +       $(Q)$(srctree)/scripts/generate_rust_analyzer.py \
> +               $(abs_srctree) $(abs_objtree) \
> +               $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> +               $(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json



This is equivalent to:

  >  $(extmod_prefix)/rust-project.json



See the rule of 'compile_commands.json'.







>  $(obj)/core.o: private skip_clippy = 1
>  $(obj)/core.o: private skip_flags = -Dunreachable_pub
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index ecc7ea9a4dcf..1792f379ee4e 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -6,10 +6,11 @@
>  import argparse
>  import json
>  import logging
> +import os
>  import pathlib
>  import sys
>
> -def generate_crates(srctree, objtree, sysroot_src):
> +def generate_crates(srctree, objtree, sysroot_src, external_src):
>      # Generate the configuration list.
>      cfg = []
>      with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> @@ -65,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src):
>          [],
>          is_proc_macro=True,
>      )
> -    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
> +    crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
>
>      append_crate(
>          "build_error",
> @@ -95,25 +96,28 @@ def generate_crates(srctree, objtree, sysroot_src):
>          "exclude_dirs": [],
>      }
>
> +    def is_root_crate(build_file, target):
> +        return os.path.exists(build_file) and target in open(build_file).read()
> +
>      # Then, the rest outside of `rust/`.
>      #
>      # We explicitly mention the top-level folders we want to cover.


Huh, not maintainable, unfortunately.





> -    for folder in ("samples", "drivers"):
> +    for folder in ("samples", "drivers") if external_src is None else [external_src]:
>          for path in (srctree / folder).rglob("*.rs"):



It is odd to add 'srctree' prefix to external module sources.



I think rust-project.json is a similar concept to
compile_commands.json, but it was implemented
in a different way.







-- 
Best Regards
Masahiro Yamada
