Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8376DBA15
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDHKbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Apr 2023 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDHKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:31:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D8E42;
        Sat,  8 Apr 2023 03:30:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g17so2347901ejt.1;
        Sat, 08 Apr 2023 03:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680949729; x=1683541729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5prd9jiPY6aPPA4NHCME6A4G1D5JLdJePd4hvf7GCtE=;
        b=AjZlqcHGxyPDHiJOvjnNcJjTxQke1F4mllun5eHihqwumioIQPPE9RBgQFx3I0HOP1
         5pVMCvFywv8j8fl0fAW3C+xEiDRZ/XFWoFQqXKPlzWg9HdHlIX4lQJ656XJ/FuBOuGK2
         GDrj1uGquLZSbIPXKHyY+LhlhQ9H7idwcsOdF3WNdrXwQbZcfbKj031aOYvLjjNORbvs
         ZIXvBazkpfXyT37GbltfJ+I9e183xW46lzbJefrOtQUPcdcM5kbVGE+04JC4hUDFLmfW
         LaTR37HGu1TVqOtnObcWZqc0V5MRMKcX9cgIQ2Lsgk8SCIbajiIYPX2U0ktTB2kYHu+8
         AMrg==
X-Gm-Message-State: AAQBX9cDxpcp9g8mS9rH60D+gblbNVsJxbBgLyWZoAtl39PDf2vibeSX
        smGWa6oQba3k9SdMogxOx8ZfHrAZcUptpCEb
X-Google-Smtp-Source: AKy350YHTXVFSmt/CeCoIJAShRJWWuhKn47T0Y8awo2NZYWPHGZyOHqe3R9QVWrVl7PSOxAfjLUDfA==
X-Received: by 2002:a17:906:bce7:b0:94a:5361:d448 with SMTP id op7-20020a170906bce700b0094a5361d448mr31930ejb.31.1680949729010;
        Sat, 08 Apr 2023 03:28:49 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id gt19-20020a170906f21300b00905a1abecbfsm3006359ejb.47.2023.04.08.03.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 03:28:48 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-94a34d3812cso21542366b.2;
        Sat, 08 Apr 2023 03:28:48 -0700 (PDT)
X-Received: by 2002:a50:d0d9:0:b0:4fb:f19:87f with SMTP id g25-20020a50d0d9000000b004fb0f19087fmr2476755edf.3.1680949727831;
 Sat, 08 Apr 2023 03:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230407070517.204676-1-andrea.righi@canonical.com>
In-Reply-To: <20230407070517.204676-1-andrea.righi@canonical.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Sat, 8 Apr 2023 06:28:11 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8X4mCq7wCD5ASOafQR_Wap2uQsgTwAVGH221CGXfiT9w@mail.gmail.com>
Message-ID: <CAEg-Je8X4mCq7wCD5ASOafQR_Wap2uQsgTwAVGH221CGXfiT9w@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Eric Curtin <ecurtin@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 3:05 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> Commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> introduced the constraint "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE"
> to enable RUST.
>
> With this constraint we don't need is_rust_module.sh anymore, because
> 'pahole --lang_exclude=rust' already has the capability to exclude Rust
> CUs. If pahole isn't recent enough (< 1.24) to support --lang_exclude,
> then DEBUG_INFO_BTF can't be enabled with RUST and is_rust_module.sh
> isn't used as well.
>
> In any case is_rust_module.sh is obsolete and we can just drop it.
>
> Link: https://lore.kernel.org/lkml/Y+p2xKIN6TJnQinK@righiandr-XPS-13-7390/
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  rust/macros/module.rs     |  2 +-
>  scripts/Makefile.modfinal |  2 --
>  scripts/is_rust_module.sh | 16 ----------------
>  3 files changed, 1 insertion(+), 19 deletions(-)
>  delete mode 100755 scripts/is_rust_module.sh
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..608406f33a70 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -179,7 +179,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              /// Used by the printing macros, e.g. [`info!`].
>              const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
>
> -            /// The \"Rust loadable module\" mark, for `scripts/is_rust_module.sh`.
> +            /// The \"Rust loadable module\" mark.
>              //
>              // This may be best done another way later on, e.g. as a new modinfo
>              // key or a new section. For the moment, keep it simple.
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 4703f652c009..e6f8fa3c9b8d 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -41,8 +41,6 @@ quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko =                                                     \
>         if [ ! -f vmlinux ]; then                                       \
>                 printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> -       elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then           \
> -               printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
>         else                                                            \
>                 LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
>                 $(RESOLVE_BTFIDS) -b vmlinux $@;                        \
> diff --git a/scripts/is_rust_module.sh b/scripts/is_rust_module.sh
> deleted file mode 100755
> index 28b3831a7593..000000000000
> --- a/scripts/is_rust_module.sh
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# is_rust_module.sh module.ko
> -#
> -# Returns `0` if `module.ko` is a Rust module, `1` otherwise.
> -
> -set -e
> -
> -# Using the `16_` prefix ensures other symbols with the same substring
> -# are not picked up (even if it would be unlikely). The last part is
> -# used just in case LLVM decides to use the `.` suffix.
> -#
> -# In the future, checking for the `.comment` section may be another
> -# option, see https://github.com/rust-lang/rust/pull/97550.
> -${NM} "$*" | grep -qE '^[0-9a-fA-F]+ r _R[^[:space:]]+16___IS_RUST_MODULE[^[:space:]]*$'
> --
> 2.39.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
真実はいつも一つ！/ Always, there's only one truth!
