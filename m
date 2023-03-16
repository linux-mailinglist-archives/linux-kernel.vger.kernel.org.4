Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E96BC337
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCPBSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:18:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6104A279;
        Wed, 15 Mar 2023 18:17:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so3776618pjt.2;
        Wed, 15 Mar 2023 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678929475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGop/tMt4q82DXV5wrVTM8PHD9eWr7G/KT9UlcjUMVo=;
        b=DD9gdmP2LeH2VaSi9faVtQEk7fY9dVW+8tElSxe1Kuje3n5KpNHujtBUcG9cr46VGE
         /53puLp5EIdq/Mo7zX9x/PogwlfKp7SD5np4+TrQVaLhHtW/eDdABqriallWtoIXGczl
         Elagozdi8tdg28fBTDY1R5AuLJZA7xgeeEtH0y06MBkCZ1NzRXlrJjEyQC6+MWHvqGRt
         SgPXfGJIcld2x8zyOQlBuwoZ9omh7qITkPxOEgwZMaU67TleT/8wetY0XFcqKR1p/sYr
         I6qPd3iLM8sLG5vnoZF7FgjCPT8CNQ54U/hni9fI4iVNVL+dLw5xzoPhko2foJNRWHUL
         wIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGop/tMt4q82DXV5wrVTM8PHD9eWr7G/KT9UlcjUMVo=;
        b=o517O2ytKOimHOLJ9yO8JQRMcCaIGcuB1QUZCOD/dJRL5JJvk3Uxol46K1fsztFKX+
         34jdg5Up/v8bzcWIFGVDFJa/tQQ7qTKD2l8bOk/Z6c3rYF9N6rVoOkBHYqRpuCF+7deq
         ahPL3UVBQALhVxrDRTxwTPKfZCYBHKOlOwj+Bqc8Qf0fBDYvJ/kHGyFucs68fnSJmnTb
         nlkL4terNDWXy0Woh46kt13CmTbZUzD4ld0Q/Y4iuqoy+Ac8Z7tRQkjSnP6dltLtSijV
         fp6sH7Wd0xqwLy1Vlje3NHaQYuZzuIZ0CiQ++qx+XxMNJzNp43512wIDTzgsseVlQYSn
         siQQ==
X-Gm-Message-State: AO0yUKW7A9xcF3xUp7FBum1XsYWYHebfs8A1jXHhieBpSWn+ZPuoUaFt
        Vzoupf9g4If/dKGsWtluoGKNHgHIpssKfP30W1o=
X-Google-Smtp-Source: AK7set+K+WpGt3Dq3azzO6ytGhf2QQY4fYEreqhVT9eSKKjxIAz/Wjevym9oEZgPEfPXkeE54WYuiLQVjXUi64Qa0U8=
X-Received: by 2002:a17:903:2289:b0:1a0:6000:7fce with SMTP id
 b9-20020a170903228900b001a060007fcemr707887plh.3.1678929475022; Wed, 15 Mar
 2023 18:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230314024449.50151-1-aford173@gmail.com> <DU0PR04MB9417C49457C9E60898E6A92188BE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAHCN7xK8DyRa-NbAnQrZdkU279kHZqXAB2WCH96HgsULxzVKRw@mail.gmail.com>
In-Reply-To: <CAHCN7xK8DyRa-NbAnQrZdkU279kHZqXAB2WCH96HgsULxzVKRw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 15 Mar 2023 20:17:43 -0500
Message-ID: <CAHCN7xJydz-3Wb6W-3nMxryWQQbN9benvoJXJ7yai9cttJi_Og@mail.gmail.com>
Subject: Re: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        richard.zhao@linaro.org, mturquette@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 6:13=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Mar 13, 2023 at 11:39=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrot=
e:
> >
> > > Subject: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
> > >
> > > By default the display pixel clock needs to be evenly divide down fro=
m
> > > 594MHz which rules out a significant number of resolution and refresh=
 rates.
> > > The current clock tree looks something like:
> > >
> > >  video_pll                594000000
> > >   video_pll_bypass        594000000
> > >    video_pll_out          594000000

It looks like video_pll_out ultimately defined as a mux clock and
according to clk-mux.c, "* rate - rate is only affected by parent
switching. No clk_set_rate support"  Since disp_pixel tries to pass
this to its parent, it makes sense that it stops here.

Since the clock rate is set by the parent, does it make sense to look
for CLK_SET_RATE_PARENT flag and call a function to set the parent
rate if the flag ist set?

