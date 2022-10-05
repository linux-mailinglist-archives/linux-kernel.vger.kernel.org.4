Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9E5F54CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJEM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJEM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:56:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82645D13F;
        Wed,  5 Oct 2022 05:56:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so18507310ejw.12;
        Wed, 05 Oct 2022 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3hRHxdqHIje5FknTJ5KEacsVN7WFRHzy8hAOq67mToA=;
        b=RcvnrdSbxx7KFIR23+Xu5+IWBgvpRzBfeSBnL323zeMkA5PMr6EaMth8eGRHm2AQlI
         50mgbAGAiEvnifvIPdoxWlJuGUj1AxhufP7YZX/qhAuF5LpfPgvyoGK/vtlB+INTksl9
         dkEJhxR+smdS39b2nNyz89DQimi9pG9sPD9vyhp49JnQyS/J230WJtK7XL1ZLAU3OPsV
         Ve+bDgVtPvEsk+zWc1QYG1eFkmkJFncTEMFplRnyWFCDv5Eo7Aja6oTs1iGPRxog+3hE
         MJuD37nMbidVFyDGigr3l9JcxJW1UEXgOroBTMgmfATIWCLOFs1vAYSx3n+nT+k/6G0m
         VUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3hRHxdqHIje5FknTJ5KEacsVN7WFRHzy8hAOq67mToA=;
        b=RQJsg9gb/r3aebuO81dkeq390rx4UuH+hLQHifJ3LaiZIxNzM0c62IdgnQdbgAm+1O
         jz7+XsDRGMwJZRboGLQ11feYJKwuSqh0J/1qzHnC0GQpcwaa56Q8kPsrmPHLn+ZNoH3I
         E8iZYvQWp3lcvjPz1lmDKFIBEroz4paRf9vmNUs1jpW06LO66n6pR0UrZF1XEuaQ86IU
         Ln1TkLcWAXc94krVqtvzZlNnMsp8agIldqj+4Nm7HZ7Zgu4AwTikuPkDFxQUbw+d1hTo
         e84FhYz+F4/eJFlmzuSP2SB6TkcjzU8UTuk5CcOC5dEHEAgBvJkAJrk3izp96aYsSOdW
         yKXg==
X-Gm-Message-State: ACrzQf2WlXPosIXWZm+lHogDUjMIzW76nkWFLDJxxHnw6B6W9XXbQWlb
        tgbE1q9zZoKSpwcbN+zfNmjG5VBVtE9VT4FFW3E=
X-Google-Smtp-Source: AMsMyM4fEebU5vXdmoNhZeqjJsBt6nkb3ptyPHHOAGQaiSjg1CAHVnsDSqSdjhgnhHWf4VY7PXiZjQOX12cHmq/1W0o=
X-Received: by 2002:a17:907:2c41:b0:77d:8aed:cf7c with SMTP id
 hf1-20020a1709072c4100b0077d8aedcf7cmr23405273ejc.447.1664974609274; Wed, 05
 Oct 2022 05:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
 <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
 <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922DAA91FFD18FD52FEC916865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922DAA91FFD18FD52FEC916865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Oct 2022 13:56:22 +0100
Message-ID: <CA+V-a8uNhM92ezEX3iCcP2zp3Er9EPDy1Z-4L3gQfe=xU8O1bw@mail.gmail.com>
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

On Wed, Oct 5, 2022 at 9:27 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Geert and Prabhakar,
>
> > Subject: RE: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > critical list
> >
> > Hi Prabhakar,
> >
> > > Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > > critical list
> > >
> > > Hi Biju,
> > >
> > > On Mon, Sep 19, 2022 at 2:52 PM Biju Das
> > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > > Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > > > > critical list
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Mon, Sep 19, 2022 at 2:35 PM Biju Das
> > > > > <biju.das.jz@bp.renesas.com>
> > > > > wrote:
> > > > > >
> > > > > > Hi Prabhakar,
> > > > > >
> > > > > > > Subject: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to
> > > > > > > critical list
> > > > > > >
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT
> > > CH2
> > > > > is
> > > > > > > specifically to check the operation of Cortex-M33 CPU on the
> > > > > > > RZ/{G2L, G2LC, V2L} SoCs and we dont want to turn off the
> > > clocks
> > > > > of
> > > > > > > WDT2 if it isn't enabled by Cortex-A55.
> > > > > > >
> > > > > > > This patch is in preparation to disable WDT CH2 from the
> > > RZ/G2L
> > > > > > > (alike
> > > > > > > SoCs) DTS/I by default.
> > > > > > >
> > > > > > > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > Signed-off-by: Lad Prabhakar
> > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > ---
> > > > > > >  drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/clk/renesas/r9a07g044-cpg.c
> > > > > > > b/drivers/clk/renesas/r9a07g044-cpg.c
> > > > > > > index 02a4fc41bb6e..cf9b1bd73792 100644
> > > > > > > --- a/drivers/clk/renesas/r9a07g044-cpg.c
> > > > > > > +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> > > > > > > @@ -412,6 +412,8 @@ static const unsigned int
> > > > > > > r9a07g044_crit_mod_clks[] __initconst = {
> > > > > > >       MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
> > > > > > >       MOD_CLK_BASE + R9A07G044_IA55_CLK,
> > > > > > >       MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
> > > > > > > +     MOD_CLK_BASE + R9A07G044_WDT2_PCLK,
> > > > > > > +     MOD_CLK_BASE + R9A07G044_WDT2_CLK,
> > > > > >
> > > > > > Do we need to turn on this clock unnecessarily?
> > > > > >
> > > > > No, this is in preparation to disable WDT2 by default from
> > > RZ/G2L{C}
> > > > > DTS/I.
> > > >
> > > > But that will make WDT2 device is not enabled, but unnecessarily
> > the
> > > clk is on.
> > > >
> > > Agreed the clocks will be ON, but didnt we agree earlier for
> > > r9a07g043-cpg.c?
> >
> > Yep, still we have a chance to conclude, whether we need to make this
> > clk always on, if it is not enabled and there is no use case for wdt2
> > controlling from CA-55??
> >
>
> I got confirmation that that using WDT2 from CA55 is prohibited.
> WDT2 is only for CM33.
>
> With CPG register, we can select whether CM33 to trigger CM33 cpu reset, or trigger system reset
> when WDT2 overflows.
>
> If WDT2 is used by CA55, it may result in unexpected behaviour.
>
Thanks.

> So we may need to take WDT2 entries from binding + dtsi + clock table??
>
> Or
>
> Added it to critical clock list, to avoid changes in binding + dtsi + clock table
> at the expense of turning on the WDT2 clk unnecessarily.
>
I'm in favour of option#1 except that we keep WDT2 entries in binding.
Said that I'll leave Geert to decide on this.

Cheers,
Prabhakar
