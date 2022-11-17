Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45B62E51C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiKQTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiKQTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:15:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152F785176
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:15:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k5so2494344pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqReIcW9s0Rx+ZZxRkzmtucR2377ZRmpngvb88GnLsg=;
        b=GOP378AKH/hv8Ar+sxOQ+MTbMDvMqgysny+XsfnA1NeD7BCG7kFsVW86EaxkoT3Rmo
         crJ093HED/R3LtbkrmLrYynfePGhZJBR1f642uzkd7gF9ttW+TcC4nZ6B/pQz/AuBN/p
         uxCcnKW/3Rzd1tusg7w+cUxuAytjrFkV0vzegfMQzGNbmHNxCBXT79csyRyoV+MyfRHi
         E+ZKGxPTAiLl45/3OfuLwCEUrrlWzahwy9srX5RWORrjfewK9d0tObXqwOEig8Jn/3dk
         zHeIZFgrbxrqjxCvOztd37+KYIJqwbZsNSSeTllD8fwVh+LNZ604Df8gMhpS4pLXcKdM
         n+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqReIcW9s0Rx+ZZxRkzmtucR2377ZRmpngvb88GnLsg=;
        b=oUgZIjGkiJyYcx0MY155NG3K1KS/9Qgrw4rKwTZ/5Gstst5+meu+RuVn12lNgmwN3/
         9Cve36O84/3q5QRNl9fZVJuVEsIfTs+WwfhI+eCnf+8cHqOsxHAttQs0vWejMMIPfeOg
         kitoDbrbN6RKALDDkSU+/R78MNiZc7b4H5j5yicvBqEKIjoJ6Jx207a/VOKJmMUIthw6
         7mhayFbfbm6DamHYctkCJV1DjbGXkRfvQeiSYhMkY4o5eUD8kUu44WRPg96MNVeP04tq
         UqDjiB4KbUM6vjTrS1NJkm1FbonuVWK8synDuDaq50xrxZlAORxOoa0VEiKUiOU82V7I
         +yhA==
X-Gm-Message-State: ANoB5pmF48Ct6vdcFL4ceI/nobJy6Vp8wA8zHVeaWtzxJ3vLC50fcDCU
        KxQM3wHuCBVJbMw0G3bXq9csR/ew7VPWM8bI8Q3w4g==
X-Google-Smtp-Source: AA0mqf6uyYTOrbrUoUgvOqU2dy8oTvk0QDhsnTGXbpoRtxusgfBO0VUArzQuIC363xnourJQ4v+pQOZpiQFTPzv3rSk=
X-Received: by 2002:a17:902:8307:b0:186:8558:ded2 with SMTP id
 bd7-20020a170902830700b001868558ded2mr4098074plb.95.1668712521318; Thu, 17
 Nov 2022 11:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20221114225719.1657174-1-nathan@kernel.org>
In-Reply-To: <20221114225719.1657174-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Nov 2022 11:15:09 -0800
Message-ID: <CAKwvOdn67r3ZYb5XZkae3i5797GGV3=8=nLC7kT2d4On3OEm5A@mail.gmail.com>
Subject: Re: [PATCH] ARM: Drop '-mthumb' from AFLAGS_ISA
To:     Nathan Chancellor <nathan@kernel.org>,
        Sylvestre Ledru <sylvestre@debian.org>,
        Serge Guelton <sguelton@mozilla.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with CONFIG_THUMB2_KERNEL=y + a version of clang from
> Debian, the following warning occurs frequently:

I also needed to explicitly set
CROSS_COMPILE=arm-linux-gnueabihf-
to reproduce.  Please add that detail to the commit message.  Thanks
for helping spot that difference on IRC.

It sounds like tuxmake (which our CI is built on) and perhaps kernelCI
are both setting that variable, which is no longer necessary when
using LLVM=1 for ARCH=arm.

Not CROSS_COMPILE=arm-linux-gnueabi- like the triple we use by default
for ARCH=arm in scripts/Makefile.clang.  So this issue arises from:
1. using debian's clang, which is carrying an out of tree patch affecting this.
2. using `CROSS_COMPILE=arm-linux-gnueabihf-`.

The use of both of those in conjunction I'd like to think would be
relatively unlikely, but it seems that we have both CI systems doing
this (and the patch LGTM regardless of changing the CI).

>
>   <built-in>:383:9: warning: '__thumb2__' macro redefined [-Wmacro-redefined]
>   #define __thumb2__ 2
>           ^
>   <built-in>:353:9: note: previous definition is here
>   #define __thumb2__ 1
>           ^
>   1 warning generated.
>
> Debian carries a downstream patch that changes the default CPU of the
> arm-linux-gnueabihf target from 'arm1176jzf-s' (v6) to 'cortex-a7' (v7).
> As a result, '-mthumb' defines both '__thumb__' and '__thumb2__'. The
> define of '__thumb2__' via the command line was purposefully added to
> catch a situation like this.

And we caught something!  It's almost like Ard has sight-beyond-sight
or something when he made that suggestion. Coincidence? I think not...
:P

>
> In a similar vein as commit 26b12e084bce ("ARM: 9264/1: only use
> -mtp=cp15 for the compiler"), do not add '-mthumb' to AFLAGS_ISA, as it
> is already passed to the assembler via '-Wa,-mthumb' and '__thumb2__' is
> already defined for preprocessing.
>
> Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
> Link: htps://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/17354b030ac4252ff6c5e9d01f4eba28bd406b2d/debian/patches/930008-arm.diff

Would you mind using
https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/snapshot/debian/patches/930008-arm.diff
as the link instead? The link on this commit message is a diff against
llvm-14, not ToT which is currently llvm-16; the context is quite
different as the logic moved source files completely.  Though it does
look like Sylvestre has not yet cut a 16 branch for debian's patches.

If not, at least re-add the missing `t` from the protocol in the URL
(s/htps/https/).

> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I verified this locally with LLVM built from source, comparing no out
of tree patches vs just debian's 930008-arm.diff applied.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

---

If memory serves, this is perhaps the third time downstream debian
patches to llvm have caused us initially-difficult-to-reproduce bugs.
Sylvestre, going forward, would you mind please giving your diff's
more descriptive file names, or making them actual commits with some
context in the commit message?  Time and resource permitting,
submitting them upstream, even if they're not accepted, but pointing
to the upstream discussion (if any) from commit messages would provide
us more context for these kind of things.  Maybe Serge could help you
burn down those out of tree patches? ;)

> ---
>  arch/arm/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 357f0d9b8607..d1ebb746ff40 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -131,8 +131,9 @@ endif
>  AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> -CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
> +CFLAGS_ISA     +=-mthumb
>  else
>  CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>
> base-commit: 0c52591d22e99759da3793f19249bbf45ad742bd
> --
> 2.38.1
>


-- 
Thanks,
~Nick Desaulniers