It seems like this would be the simplest without having to re-define
what the clock type is, but lets us pass a flag and only mux's with
that type could request the parent to set the clock rate.  This should
let us drop the video_pll clock lower, have a better chance of
successfully getting the ideal frequency for the LCDIF to sync, and
allow for a larger list of resolutions and refresh rates due to the
fact they are no longer limited to being evenly diviisable from 594
MHz.

> > >     disp_pixel            148500000
> > >      disp_pixel_clk       148500000
> > >
> > > To enable CLK_SET_RATE_PARENT on disp_pixel, a helper function needs =
to
> > > be added called imx8m_clk_hw_composite_flags which can pass the
> > > additional flag to the clock controller. Letting disp_pixel set video=
_pll_out
> > > rate should actually lower the clock rates of video_pll_bypass and vi=
deo_pll
> > > as well, since those clocks are already configured to enable
> > > CLK_SET_RATE_PARENT.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > >
> > > This is an RFC, because even with this patch, the video_pll_out clock=
 does
> > > not drop to 148500000 like I would expect.  The video_pll clock is a
> > > fractional pll, so it should be able to generate a significant number=
 of
> > > optional clock frequencies to facilitate video.
> > [Peng Fan]
> >
> > Have you ever tried to directly set video pll out clk to the freq that =
you wanna?
>
> In the application I am using, I have the DSI connected to an HDMI
> bridge, so some resolutions and refresh rates work, as long as they
> are evenly divisible from 594000000.  I am testing a series that was
> recently submitted to enable DSI on the i.MX8M Mini and Nano.
>
> If I manually change the video_pll to different frequencies, I can get
> other resolutions and refresh rates to work, but it then breaks the
> ones that I had previously working.  NXP's downstream code [1] as a
> comment added code to the ADV7511 driver which filters out clocks that
> are not divisible from 594 to mask the issue. It's listed as a TODO,
> and I think the author is blaming the ADV7511 driver, but  from my
> experience it's from the LCDIF clock not being able to reach to the
> proper value.  I think fixing this would also fix NXP's TODO list as
> well.
>
> I had modified the MXSFB driver to set the video_pll in addition to
> setting the disp_plixel_clk and I was able to sync many different
> resolutions and refresh rates, but I was told [2] that the solution
> would be to fix the clock driver by setting the parent clock rate,
> which is how I got here.
>
> adam
>
> [1] - https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c#L80
> [2] - https://lore.kernel.org/linux-arm-kernel/20230313112937.GC7446@peng=
utronix.de/T/
>
> >
> > Regards,
> > Peng.
> >
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8m=
n.c
> > > index af256ade554f..a116cc40d7d0 100644
> > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > @@ -470,7 +470,7 @@ static int imx8mn_clocks_probe(struct
> > > platform_device *pdev)
> > >       hws[IMX8MN_CLK_DRAM_ALT] =3D
> > > imx8m_clk_hw_fw_managed_composite("dram_alt",
> > > imx8mn_dram_alt_sels, base + 0xa000);
> > >       hws[IMX8MN_CLK_DRAM_APB] =3D
> > > imx8m_clk_hw_fw_managed_composite_critical("dram_apb",
> > > imx8mn_dram_apb_sels, base + 0xa080);
> > >
> > > -     hws[IMX8MN_CLK_DISP_PIXEL] =3D
> > > imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base +
> > > 0xa500);
> > > +     hws[IMX8MN_CLK_DISP_PIXEL] =3D
> > > +imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels,
> > > base
> > > ++ 0xa500, CLK_SET_RATE_PARENT);
> > >       hws[IMX8MN_CLK_SAI2] =3D imx8m_clk_hw_composite("sai2",
> > > imx8mn_sai2_sels, base + 0xa600);
> > >       hws[IMX8MN_CLK_SAI3] =3D imx8m_clk_hw_composite("sai3",
> > > imx8mn_sai3_sels, base + 0xa680);
> > >       hws[IMX8MN_CLK_SAI5] =3D imx8m_clk_hw_composite("sai5",
> > > imx8mn_sai5_sels, base + 0xa780); diff --git a/drivers/clk/imx/clk.h
> > > b/drivers/clk/imx/clk.h index 689b3ad927c0..9977b512845b 100644
> > > --- a/drivers/clk/imx/clk.h
> > > +++ b/drivers/clk/imx/clk.h
> > > @@ -414,6 +414,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> > > char *name,
> > >       _imx8m_clk_hw_composite(name, parent_names, reg, \
> > >                       0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
> > >
> > > +#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags)
> > > \
> > > +     _imx8m_clk_hw_composite(name, parent_names, reg, \
> > > +                     0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
> > > +
> > >  #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
> > >       _imx8m_clk_hw_composite(name, parent_names, reg, \
> > >                       0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
> > > --
> > > 2.37.2
> >
