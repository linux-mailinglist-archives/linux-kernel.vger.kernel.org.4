Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD15E8704
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiIXBfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiIXBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:35:50 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B0A1D7C;
        Fri, 23 Sep 2022 18:35:48 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28O1ZLxJ030264;
        Sat, 24 Sep 2022 10:35:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28O1ZLxJ030264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663983322;
        bh=/eLm7kKAZKPCAlDhAPCPjGLOw0pwSMAx5ayENfiXi90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z3W5UjEM36Hd+teTYWabSF73H+Epg+dz36is+jLAPjj8t18qdKsxShsG57qr0TQvO
         7VLhRx+FKaYdnVYti01RvqXyQ9kEOP0LKP5YgPSjmXcf+5QN3oFeFMHD0DS4pSgND0
         SrxKIi7LF2yMqMvhd9nC0uzb4evLY8TmuoQsT8YaYBOqHz1g1Msf66qPvglqF4XFIy
         jsl5oi5hLeUaval+kt6QGWO4LkSfg1UIeOntbV4U2qojgUH0w8TgvV3GGk0rt5zKf2
         yz6O+Vh7H3bbIMtlRkOE+Ga708O/SWCz/bNk39Tav5XDtt+4Mw8WIo5zhFPqvsgLAo
         2ZWffF4NmyC3A==
X-Nifty-SrcIP: [209.85.160.51]
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127ba06d03fso2534363fac.3;
        Fri, 23 Sep 2022 18:35:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Zqr01O4v7M7TjePnxsWKM5nVPTtzD80YVC8kJnke5uQnZLZYz
        osJMbJrTfR/xwwPGc3GOfyf6D+zpGp/DP1g/yoI=
X-Google-Smtp-Source: AMsMyM7jDHG6fhLgJft9ukvYkQPpcaymaIhsRbZ8UWBkTjR00kGt1uhvttwYCbOEb54mnP9okRPMqipDdmwDGit90Zc=
X-Received: by 2002:a05:6870:3103:b0:12d:5b7b:e6f2 with SMTP id
 v3-20020a056870310300b0012d5b7be6f2mr12103882oaa.194.1663983320733; Fri, 23
 Sep 2022 18:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919173030.3726922-1-ndesaulniers@google.com>
In-Reply-To: <20220919173030.3726922-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Sep 2022 10:34:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST8aBoJMx5aRgxkTv1iht37GWTzHZMbzGzPFKJKkD8PQ@mail.gmail.com>
Message-ID: <CAK7LNAST8aBoJMx5aRgxkTv1iht37GWTzHZMbzGzPFKJKkD8PQ@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Andi Kleen <ak@linux.intel.com>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
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

On Tue, Sep 20, 2022 at 2:30 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Dmitrii, Fangrui, and Mashahiro note:
>
>   Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2.
>
> Fix CONFIG_DEBUG_INFO_SPLIT for gcc-11+ & clang-12+ which now need -g
> specified in order for -gsplit-dwarf to work at all.
>
> -gsplit-dwarf has been mutually exclusive with -g since support for
> CONFIG_DEBUG_INFO_SPLIT was introduced in
> commit 866ced950bcd ("kbuild: Support split debug info v4")
> I don't think it ever needed to be.
>
> Link: https://lore.kernel.org/lkml/20220815013317.26121-1-dmitrii.bundin.a@gmail.com/
> Link: https://lore.kernel.org/lkml/CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com/
> Link: https://reviews.llvm.org/D80391
> Cc: Andi Kleen <ak@linux.intel.com>
> Reported-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reported-by: Fangrui Song <maskray@google.com>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---


Applied to linux-kbuild/fixes.
Thanks.



> Changes v3 -> v4:
> * Split into its own patch; we don't have any out of line assembler
>   files using .debug_* or .cfi_* directives that would produce
>   meaningful debug info in .dwo files.
>
>  scripts/Makefile.debug | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..26d6a9d97a20 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -1,9 +1,7 @@
> -DEBUG_CFLAGS   :=
> +DEBUG_CFLAGS   := -g
>
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
> -else
> -DEBUG_CFLAGS   += -g
>  endif
>
>  ifndef CONFIG_AS_IS_LLVM
> --
> 2.37.3.968.ga6b4b080e4-goog
>


-- 
Best Regards
Masahiro Yamada
