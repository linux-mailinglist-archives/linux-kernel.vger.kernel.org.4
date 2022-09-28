Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C25ED94B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiI1Jjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiI1JjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:39:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D7BE0C;
        Wed, 28 Sep 2022 02:38:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lh5so25902537ejb.10;
        Wed, 28 Sep 2022 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OT0UcdOVZ704hYlagMhzUyfbs4FTvkhpxGQx0JqAZVg=;
        b=Amo0nva+2NirO5XNM7Mh8M1C0lByyvs3TLnlTE6m8unl9MZXLg8LAAePUQ/mq0njZf
         v27aULO9LTMmjbnG5+6UdudTNeqLV2yn5zx62MQBga0IfwRCy+kMygguzMfRyYpki4DA
         iaCO+V13upRTIzzut+bHeWMV/twmw7m2pJEp3TGj1t1mrAAWy/uF/jVDzNuqsgQCpiJY
         EiQHoKWaQmaA02tW707mar54U9LqfsXp0S8CijQvZMom4mgwvXJrp66GAHGCKqXgEHhu
         8zPfOQMnDXiJ+rUjVy1w7eFAidHYGD0h6dfRLODEnAdYLPHXl7TxTA20WdHpu1Wgo8Pt
         RbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OT0UcdOVZ704hYlagMhzUyfbs4FTvkhpxGQx0JqAZVg=;
        b=6D0//1awDyo3Mn5R6+cwAQKkUUSLy59B6N3brJ6T6/J5VYN77ychW4kgf67f/ZQJSw
         pNOYMoxs9pWNstWnaVpSLRe0wcdBhuYqw7JijrCBxYKlf52EsgEXCT5h1tJu0sfMzQGg
         +rJuBSr2dmlI8cSprkvvIJzAkb1PpF54e7wUQGaJhuxnDW6MHs8HQPAY+ewBV1jTshPY
         u3PMBUxFL9/fjVPuUROzd6uPKHblnAbJDtMH+0+lZ+8hG4cgz2xq1zB6t5a/MVcdtTW7
         TVKh0UdyUew9S2WVlV5kGeWIfKzXI0TRTsrQlklxRMi4sr2lVZdHmfHY7DCzqoyfqxq/
         kZgQ==
X-Gm-Message-State: ACrzQf2keUopb3iuURaAJwpBqDSAYGB9prIs7MorYblguQdbJN5nDbAF
        Q3Ox21gLCzegyr2ZZ9vei0j9/7z46CVmMyf63YM=
X-Google-Smtp-Source: AMsMyM5ZFzPjaekB01bh45DERBxAag+jwxS3Hff6nq9M7pi6wfq9zYdBVZ8bpfsy3yrqyCQ6xOU3MKiTaKlA1cV9Qdc=
X-Received: by 2002:a17:907:60c7:b0:783:4fe0:dad0 with SMTP id
 hv7-20020a17090760c700b007834fe0dad0mr14511726ejc.342.1664357888173; Wed, 28
 Sep 2022 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922BE73295E3562DC3FBA6E86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s=wqGpfWBv7+=tG1pu6fZCL7EtRoTEmo-wjK5CGZyLnQ@mail.gmail.com> <OS0PR01MB5922D5A259A77D22ED91E87286549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D5A259A77D22ED91E87286549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Sep 2022 10:37:41 +0100
Message-ID: <CA+V-a8sPQn4eNQ_RhPgxnbJ1L7S-v5SORDMsRrPOmPu93evLaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
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

On Wed, Sep 28, 2022 at 9:42 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> > Subject: Re: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all
> > CPG_MOD clocks support PM
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Wed, Sep 28, 2022 at 8:02 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > > Subject: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all
> > > > CPG_MOD clocks support PM
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > There are cases where not all CPG_MOD clocks should be assumed to
> > > > support PM. For example on the CRU block there is a particular
> > > > sequence that needs to be followed to initialize the CSI-2 D-PHY
> > in
> > > > which individual clocks need to be turned ON/OFF, due to which
> > > > Runtime PM support wasn't used by the CRU CSI-2 driver.
> > > >
> > > > This patch adds support to allow indicating if PM is supported by
> > > > the CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets
> > > > the no_pm flag in struct rzg2l_mod_clk and when the driver uses
> > > > Runtime PM support no_pm flag is checked to see if the clk needs
> > to
> > > > included as part of Runtime PM.
> > > >
> > > > CPG_MOD clocks with no_pm flag set need to be individually turned
> > > > ON/OFF depending on the requirement of the driver.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/clk/renesas/rzg2l-cpg.c | 35
> > > > +++++++++++++++++++++++++++++---
> > > > -  drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++++---
> > > >  2 files changed, 40 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > > > b/drivers/clk/renesas/rzg2l-cpg.c index 3ff6ecd61756..d275324909e7
> > > > 100644
> > > > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > > > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > > > @@ -114,6 +114,8 @@ struct rzg2l_cpg_priv {
> > > >       struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;  };
> > > >
> > > > +static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
> > > > +
> > > >  static void rzg2l_cpg_del_clk_provider(void *data)  {
> > > >       of_clk_del_provider(data);
> > > > @@ -1223,18 +1225,42 @@ static int
> > > > rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
> > > >       return devm_reset_controller_register(priv->dev,
> > > > &priv->rcdev); }
> > > >
> > > > +static inline const struct rzg2l_mod_clk *rzg2l_get_mod_clk(const
> > > > +struct rzg2l_cpg_info *info, int id) {
> > > > +     unsigned int i;
> > > > +
> > > > +     id += info->num_total_core_clks;
> > > > +     for (i = 0; i < info->num_mod_clks; i++) {
> > > > +             if (info->mod_clks[i].id == id)
> > > > +                     return &info->mod_clks[i];
> > > > +     }
> > >
> > > May be as an optimization add ID and clk to a separate list and
> > > traverse that smaller list for DEF_NO_PM case.
> > >
> > > case CPG_MOD:
> > >         return rzg2l_cpg_is_pm_mod(clkspec->args[1]);
> > >
> > Are you suggesting adding no_pm_mod_clks and no_pm_mod_clks or
> > building an internal structure in struct rzg2l_cpg_priv while calling
> > rzg2l_cpg_register_mod_clk() for each mod clock?
>
> Later one. To have a smaller list of no_pm_mod_clks while registering as MOD
> Clocks and later add PM clocks will check for the matching clock ID and
> excludes it.
>
Agreed.

Cheers,
Prabhakar
