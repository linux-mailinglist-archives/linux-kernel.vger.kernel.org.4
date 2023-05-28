Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3471378F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 05:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1Dbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Dbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 23:31:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96290C7;
        Sat, 27 May 2023 20:31:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae763f9c0bso14607765ad.2;
        Sat, 27 May 2023 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685244693; x=1687836693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hBuvyZ7EBqdYU4iAk4lEaxieNGNBcEc+yeHvMinBFM=;
        b=UkDNJY5WAPy4ZZxuHN2RFaIHIKD2XQ1cX14DmFKIVD4dC4PTrosSQeO/hXea4EQns8
         l9Rr7uFSrlRrfz7Z65s6lOTJeKFSNvzTXnp+KHb1CahRxffEeXNpQgEbMB5YDwEXzGfo
         tgwZY8vYMgOHljgRUUQxmrFpE9ngkDmF897lBdXe8b3h+MKb+DmDL/DHda02PMgK9k/4
         RnE/h1sjTwe4DotVveQ2osun4HeGnGMo6PIgq22ikfMYSoaEacyHRHId7l0JRVIjwNT6
         6lS0McFXmQbuRmxop5mMlQTDMGMbCF8NWDuT5I9cPtgzpkoMwmd8R++5985yJiB4PSki
         n75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685244693; x=1687836693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hBuvyZ7EBqdYU4iAk4lEaxieNGNBcEc+yeHvMinBFM=;
        b=bNWv1LpleYzJrqXsmrBek6mufV3XAFmipmDN/uQ5J92jddZNoLZngtwpw9Zj1uh4lh
         aKc/OM4s18+z3dYAu3FXuNv8Ix9zKtGgP4xkaM6jQlPaop0QO0BaphiXEIIAk6RLgOiw
         TskhrGtxTBrpiXhZYUZayjOYAkB2skQOKNFrCdunf0qLQBelLVg9iOhurpPixsUl6OlC
         rQaetM4FjwAt80A76xJyS4wG97C+yPlJvtB1LD1U5gi29hvg1nlOvP8m0CNVFLL91JBB
         LQllI0Tn/lnd+1taVBJ+f2aLjWCUsuUpaKvqAGfrtDF+aP/FHfAw6A2eCevo4YPhrNxF
         RxOA==
X-Gm-Message-State: AC+VfDwQJ3JNZngQVS5M1NgiJmdnKUWvsTwUtYZaD0RRCswOnzkgNtfk
        v9olCskcKNa31jFytYkLvh9vvkmLxYs61Qj98Og=
X-Google-Smtp-Source: ACHHUZ4dbKp82EtIQsuPmla6IBhLoZHwe7fqdkZkWoqmLJqEVoC1DSozw66kEghoWZuTypbeXEZBrMaz2JwvCIwrZ5U=
X-Received: by 2002:a17:902:d4c8:b0:1ac:528c:e71 with SMTP id
 o8-20020a170902d4c800b001ac528c0e71mr10187133plg.18.1685244692756; Sat, 27
 May 2023 20:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com> <02e4e072-a2bb-8455-304d-49552ce9c866@oss.nxp.com>
 <CAHCN7x+pFM7_yAWxVaUCKyLQ1A_5-F4sQ_t2k2iug7DdD9PwmQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+pFM7_yAWxVaUCKyLQ1A_5-F4sQ_t2k2iug7DdD9PwmQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 27 May 2023 22:31:21 -0500
Message-ID: <CAHCN7xJY6ayQAGqzK58qVd=owGMLMU5U5zia3zwhaK0aR2iKwQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:23=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Mon, May 22, 2023 at 9:33=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> w=
rote:
> >
> >
> >
> > On 5/7/2023 3:53 AM, Adam Ford wrote:
> > > Caution: This is an external email. Please take care when clicking li=
nks or opening attachments. When in doubt, report the message using the 'Re=
port this email' button
> > >
> > >
> > > Currently, certain clocks are derrived as a divider from their
> > > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > > is set, the parent clock is not properly set which can lead
> > > to some relatively inaccurate clock values.
> > >
> > > Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> > > cannot rely on calling a standard determine_rate function,
> > > because the 8m composite clocks have a pre-divider and
> > > post-divider. Because of this, a custom determine_rate
> > > function is necessary to determine the maximum clock
> > > division which is equivalent to pre-divider * the
> > > post-divider.
> > >
> > > With this added, the system can attempt to adjust the parent rate
> > > when the proper flags are set which can lead to a more precise clock
> > > value.
> > >
> > > On the imx8mplus, no clock changes are present.
> > > On the Mini and Nano, this can help achieve more accurate
> > > lcdif clocks. When trying to get a pixel clock of 31.500MHz
> > > on an imx8m Nano, the clocks divided the 594MHz down, but
> > > left the parent rate untouched which caused a calulation error.
> >
> > Not all clocks has pre/post div both.

