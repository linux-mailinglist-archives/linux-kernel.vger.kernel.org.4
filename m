Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0235BCE57
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiISOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:16:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE812BB25;
        Mon, 19 Sep 2022 07:16:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so64719525ejb.13;
        Mon, 19 Sep 2022 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y+seWPSdihtaeYelHOoxCkotqTYdGlAuh/OI3MsVQjk=;
        b=i9Eb3++++aZChqqy9ru2/301jtCWamMTrUqMcbXOEYv1KMwUt47gOwJmNl21W4z58s
         RkEnbltqdDM6qcv9K68HBlixwjRY5Y/WDPxyB2ItKgMp/VRnDylvzBCzrrDgYpqHX3M6
         RJQYLxZeFXN8O2qAyOEt8xob7tnMdgKcbAGutTxJhGFJG7EdicchSjxmIi6fwlIbcCYZ
         TbRHtw6zMfRX9doyS2z1K1CXDnPdbJTyuiqYVO29ffqQb/u8g+bHge3UHwM3g0om64+D
         A/3OP5Quy/mBq18ODFxRA1Mo5DuFyKL7tV016uCMJz2eq408sDqOG5uCLTgQdqkrlAU9
         MVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y+seWPSdihtaeYelHOoxCkotqTYdGlAuh/OI3MsVQjk=;
        b=B4ANvbr2dViU7qDBMZv7N4JHvFWYDGEKA6wGstTzDCCp1XVe5Sx69CmAbBQsupBg/W
         kd6sz3+R/dVNC4ozpKEGTgqlTizd1GXBLX3mg6rlIyact1eo52fGnuWhpF2PKRy9YnwA
         IdoRYnLMmitNBrvQrqdcLbxKb19k07jCCvINxh1Tzf8Xt9ZjvALcVEsOsO5Cx0emX7Np
         5ePY5X90eeV5MAtAqoiXpFBq9ErejND3zStFDeT9ShjYtSd+V/Zh/zKAYP0BorI794Tr
         bcVz0Z/bDMu+WQ+0caaYEeGbkJyCe5oPRTU9T/b3aD9r8IvQboSqIfrtQoOKf/RXlUXG
         dDIA==
X-Gm-Message-State: ACrzQf2e/Yy0up9TDkigaex6NHSHDLggPjuN+BwRXHMcjrWELRx2T1WL
        KXsSOZl6yWLZk4BD4G5/6DILGdICOpHX0BrsxXA=
X-Google-Smtp-Source: AMsMyM5wwD9eVNE5BaScNidkstEuZjxGO5SbwoSdsZxnswkpoEuAry3dgYGxGSXC1bm0s1WbDbX5VumgmvaZW9hUiQ4=
X-Received: by 2002:a17:907:3f93:b0:780:1b17:1160 with SMTP id
 hr19-20020a1709073f9300b007801b171160mr12960192ejc.196.1663596988325; Mon, 19
 Sep 2022 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com> <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 15:16:00 +0100
Message-ID: <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Mon, Sep 19, 2022 at 2:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > critical list
> >
> > Hi Biju,
> >
> > On Mon, Sep 19, 2022 at 2:35 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > > Subject: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > > > critical list
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2
> > is
> > > > specifically to check the operation of Cortex-M33 CPU on the
> > > > RZ/{G2L, G2LC, V2L} SoCs and we dont want to turn off the clocks
> > of
> > > > WDT2 if it isn't enabled by Cortex-A55.
> > > >
> > > > This patch is in preparation to disable WDT CH2 from the RZ/G2L
> > > > (alike
> > > > SoCs) DTS/I by default.
> > > >
> > > > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/renesas/r9a07g044-cpg.c
> > > > b/drivers/clk/renesas/r9a07g044-cpg.c
> > > > index 02a4fc41bb6e..cf9b1bd73792 100644
> > > > --- a/drivers/clk/renesas/r9a07g044-cpg.c
> > > > +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> > > > @@ -412,6 +412,8 @@ static const unsigned int
> > > > r9a07g044_crit_mod_clks[] __initconst = {
> > > >       MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
> > > >       MOD_CLK_BASE + R9A07G044_IA55_CLK,
> > > >       MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
> > > > +     MOD_CLK_BASE + R9A07G044_WDT2_PCLK,
> > > > +     MOD_CLK_BASE + R9A07G044_WDT2_CLK,
> > >
> > > Do we need to turn on this clock unnecessarily?
> > >
> > No, this is in preparation to disable WDT2 by default from RZ/G2L{C}
> > DTS/I.
>
> But that will make WDT2 device is not enabled, but unnecessarily the clk is on.
>
Agreed the clocks will be ON, but didnt we agree earlier for r9a07g043-cpg.c?

> Not sure, If we have any use case for wdt2 controlling from CA-55??
> If there is no use case, why can't we remove it from SoC dtsi and clock tables,
> that why we don't unnecessarily use this clock anymore??
>
I dont have a clear use case of using WDT ch2 when trying to use it
from CA-55 either.

Cheers,
Prabhakar
