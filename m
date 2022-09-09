Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA105B2EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiIIG3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIIG26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:28:58 -0400
X-Greylist: delayed 100 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 23:28:57 PDT
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D912ACD9;
        Thu,  8 Sep 2022 23:28:56 -0700 (PDT)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-07.nifty.com with ESMTP id 2896NZ7G010861;
        Fri, 9 Sep 2022 15:23:35 +0900
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2896NJ2b016840;
        Fri, 9 Sep 2022 15:23:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2896NJ2b016840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704600;
        bh=M8RU77rFPgb9iCDZlcgmp1AIsNWV2fZAChJbFjqGEXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z9ef8H04q8ejPMDdTZVr2QgANUJssDpWr44P8Mqs6YSyAgIK/FjPofKCpmo9coGPW
         UztnJvygPDhKFnFQ7TjuZJb17kQ4OgKsqc2iGGfJPdUa6kiAjIVQI70gQrYhzRBqnZ
         j8o3SHCjh1eNQWEVlDKeU1Z5kGq6rvdE1caB6Q9DcucNDrvoVBDQ3afvZ64llg1+ZX
         Tp50MfrCK62W2PAZInSRCuQZ8+OK2DZYcNmX4bmyHr1VGuvTCxQIMb9Lbxpb76TZmt
         WIsjVDjdNYYF/LyJWnlQUgHnK+FzjA2gwHEXeFC88qEz78AeYwZIVq24kOnU6uWMzs
         e8+sL5U3ME5RA==
X-Nifty-SrcIP: [209.85.160.42]
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1225219ee46so1556100fac.2;
        Thu, 08 Sep 2022 23:23:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo1Xuq79pN+VlE0AGlko35nGnLZEEM7oPJ/T8rZlhIEVlN4xRp/t
        PbbJq3v1I6thI6vt8Zts09y07wtwvwVchu194w4=
X-Google-Smtp-Source: AA6agR6TkF3ZCXHdyUVvKfeexJcA6/iUO15vrP/nUMylWe8sfgvSiu+88R6kp9AHz26LHLW2L4i7YtsZ/0OFNLM4DXc=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr3955805oab.194.1662704599250; Thu, 08
 Sep 2022 23:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-6-lukas.bulwahn@gmail.com> <YxnQ3+0BfbmUbBnH@linux.ibm.com>
In-Reply-To: <YxnQ3+0BfbmUbBnH@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:22:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_u_BkcQ4A34ENdSy=J9KOpgzHS6NSXkGBiVy_7CqPFQ@mail.gmail.com>
Message-ID: <CAK7LNAS_u_BkcQ4A34ENdSy=J9KOpgzHS6NSXkGBiVy_7CqPFQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: Kconfig: make config SECRETMEM visible with EXPERT
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 8:24 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Sep 08, 2022 at 12:43:36PM +0200, Lukas Bulwahn wrote:
> > Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> > introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> > and just gives that intent a much better name. That has been clearly a good
> > and long overdue renaming, and it is clearly an improvement to the kernel
> > build configuration that has shown to help managing the kernel build
> > configuration in the last decade.
> >
> > However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
> > this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
> > open for future contributors to implement that intended semantics:
> >
> >     A new CONFIG_EMBEDDED option is added that automatically selects
> >     CONFIG_EXPERT when enabled and can be used in the future to isolate
> >     options that should only be considered for embedded systems (RISC
> >     architectures, SLOB, etc).
> >
> > Since then, this CONFIG_EMBEDDED implicitly had two purposes:
> >
> >   - It can make even more options visible beyond what CONFIG_EXPERT makes
> >     visible. In other words, it may introduce another level of enabling the
> >     visibility of configuration options: always visible, visible with
> >     CONFIG_EXPERT and visible with CONFIG_EMBEDDED.
> >
> >   - Set certain default values of some configurations differently,
> >     following the assumption that configuring a kernel build for an
> >     embedded system generally starts with a different set of default values
> >     compared to kernel builds for all other kind of systems.
> >
> > Considering the second purpose, note that already probably arguing that a
> > kernel build for an embedded system would choose some values differently is
> > already tricky: the set of embedded systems with Linux kernels is already
> > quite diverse. Many embedded system have powerful CPUs and it would not be
> > clear that all embedded systems just optimize towards one specific aspect,
> > e.g., a smaller kernel image size. So, it is unclear if starting with "one
> > set of default configuration" that is induced by CONFIG_EMBEDDED is a good
> > offer for developers configuring their kernels.
> >
> > Also, the differences of needed user-space features in an embedded system
> > compared to a non-embedded system are probably difficult or even impossible
> > to name in some generic way.
> >
> > So it is not surprising that in the last decade hardly anyone has
> > contributed changes to make something default differently in case of
> > CONFIG_EMBEDDED=y.
> >
> > Currently, in v6.0-rc4, SECRETMEM is the only config switched off if
> > CONFIG_EMBEDDED=y.
> >
> > As long as that is actually the only option that currently is selected or
> > deselected, it is better to just make SECRETMEM configurable at build time
> > by experts using menuconfig instead.
> >
> > Make SECRETMEM configurable when EXPERT is set and otherwise default to
> > yes. Further, SECRETMEM needs ARCH_HAS_SET_DIRECT_MAP.
> >
> > This allows us to remove CONFIG_EMBEDDED in the close future.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>
> > ---
> >  mm/Kconfig | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ceec438c0741..aa154c20b129 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1068,7 +1068,13 @@ config IO_MAPPING
> >       bool
> >
> >  config SECRETMEM
> > -     def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> > +     default y
> > +     bool "Enable memfd_secret() system call" if EXPERT
> > +     depends on ARCH_HAS_SET_DIRECT_MAP
> > +     help
> > +       Enable the memfd_secret() system call with the ability to create
> > +       memory areas visible only in the context of the owning process and
> > +       not mapped to other processes and other kernel page tables.
> >
> >  config ANON_VMA_NAME
> >       bool "Anonymous VMA name support"
> > --
> > 2.17.1
> >
>
> --
> Sincerely yours,
> Mike.

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

-- 
Best Regards
Masahiro Yamada
