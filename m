Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9249062EF20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiKRIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiKRIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E3391CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5946229F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6949C43146
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668759828;
        bh=RbDbFSd/O/kkuqAwCEYXS++FCu2lD+vL0uZz/en/z8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EnX4MQzpFvSowZDbAhP6YdzD0ibzg1FApy3ULvM6l66peZGFdNYNKywPlHv0ddmi5
         mbg8MJM06F7X6Zac3ojju6iaNVw7Lzc8q9gpG4p3vLKMHzTIpQuNJHGQPly+HLyMrl
         PBYDjHMyl04yRNwxhujP325+7pI0JzCU6CGXw8ZPPFhUEf0/T1snMZH2EB0h/gYGgj
         aHpfmyWYh23Isr1bnZFDWDERAEULddEoaueEeRQQ6oGfzjdpRLiaMgRW4C3pVcMDPZ
         H03Qgm2r/icLf0CERvh+Y/Y0qotS2p37toRuB91ERqi85MSVaReKO/4QEirDnscS8c
         E65QwfWiZvOiA==
Received: by mail-ed1-f53.google.com with SMTP id x102so6184796ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:23:48 -0800 (PST)
X-Gm-Message-State: ANoB5pm2XsFt/1BhTqwGuSuoLXKutAOLMEmQZRowslTyO0XdhVCwn8ZX
        bWY8LuNJmFbAPeUkk9O/tLIHFeA+USeU+DBF2sg=
X-Google-Smtp-Source: AA0mqf4cDIGpzBF2DuuXidU/Q5w0FiW7QZgD7Xl9Sj3h1v21L3KMXYs7xFzxNSjcbImx7/ok00xbbSmTAs8YvzC5zgg=
X-Received: by 2002:a05:6402:3785:b0:461:e598:e0bb with SMTP id
 et5-20020a056402378500b00461e598e0bbmr5362428edb.21.1668759826917; Fri, 18
 Nov 2022 00:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221118003057.3223394-1-nathan@kernel.org>
In-Reply-To: <20221118003057.3223394-1-nathan@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Nov 2022 09:23:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHgAZeG9ntSQnuV7Ta+-b9__=Z2y2x0+u3LnSRbJR_FNw@mail.gmail.com>
Message-ID: <CAMj1kXHgAZeG9ntSQnuV7Ta+-b9__=Z2y2x0+u3LnSRbJR_FNw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Drop '-mthumb' from AFLAGS_ISA
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 01:34, Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with CONFIG_THUMB2_KERNEL=y + a version of clang from
> Debian using CROSS_COMPILE=arm-linux-gnueabihf-, the following warning
> occurs frequently:
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
>
> In a similar vein as commit 26b12e084bce ("ARM: 9264/1: only use
> -mtp=cp15 for the compiler"), do not add '-mthumb' to AFLAGS_ISA, as it
> is already passed to the assembler via '-Wa,-mthumb' and '__thumb2__' is
> already defined for preprocessing.
>
> Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
> Link: https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/raw/622dbcbd40b316ed3905a2d25d9623544a06e6b1/debian/patches/930008-arm.diff
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v2:
>   * Add Nick's review and test tags.
>   * Call out explicitly that CROSS_COMPILE=arm-linux-gnueabihf- is
>     needed to reproduce this issue in commit message (Nick).
>   * Fix dead link in commit message (Nick).
>   * Use the snapshot branch for the patch link, as the diff is more up
>     to date against upstream LLVM (Nick).
> v1: https://lore.kernel.org/20221114225719.1657174-1-nathan@kernel.org/
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
