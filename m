Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5285FC9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJLRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJLRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:03:23 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EE13F91;
        Wed, 12 Oct 2022 10:03:20 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29CH30iU014538;
        Thu, 13 Oct 2022 02:03:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29CH30iU014538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665594181;
        bh=dYL++UgevmgJ7yY8bIaXHYj6+6J5/LR2yQL53Eybgzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6WSMEBnQBTL8TYXQwpZT4KEs+J2f+2mlS307sZRJ+dkkZMA89/pDpPso59+8OLOU
         a6CCrxzcjKr9RqpcLSGEs/YTxKuh+8ARD/dx8H0C5CnWmLL+Ndaxm4rX0BIE4NvHeZ
         5xxtb/u5L1LHQbYRB6TA05agDPVaWPbFmNYKA0SYjdgKuaw15EEVfgGbHdT/jqZYGS
         ynK0Elp77EdX83cl6dH0ruBvsVE8pcH5GBcTI25Z4KftrT0v7qmoMb93gq/Ps+AILP
         PVSz59F6mW6zSMOIiExnutS6BISE+oMILgGD6JkQxiGPRAPy6TcZSyhBg6x2b4rt+o
         x9o33HLKZnA2g==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12c8312131fso20152677fac.4;
        Wed, 12 Oct 2022 10:03:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf1IWX5zPNikTH6c4GcZ/Y27HLL7NDNFUiiL+rgCJgGuwlgB21SA
        w1voladd4NapPRZu5qW7cdL7d4aFB8bf0mMNDZg=
X-Google-Smtp-Source: AMsMyM48Te47KEoasVl33NErmSr2tgtVZMWYZ6J7vHLT54THsardOvzATmyS/KHr7uacA8Phlro4+7J+ONa0ssYHB1I=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr2926974oab.287.1665594180123; Wed, 12
 Oct 2022 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221004162905.24997-1-masahiroy@kernel.org>
In-Reply-To: <20221004162905.24997-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Oct 2022 02:02:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASe=r228HoLw7QRkd27v7Q+DPEGvrQf=XgXbe_-NVTEKg@mail.gmail.com>
Message-ID: <CAK7LNASe=r228HoLw7QRkd27v7Q+DPEGvrQf=XgXbe_-NVTEKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Kconfig.debug: simplify the dependency of DEBUG_INFO_DWARF4/5
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit c0a5c81ca9be ("Kconfig.debug: drop GCC 5+ version check for
> DWARF5") could have cleaned up the code a bit more.
>
> "CC_IS_CLANG &&" is unneeded. No functional change is intended.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to linux-kbuild.



>
> (no changes since v1)
>
>  lib/Kconfig.debug | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d3e5f36bb01e..f4b2165f24db 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -264,7 +264,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  config DEBUG_INFO_DWARF4
>         bool "Generate DWARF Version 4 debuginfo"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>         help
>           Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
>           if using clang without clang's integrated assembler, and gdb 7.0+.
> @@ -276,7 +276,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
>           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
