Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1652C5F36CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJCT5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJCT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:57:36 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F1491F3;
        Mon,  3 Oct 2022 12:57:34 -0700 (PDT)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 293Jv77M013279;
        Tue, 4 Oct 2022 04:57:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 293Jv77M013279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664827028;
        bh=rfDWg500KpyWsspPqlZfTlWaAPRTsxHTFXFNMj2CpJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SxqwIC2z48Hfs7jjHgSKtDD2E9KuMsY4u66pDaCd43Wb9ID1KaGo39AiIUq550dh4
         zdErfOAGv/d8Qs7/YquNzzclgL0FhjA2qo5NPQyaD2smfPgWRR9Y4YqH5ixGAfrJZ8
         unN1v2na+mtJKc7Ks0xKz4myVlTMo4KS80KVdZXIx7g8F3Y4QBAllNS37g1jF6ETkj
         OLczdSozNZrLamJpA+v9HrbiLrTUTvrXIWgVq07r0eCPkCbVpuPLPiKUOf8TI/J46f
         dXQMsXsJp0Uw5WSnREPWfhHxFLp0AViVQGMF0Q/OJZ2tIo6ktQtTRxOtRP9uCy3cb7
         JgFAARXH6gEzw==
X-Nifty-SrcIP: [209.85.160.53]
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1321a1e94b3so8456422fac.1;
        Mon, 03 Oct 2022 12:57:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf0O4nIJoOeFGZNvjA+urX5vCX1wTU+SjKqjm7pfVP3iZ4nPCUT8
        +A9isiXhT8LNpmihx7pwcpRJrJNHnR9yv4/nJbQ=
X-Google-Smtp-Source: AMsMyM7lMzdXBL948OAVTq7cLkis+2F1ZkcYq4zedZ2wqpxW/zmbCJV27NfNVPuMoiFZl8/GpS05wG0i87u95KBzGHs=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr5970786oab.287.1664827026656; Mon, 03
 Oct 2022 12:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221002181107.51286-1-masahiroy@kernel.org> <20221002181107.51286-2-masahiroy@kernel.org>
 <CAKwvOdk9BxB03X6rm6J7orjR9Cou5NqNKe3D1x4nzxwZZNS6sg@mail.gmail.com>
In-Reply-To: <CAKwvOdk9BxB03X6rm6J7orjR9Cou5NqNKe3D1x4nzxwZZNS6sg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 4 Oct 2022 04:56:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2gSqwKEwXUQ2V7TsdkGiN3bNdCyEVfi7axsb3rAEWzg@mail.gmail.com>
Message-ID: <CAK7LNAT2gSqwKEwXUQ2V7TsdkGiN3bNdCyEVfi7axsb3rAEWzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Kconfig.debug: simplify the dependency of DEBUG_INFO_DWARF4/5
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Oct 4, 2022 at 1:53 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, Oct 2, 2022 at 11:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Commit c0a5c81ca9be ("Kconfig.debug: drop GCC 5+ version check for
> > DWARF5") could have cleaned up the code a bit deeper.
> >
> > "CC_IS_CLANG &&" is unneeded. No functional change is intended.
>
> This implies that there are only 2 compilers capable of building the
> kernel; consider also removing
> include/linux/compiler-intel.h
> if ICC is no longer supported.  Otherwise, what implications does this
> patch have for ICC?




I am just doing logical simplification in general.

When A and B are bool,

   !A || (A && B)

is always redundant.
It can be simplified into

   !A || B



So, this patch is irrelevant to the presence of the third compiler, ICC.

Such an implication happened in commit c0a5c81ca9be.
When you dropped GCC 5+ check, you converted
"GCC_VERSION >= 50000" into "!CC_IS_CLANG" instead of "CC_IS_GCC".


"CC_IS_GCC" and "!CC_IS_CLANG" are not equivalent,
but a lot of code already expects that, and nobody asked
"We have the third compiler, so do we need CC_IS_ICC?"



I agree that we can drop ICC support, but I want to
point out that ICC is DON'T_CARE to my patch.








> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  lib/Kconfig.debug | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d3e5f36bb01e..f4b2165f24db 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -264,7 +264,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >  config DEBUG_INFO_DWARF4
> >         bool "Generate DWARF Version 4 debuginfo"
> >         select DEBUG_INFO
> > -       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> > +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> >         help
> >           Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
> >           if using clang without clang's integrated assembler, and gdb 7.0+.
> > @@ -276,7 +276,7 @@ config DEBUG_INFO_DWARF4
> >  config DEBUG_INFO_DWARF5
> >         bool "Generate DWARF Version 5 debuginfo"
> >         select DEBUG_INFO
> > -       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> > +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> >         help
> >           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> >           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
