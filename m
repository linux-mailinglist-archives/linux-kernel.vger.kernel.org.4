Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AA6546E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiLVTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLVTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:52:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C0183B3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:52:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f9so1989803pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/BQ9n0kH0mbMHZf64/LlHldiSHJ2YosTB1WTP5AW4Lc=;
        b=hbQD11e1hF4r0xWaBVvu/F1S8mQcnYHXN3WCkQUqrRecdfPVpmqEmcIdXeZ1Vcumv0
         RgtJc4xnzZMdqdrDMqr2zjK1byRueshhIcwQKxLogZg/ENPE+ZR5xFk7OiSBRIm9CCs0
         oPvYBSG1ecgPXamSUqbXaCTdoGEp9HtePiNoONh7geNYvnSMwh3qyKKJcC5J2KhSXnQY
         krDpQEE2oeOd9kWdupcomaSxhFuxgqz+ORabvcf/xgX1HXCfECQuQyywqL61+qpdT+r8
         pVRaclu4S//C4T64ixOvQ+63jc650o5gu6llKkzRkg1f3ZwQswrCwvME6hBeCqxxw/Up
         YGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BQ9n0kH0mbMHZf64/LlHldiSHJ2YosTB1WTP5AW4Lc=;
        b=x/i8+zb+mEdyYqIC/sAK3UxPPoULhlHtww2uFvUEQsTNEaKzDv+UdB5YnWcUQxFayW
         /tEVWb4jtOpBQedRIeExlS1EC/6MqIkaBBwk/5Xv5mM+2SBaH3yI/2Kf5mqfah1xuXu/
         oOMD6rtcTpyD8zESxRUatWlpNomHjBnyyEdFmyK7IS7wbHMZlbVHctwGR79JJD/Vow+V
         Zo2280r6nJSDMnKMEabKsiyHs9MjIzCliud0v5XSj54Q1KSOfyzsmS0BiYIIU8kXq47a
         OBSwb2iZzIJD+qQgUM5N2H3O0KwSyEQ5kUilZhyf13Qv2MADEnhMQrQ+H+eWac9p7WFN
         r0Lw==
X-Gm-Message-State: AFqh2kphV9y1jR0wq4eYlJAem0Plwf2LHVCEKza3SZddAQRKZ71gZbWt
        dPI1dHkfyuU0gPItiIXhJW/caox3r1KBT7Bj8UwOhQ==
X-Google-Smtp-Source: AMrXdXsnPft8IYBEPo9Z+LHHRlHCuTrmoTUq3+LW1jhRDQYO1p5Z7/dvOq1phdCVwma3sjoBQpACsOaU2HoP+DA67L8=
X-Received: by 2002:a63:c50:0:b0:494:7a78:4bb0 with SMTP id
 16-20020a630c50000000b004947a784bb0mr278550pgm.427.1671738758528; Thu, 22 Dec
 2022 11:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20221222193039.2267074-1-nathan@kernel.org>
In-Reply-To: <20221222193039.2267074-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Dec 2022 11:52:27 -0800
Message-ID: <CAKwvOd=WQ5cAL74z+gbGgxG9WrOcDJtrGXJWxEEcWnmyoypu0w@mail.gmail.com>
Subject: Re: [PATCH] ARM: Reduce __thumb2__ definition to crypto files that
 require it
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
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

On Thu, Dec 22, 2022 at 11:30 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler") added
> a __thumb2__ define to ASFLAGS to avoid build errors in the crypto code,
> which relies on __thumb2__ for preprocessing. Commit 59e2cf8d21e0 ("ARM:
> 9275/1: Drop '-mthumb' from AFLAGS_ISA") followed up on this by removing
> -mthumb from AFLAGS so that __thumb2__ would not be defined when the
> default target was ARMv7 or newer.
>
> Unfortunately, the second commit's fix assumes that the toolchain
> defaults to -mno-thumb / -marm, which is not the case for Debian's
> arm-linux-gnueabihf target, which defaults to -mthumb:
>
>   $ echo | arm-linux-gnueabihf-gcc -dM -E - | grep __thumb
>   #define __thumb2__ 1
>   #define __thumb__ 1

Interesting, that was hard to foresee in review of 1d2e9b67b001 and
59e2cf8d21e0.

FWIW, their non-hf target does not.
$ echo | arm-linux-gnueabi-gcc -dM -E - | grep __thumb
$

>
> This target is used by several CI systems, which will still see
> redefined macro warnings, despite '-mthumb' not being present in the
> flags:
>
>   <command-line>: warning: "__thumb2__" redefined
>   <built-in>: note: this is the location of the previous definition
>
> Remove the global AFLAGS __thumb2__ define and move it to the crypto
> folder where it is required by the imported OpenSSL algorithms; the rest
> of the kernel should use the internal CONFIG_THUMB2_KERNEL symbol to
> know whether or not Thumb2 is being used or not. Be sure that __thumb2__
> is undefined first so that there are no macro redefinition warnings.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1772
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks Nathan and Ard.

I ran the following tests:

1. build w/ llvm stock config CONFIG_THUMB2_KERNEL=y kernel.
2. build w/ llvm+debian's OOT patch
https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/raw/622dbcbd40b316ed3905a2d25d9623544a06e6b1/debian/patches/930008-arm.diff
CONFIG_THUMB2_KERNEL=y kernel.
3. check that -U<foo> removes <foo> from being set by preprocessor for
both debian's arm-linux-gnueabihf-gcc and clang -mthumb

$ echo | arm-linux-gnueabihf-gcc -dM -E - | grep __thumb
#define __thumb2__ 1
#define __thumb__ 1
$ echo | arm-linux-gnueabihf-gcc -dM -E - -U__thumb2__ | grep __thumb
#define __thumb__ 1
$ echo | clang --target=arm-linux-gnueabihf -mthumb -dM -E -
-mcpu=cortex-a7 | grep __thumb
#define __thumb2__ 1
#define __thumb__ 1
$ echo | clang --target=arm-linux-gnueabihf -mthumb -dM -E -
-mcpu=cortex-a7 -U__thumb2__ | grep __thumb
#define __thumb__ 1

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/Makefile        | 2 +-
>  arch/arm/crypto/Makefile | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 4067f5169144..955b0362cdfb 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -132,7 +132,7 @@ AFLAGS_NOWARN       :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  CFLAGS_ISA     :=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> -AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
> +AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>  CFLAGS_ISA     +=-mthumb
>  else
>  CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index 971e74546fb1..13e62c7c25dc 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -53,7 +53,12 @@ $(obj)/%-core.S: $(src)/%-armv4.pl
>
>  clean-files += poly1305-core.S sha256-core.S sha512-core.S
>
> +aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
> +
> +AFLAGS_sha256-core.o += $(aflags-thumb2-y)
> +AFLAGS_sha512-core.o += $(aflags-thumb2-y)
> +
>  # massage the perlasm code a bit so we only get the NEON routine if we need it
>  poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
>  poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
> -AFLAGS_poly1305-core.o += $(poly1305-aflags-y)
> +AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)
>
> base-commit: 71a7507afbc3f27c346898f13ab9bfd918613c34
> --
> 2.39.0
>


-- 
Thanks,
~Nick Desaulniers
