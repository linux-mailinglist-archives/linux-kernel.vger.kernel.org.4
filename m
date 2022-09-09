Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF555B2EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIIG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIIG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:29:45 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792F625C4B;
        Thu,  8 Sep 2022 23:29:40 -0700 (PDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-04.nifty.com with ESMTP id 2896NOpK024120;
        Fri, 9 Sep 2022 15:23:24 +0900
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2896N4Kd026323;
        Fri, 9 Sep 2022 15:23:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2896N4Kd026323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662704586;
        bh=EC6SilsAEK+rN2ggVzG9YNR83SYMtw1PO6ELBTyPU4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z4Iq+sGOHFUbQ0/UZ6nR1ateoXI8KCtspaH8rRWbxDnsNZ6RR/Gt1hExbWQp+fZIk
         qP/FNEda9rCf+QN7lYnqQn2H65WYwXoQJEUn/llRp7+WEhcI9U7MPsr7tA6uiNnunc
         /BE4TrWOH+Pql+oAsPouunJxvcDbA3r1sKe9FcEW5qFPGl2h1LM5rByLAGBhT/lJUr
         cDIYNDy5EmpyyY2mwvHUWZ583ylgzx36N4FuM/+Dit/tcyOWnxlqS66/KYjsjkB01B
         GQ2rsEzHFQutLYgpP9O+8WuCsoYcxVSiPWP2nKpw+LO5O7J30JphjDaPss0zVPkXF6
         Kp7aYsgIqHcyQ==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1280590722dso1563920fac.1;
        Thu, 08 Sep 2022 23:23:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ALP6yWJODm0PjJTELDrwfddYnW9q51u8e6euEqzO6jK82wHli
        9+5sJtyqInUGW1DM74Evxm/OTCwPJxh6TIANNI4=
X-Google-Smtp-Source: AA6agR5a/cn+4VBwsjDFuBjbsWZjwFhx8Xc7NsZw3AX0v4JSYVi3ygeFmt+aOgwOeAX//6OdlS2RMFM5DWeHTCkgSnY=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr3919876oab.287.1662704584434; Thu, 08
 Sep 2022 23:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-5-lukas.bulwahn@gmail.com> <YxnTI927V0hGs+kz@kroah.com>
In-Reply-To: <YxnTI927V0hGs+kz@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:22:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmtfdHE3tmT58sLzS+hvQjNPADWnZE=SiOKRkJPjBq5A@mail.gmail.com>
Message-ID: <CAK7LNAQmtfdHE3tmT58sLzS+hvQjNPADWnZE=SiOKRkJPjBq5A@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: chipidea: make configs for glue drivers visible
 with EXPERT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        linux-usb <linux-usb@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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

On Thu, Sep 8, 2022 at 8:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 08, 2022 at 12:43:35PM +0200, Lukas Bulwahn wrote:
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
> > Considering the first purpose, at the point in time where CONFIG_EMBEDDED
> > was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
> > become visible throughout all different menus for the kernel configuration.
> > Over the last decade, this has gradually increased, so that currently, with
> > CONFIG_EXPERT, roughly 170 more options become visible throughout all
> > different menus for the kernel configuration. In comparison, currently with
> > CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
> > one in arm, and five for the ChipIdea Highspeed Dual Role Controller.
> >
> > As the numbers suggest, these two levels of enabling the visibility of even
> > more configuration options---beyond what CONFIG_EXPERT enables---never
> > evolved to a good solution in the last decade. In other words, this
> > additional level of visibility of configuration option with CONFIG_EMBEDDED
> > compared to CONFIG_EXPERT has since its introduction never become really
> > valuable. It requires quite some investigation to actually understand what
> > is additionally visible and it does not differ significantly in complexity
> > compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
> > other config to show more detailed options beyond CONFIG_EXPERT---is
> > unlikely to be valuable unless somebody puts significant effort in
> > identifying how such visibility options can be properly split and creating
> > clear criteria, when some config option is visible with CONFIG_EXPERT and
> > when some config option is visible only with some further option enabled
> > beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, it
> > is much more reasonable to simply make those additional seven options that
> > visible with CONFIG_EMBEDDED, visible with CONFIG_EXPERT, and then remove
> > CONFIG_EMBEDDED. If anyone spends significant effort in structuring the
> > visibility of config options, they may re-introduce suitable new config
> > options simply as they see fit.
> >
> > Make the configs for usb chipidea glue drivers visible when CONFIG_EXPERT
> > is enabled.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  drivers/usb/chipidea/Kconfig | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Now queued up in my USB tree, thanks.
>
> greg k-h


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

-- 
Best Regards
Masahiro Yamada