Peng,

Any suggestions on how to identify this?  looking at the code that
sets the clock rates, it seemed to me like the code was mostly common
code and it looked like the pre and post div's were basically the
same.  CAn you point me to an example where they're identified with
different values?
> >
> > If CLK_SET_RATE_PARENT not set, would there be any issues for
> > other clocks?
>
> I did a dump of the clk_summary for Mini, Nano and Plus, and I found
> no changes to any clock other than the video_pll, and most of the
> clocks do not have CLK_SET_RATE_PARENT set, so from what I could tell
> it seemed harmless.

What do you need from me to be able to move this forward?

thanks

adam
>
> >
> > Regards,
> > Peng.
> >
> > >
> > > Before:
> > > video_pll              594000000
> > >    video_pll_bypass     594000000
> > >      video_pll_out      594000000
> > >        disp_pixel       31263158
> > >          disp_pixel_clk 31263158
> > >
> > > Variance =3D -236842 Hz
> > >
> > > After this patch:
> > > video_pll               31500000
> > >    video_pll_bypass      31500000
> > >      video_pll_out       31500000
> > >        disp_pixel        31500000
> > >          disp_pixel_clk  31500000
> > >
> > > Variance =3D 0 Hz
> > >
> > > All other clocks rates and parent were the same.
> > > Similar results on imx8mm were found.
> > >
> > > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to =
determine_rate"")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V2:  Fix build warning found by build bot and fix prediv_value
> > >       and div_value because the values stored are the divisor - 1,
> > >       so we need to add 1 to the values to be correct.
> > >
> > > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk=
-composite-8m.c
> > > index cbf0d7955a00..7a6e3ce97133 100644
> > > --- a/drivers/clk/imx/clk-composite-8m.c
> > > +++ b/drivers/clk/imx/clk-composite-8m.c
> > > @@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate=
(struct clk_hw *hw,
> > >          return ret;
> > >   }
> > >
> > > +static int imx8m_divider_determine_rate(struct clk_hw *hw,
> > > +                                     struct clk_rate_request *req)
> > > +{
> > > +       struct clk_divider *divider =3D to_clk_divider(hw);
> > > +       int prediv_value;
> > > +       int div_value;
> > > +
> > > +       /* if read only, just return current value */
> > > +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> > > +               u32 val;
> > > +
> > > +               val =3D readl(divider->reg);
> > > +               prediv_value =3D val >> divider->shift;
> > > +               prediv_value &=3D clk_div_mask(divider->width);
> > > +               prediv_value++;
> > > +
> > > +               div_value =3D val >> PCG_DIV_SHIFT;
> > > +               div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
> > > +               div_value++;
> > > +
> > > +               return divider_ro_determine_rate(hw, req, divider->ta=
ble,
> > > +                                                PCG_PREDIV_WIDTH + P=
CG_DIV_WIDTH,
> > > +                                                divider->flags, pred=
iv_value * div_value);
> > > +       }
> > > +
> > > +       return divider_determine_rate(hw, req, divider->table,
> > > +                                     PCG_PREDIV_WIDTH + PCG_DIV_WIDT=
H,
> > > +                                     divider->flags);
> > > +}
> > > +
> > >   static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
> > >          .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> > >          .round_rate =3D imx8m_clk_composite_divider_round_rate,
> > >          .set_rate =3D imx8m_clk_composite_divider_set_rate,
> > > +       .determine_rate =3D imx8m_divider_determine_rate,
> > >   };
> > >
> > >   static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> > > --
> > > 2.39.2
> > >
