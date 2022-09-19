Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97535BCA01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiISKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiISKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D22248CF;
        Mon, 19 Sep 2022 03:48:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e17so40660153edc.5;
        Mon, 19 Sep 2022 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CsFt6MwJzYyojAv74ZywZ9D5RojQyfFyTqoFfftRzqw=;
        b=WnM1MSlOgwxDX9RvPYAJ6SqkZ24z70JL5z7oKCrqbjo5arxXsT/gEsYLfWz6yEoHi2
         ku59b/7xMChUjU+J8xlK5UzMtvFiDkc1BNFRI95PFndtI/K9d/RVSiu1VwcyF4We89IT
         sRS/RwPoA/wIQODrGivxfYeAlnPzBSsnJKyhQsVWCNBU0MUXVZCE2Y/HMxFPQxLaQk/+
         iRjlRkG1bzFdVzSGj8TeTmjfcKQ3mXxWnzcgLrW3Cxpgqq85QBgO/G46apMQJAb94KMm
         bWJHLT4TZsw/Y5uIhz5hSu3f57iBXwrxEL/JRYN8T0AtzWrfL3jYPmeuvIsdsLe8hR8a
         la+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CsFt6MwJzYyojAv74ZywZ9D5RojQyfFyTqoFfftRzqw=;
        b=dKvgIEzqzr3IJngc2ytS4crEuVZh+ifEj9ef/3Y9Z3ChPzZwJIGJax9p80wlYKNmGK
         QapcVLaXcxdDM71obuU8u+JdtDwUL/5OGLHjlZCYjrOX7b3SrXkVQK95V2gdPUg7kx4m
         PVR9yzmDodOQktu+zokTMa0c6SMLtFB7f/kuwKdv4q+yEnnb8wlgRWNX1aMfRrcFb6s+
         2J8UVYgLDpTzjt+ppcWAUdSeGYq6HuuvNz2IfXM67KX5ZHAuU6DY1tpALw8G/ccgPADV
         6Xed/4uk51st4AUQ6oaTnGdeo6TqO+f/mBWQy6JXmfizv9QXNz/lR0zwsp7m05maeyUq
         7MgQ==
X-Gm-Message-State: ACrzQf0q+IWuuYbmsnBI0y+QV95WkIctZrBb0LxwcF20VKzvggqxxzPS
        PS5oSgK0tjD0pYMHJXutA4oAhPjCeVRb+ikjZlg=
X-Google-Smtp-Source: AMsMyM4lvTuwPTnFpWGSM17pu/uQ47vWtTqVM5lCy6T8f9cKrynkjYcTyEd0Z6oZUjD+L0JYggvlfxjEHfox8eksB7U=
X-Received: by 2002:a05:6402:f11:b0:44f:e1ff:801a with SMTP id
 i17-20020a0564020f1100b0044fe1ff801amr15221680eda.109.1663584499475; Mon, 19
 Sep 2022 03:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com>
 <CA+V-a8tbO2okH3oku+15nrd+KRdGoFQ8WRck5sAMuGhV9WcHpA@mail.gmail.com> <CAMuHMdVeDLSbea4pYJoajQXg0RroGeNuQcS6sBbU--GnmNu0aw@mail.gmail.com>
In-Reply-To: <CAMuHMdVeDLSbea4pYJoajQXg0RroGeNuQcS6sBbU--GnmNu0aw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 11:47:52 +0100
Message-ID: <CA+V-a8sq4x+3KTctwNU_tG0AdkB2UNiPgg6pXaecy76vL-xSQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Kconfig: Drop selecting SOC_BUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Sep 19, 2022 at 10:49 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Sep 19, 2022 at 11:46 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Sun, Sep 18, 2022 at 10:32 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 16, 2022 at 1:39 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Don't automatically select the SOC_BUS config option as we already have
> > > > automatically selected it as part of the SOC_RENESAS config option [0]
> > > > as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.
> > > >
> > > > [0] drivers/soc/renesas/Kconfig
> > > > [1] drivers/soc/renesas/renesas-soc.c
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > i.e. will queue in renesas-devel for v6.1.
> > >
> > > > --- a/arch/arm/mach-shmobile/Kconfig
> > > > +++ b/arch/arm/mach-shmobile/Kconfig
> > > > @@ -6,5 +6,4 @@ menuconfig ARCH_RENESAS
> > > >         select GPIOLIB
> > > >         select NO_IOPORT_MAP
> > > >         select PINCTRL
> > > > -       select SOC_BUS
> > > >         select ZONE_DMA if ARM_LPAE
> > >
> > > Nice catch!
> > > I guess it would make sense to move the GPIOLIB and PINCTRL selects
> > > to drivers/soc/renesas/Kconfig, too, as they are needed for all
> > > (arm32/arm64/riscv) Renesas SoCs?
> > >
> > Agreed, shall I move them under SOC_RENESAS?
>
> That's the place I had in mind ;-)
>
Done, I have sent it out.

Cheers,
Prabhakar
