Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A660D87A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiJZAd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJZAdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:33:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BDBE09F7;
        Tue, 25 Oct 2022 17:33:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so17125685ejc.12;
        Tue, 25 Oct 2022 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4aaWjS4eNJQCSflTPbOyiWS6X5z8XgwuVIyZ0zSHeyw=;
        b=SHvn6WzuKVF3LpTc/NiE0K7REkU1D+t31ewuYJJDe9vO/IGeR++UK4sJcY4JVfs9P9
         4tn09MZgZ3umnJxr4I+8KrPkdfBjzNlProITgLufKqnsbp3aQXbC6NCLogOHJwEaxxpe
         F0uTxKwYT/9nv3v/A7EnOX3iUNOz1GTG1WkEckuAy9wjtbw6hTYgTF7EmnEoh0LtbDra
         HtVOmE4LVAhvpzeT/16Q6YbPl7I0uMDCskC+koYA7ExOwxG5iseAxtKwolV0o1bWHMx2
         1KVMFGreiyq9AWLWBaAX2FabnXniRUVJ4LX4Tu9gMNf7bnBVox+SZbflXSSzaODyJqbN
         MYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aaWjS4eNJQCSflTPbOyiWS6X5z8XgwuVIyZ0zSHeyw=;
        b=Aaff+Hr30eXlESwQUUTC/gPJj1Y5Hx6g/JxIlgsbj1Zn53oYNUTMKnQI6CVq7kectC
         R5SU+6EzD4RpJsKRMfuQ5I7llNBEfg5pOX2FkhECb54W0lZ3CVIVZOO2+MToFsEO84Pk
         7tXMRCAsHu4GOljRxtGiYzTLabEZbGus32yWL0zW+R4ZZPFMuGDpOI9xktVBedEn04U4
         CWdWpEY/3V1vmBvMQuLGj+YSF8YzSvrZOj+xIpe5MBxs9vUbxr7AiJoRd73s9LAvQKzE
         Z69vQKeNpDv51S82Z6DxmdcVPvVDrRg2XF9DA4GbRjj5SbwXtbsyUBbwRWMSPJ5frbdK
         lB8Q==
X-Gm-Message-State: ACrzQf29EMM+3e3U+NSYc2J2jWGpmuwj/D/vd0MZEWqnaIengahmEuqz
        CII4KVchsTSL+d+aE0N95dZizpWj+YtUEcMcZOrN3dYVCHk=
X-Google-Smtp-Source: AMsMyM41fHmvE/tw4iklmaAb+tsqtyxfNYyQRmCSC3l1Ydpw8H0fd4O6opPaTD2iDYsaKwcpryWF6XN0IFp4SXx9s9g=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr29985809ejc.447.1666744431536; Tue, 25
 Oct 2022 17:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220929185119.335273-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXR+Nsyd0EkNeBvUOpm+qPNUDMZedfY0wErESi5x2Z9JA@mail.gmail.com>
In-Reply-To: <CAMuHMdXR+Nsyd0EkNeBvUOpm+qPNUDMZedfY0wErESi5x2Z9JA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 01:33:24 +0100
Message-ID: <CA+V-a8ujJR-Ca4QRgiosPfaEmscFKERHySUL9xpzr794x5EzmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks
 support PM
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Thank you for the review.

On Tue, Oct 25, 2022 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 29, 2022 at 8:51 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > There are cases where not all CPG_MOD clocks should be assumed to support
> > PM. For example on the CRU block there is a particular sequence that needs
> > to be followed to initialize the CSI-2 D-PHY in which individual clocks
> > need to be turned ON/OFF, due to which Runtime PM support wasn't used by
> > the CRU CSI-2 driver.
> >
> > This patch adds support to allow indicating if PM is supported by the
> > CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets the no_pm
> > flag in struct rzg2l_mod_clk and when the driver uses Runtime PM support
> > no_pm flag is checked to see if the clk needs to included as part of
> > Runtime PM.
> >
> > CPG_MOD clocks with no_pm flag set need to be individually turned ON/OFF
> > depending on the requirement of the driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC->v1
> > * Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
> >   struct rzg2l_cpg_priv
>
> Thanks for your patch!
>
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -108,12 +108,16 @@ struct rzg2l_cpg_priv {
> >         unsigned int num_mod_clks;
> >         unsigned int num_resets;
> >         unsigned int last_dt_core_clk;
> > +       int *no_pm_mod_clks;
> > +       unsigned int num_no_pm_mod_clks;
> >
> >         const struct rzg2l_cpg_info *info;
> >
> >         struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
> >  };
> >
> > +static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
>
> I think you can do without this, by moving the currently separately
> allocated struct generic_pm_domain into struct rzg2l_cpg_priv,
> and using container_of() on the currently unused pointer passed to
> rzg2l_cpg_attach_dev().
>
Agreed.

> Note to self: get rid of the cpg_mssr_clk_domain static pointer in
> the CPG/MSSR driver.
>
> > +
> >  static void rzg2l_cpg_del_clk_provider(void *data)
> >  {
> >         of_clk_del_provider(data);
> > @@ -1225,16 +1229,24 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
> >
> >  static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
> >  {
> > +       struct rzg2l_cpg_priv *priv = rzg2l_cpg_priv;
> > +       const struct rzg2l_cpg_info *info = priv->info;
>
> info is used only once, expand user below?
>
With the below change suggested info will be used more than once
(3-times), so I'll keep it.

> > +       unsigned int id;
> > +       unsigned int i;
> > +
> >         if (clkspec->args_count != 2)
> >                 return false;
> >
> > -       switch (clkspec->args[0]) {
> > -       case CPG_MOD:
> > -               return true;
> > -
> > -       default:
> > +       if (clkspec->args[0] != CPG_MOD)
> >                 return false;
> > +
> > +       id = clkspec->args[1] + info->num_total_core_clks;
> > +       for (i = 0; i < priv->num_no_pm_mod_clks; i++) {
> > +               if (priv->no_pm_mod_clks[i] == id)
> > +                       return false;
> >         }
> > +
> > +       return true;
> >  }
> >
> >  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
>
> > @@ -1366,8 +1379,26 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
> >         for (i = 0; i < info->num_core_clks; i++)
> >                 rzg2l_cpg_register_core_clk(&info->core_clks[i], info, priv);
> >
> > -       for (i = 0; i < info->num_mod_clks; i++)
> > +       priv->num_no_pm_mod_clks = 0;
> > +       for (i = 0; i < info->num_mod_clks; i++) {
> > +               if (info->mod_clks[i].no_pm)
> > +                       priv->num_no_pm_mod_clks++;
> > +       }
> > +
> > +       if (priv->num_no_pm_mod_clks && info->num_mod_clks) {
> > +               priv->no_pm_mod_clks =
> > +                               devm_kmalloc_array(dev, priv->num_no_pm_mod_clks,
> > +                                                  sizeof(info->mod_clks[0].id),
> > +                                                  GFP_KERNEL);
> > +               if (!priv->no_pm_mod_clks)
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       for (i = 0, j = 0; i < info->num_mod_clks; i++) {
> > +               if (info->mod_clks[i].no_pm)
> > +                       priv->no_pm_mod_clks[j++] = info->mod_clks[i].id;
> >                 rzg2l_cpg_register_mod_clk(&info->mod_clks[i], info, priv);
> > +       }
>
> Alternatively, you could have a separate rzg2l_cpg_info.no_pm_clks[]
> array, like .crit_mod_clks[], and do the counting etc. at compile-time.
>
Agreed.

Cheers,
Prabhakar
