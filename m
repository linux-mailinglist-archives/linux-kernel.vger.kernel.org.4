Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231055F3766
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJCU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJCU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:59:06 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC45F9F;
        Mon,  3 Oct 2022 13:59:05 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 293Kwl3T009931;
        Tue, 4 Oct 2022 05:58:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 293Kwl3T009931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664830728;
        bh=RC/HQoZVQsiiDGm0eyS4VWA/+STuHrQYuj8XzzJ6ogU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RZ+ZZ804mAiu3JQbd3WmH/Z+lJhVWzmjRo695ENMGvdtj6tamDkfDEZ/lOd6KCVk9
         5ivEFzuoeG4X96tBH0D4B5mjvRe2BdiX0xoy70ytCAcKpUY4ZwPJI7SEyk7kna/Zs3
         8lo1Wr2nD14audAqz+HxevOXYKH6rm6gOwhLvnFKx+S8GVFylGBznHSEOrFsBVFU/P
         WG2eT9zmQQ1zYj/pMCCKMGiuYJqPVC8AaFyLqrvC5xTAPfRhMglv2/YUhNXmohxsTZ
         e3eEMO+jJyr2hrQiKi18fAzTsnPCYAwOEbSpDguzSz3W2FSqJjYIxz7KhGtTp1PrOH
         +EE10vhEMcEIQ==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id l5so12525894oif.7;
        Mon, 03 Oct 2022 13:58:47 -0700 (PDT)
X-Gm-Message-State: ACrzQf0r+mWmrmgLISTDrP8suqtx7lTquMRGELrOtLVd2Z06zpcuqdf0
        OdC87L/5PKCxXVS8gwfJ2MAVoyOnDYYyzO2+48w=
X-Google-Smtp-Source: AMsMyM5TwlUagqv1pmzXxkFsakIli2RA0nYaBD1UVkK+3884vU/qJHggaXLzr4AxcQ+hony+WasgwrWjdziXcStbhIc=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr4797524oib.194.1664830726739; Mon, 03
 Oct 2022 13:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221002181107.51286-1-masahiroy@kernel.org> <20221002181107.51286-4-masahiroy@kernel.org>
 <YzsZzjjJFcPILOji@dev-arch.thelio-3990X>
In-Reply-To: <YzsZzjjJFcPILOji@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 4 Oct 2022 05:58:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLGZuJhPW5D6EQToQL3UWbgOCFX+-ztOpbuXSPg4otow@mail.gmail.com>
Message-ID: <CAK7LNAQLGZuJhPW5D6EQToQL3UWbgOCFX+-ztOpbuXSPg4otow@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kconfig.debug: split debug-level and DWARF-version
 into separate choices
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:20 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Oct 03, 2022 at 03:11:07AM +0900, Masahiro Yamada wrote:
> > Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
> > a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
> > but it should rather belong to the debug level choice.
> >
> > This commit consolidates CONFIG options into two choices:
> >
> >  - Debug info level (NONE / REDUCED / DEFAULT)
> >
> >  - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)
> >
> > This is more consistent with compilers' policy because the -g0 compiler
> > flag means "no debug info".
> >
> >   GCC manual:
> >
> >     -g<level>
> >
> >       Request debugging information and also use level to specify how
> >       much information. The default level is 2.
> >
> >       Level 0 produces no debug information at all. Thus, -g0 negates -=
g.
> >
> >       Level 1 produces minimal information, enough for making backtrace=
s
> >       in parts of the program that you don=E2=80=99t plan to debug. Thi=
s includes
> >       descriptions of functions and external variables, and line number
> >       tables, but no information about local variables.
> >
> >       Level 3 includes extra information, such as all the macro
> >       definitions present in the program. Some debuggers support macro
> >       expansion when you use -g3.
> >
> >   Rustc Codegen manual:
> >
> >     debuginfo
> >
> >       This flag controls the generation of debug information. It takes
> >       one of the following values:
> >
> >       0: no debug info at all (the default).
> >       1: line tables only.
> >       2: full debug info.
> >
> > I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.
> >
> > This change will make it easier to add another debug info level if
> > necessary.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> As far as I can tell, this will require updating defconfigs again to
> include an explicit 'CONFIG_DEBUG_INFO_DEFAULT=3Dy', right? It might be
> nice to do that as part of this change to keep everything working, as
> there was some fallout from the last time:
>
> 92f89ec1b534 ("powerpc: Restore CONFIG_DEBUG_INFO in defconfigs")
> ddd366bf01de ("ARM: defconfig: address renamed CONFIG_DEBUG_INFO=3Dy")
>
> Regardless, I think this is a good change.


Thanks.

I will do that in v2.









--=20
Best Regards
Masahiro Yamada
