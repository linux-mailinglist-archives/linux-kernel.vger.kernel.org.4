Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC56B9152
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCNLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCNLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:14:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A87A9E;
        Tue, 14 Mar 2023 04:14:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so20002088pjb.3;
        Tue, 14 Mar 2023 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678792449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mgq4Gb4nShxf6TmYlZiPVcRLWKemqujm5F/88PcXx0=;
        b=jwI6NyZ0sHbAv2SfupII60ISsAxcvwhbvvEgvI+TmfW1RSRtVcPPGiTr8xfzMdaTCC
         o1ZCosT4jfzfZpRY/1sr2SM8g8T1BNYzKPOe1mpGqXYz6DOuFKOP1vEMtCtBzCkxyHFk
         2FXqD+wPzojonD/YljZRMMHFPZCl9vINZfBT0VeMinSpkjpCMLF4r6OxX1XFarJV4GGj
         ZkMpEocFDRf4Fc8MlHShnbWrruhn7U5FXVigquyiKjRkNXyRUUvG4+QWfI4/6fyoT8tu
         TIt05b+4QU1tEw6hm6nEY/7SIZLbmK8o/WPRoFzZ07MtlD+tYW6lb8/GNi5awont9yZb
         g9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mgq4Gb4nShxf6TmYlZiPVcRLWKemqujm5F/88PcXx0=;
        b=kdTG0EB/Q34miyJQOttOdJPVw4e1Da2WzCAiWEEFfr2kKMkbQTtzqT+V4+ukC94QkC
         TTGH5skPneiC9lCkggwqnxJoLBVPWkq3yeAOIWzHBHXG0tfl+fX5v6yNKnozmPO4tcZ8
         prvXimys70LRc8QAqFh8urA3wcyt3K0KqL/4/ZhTbxJv/7v0vSR61W6NKLiJNvF2y/o1
         sQV9jqqhwgTNWVQSNMDE4cJTEoY/2b+B0L+YvIOPYT4LhS8S14Gl+4JVv7hsOYFSsgbh
         xZ1H9FQduoXdktVF3R4E8Rj19d73K0I5xtBidc1HkZEhyiyRm9VJjhHZqb1Pa5UUqsXC
         Aikg==
X-Gm-Message-State: AO0yUKXxJDMxzdKe6kd0nH7nZsvVAye3wt4eRDhEyqUR8464HeCv1TAt
        ltZGo2T7OVjcKmGctPIC3HPOOM3HqFPDIoro+hk=
X-Google-Smtp-Source: AK7set9HY2xm2VayZK7HhUQVDsETGJKyT3ZFyHR/3YD/mhiNHc3TesK1jlt6LDa+ywQeB0bNBKQs8ZLdMhxgF1pdIRg=
X-Received: by 2002:a17:902:fa8f:b0:1a0:5057:1b81 with SMTP id
 lc15-20020a170902fa8f00b001a050571b81mr2230680plb.3.1678792449416; Tue, 14
 Mar 2023 04:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230314024449.50151-1-aford173@gmail.com> <DU0PR04MB9417C49457C9E60898E6A92188BE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417C49457C9E60898E6A92188BE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 14 Mar 2023 06:13:57 -0500
Message-ID: <CAHCN7xK8DyRa-NbAnQrZdkU279kHZqXAB2WCH96HgsULxzVKRw@mail.gmail.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Mar 13, 2023 at 11:39=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
> >
> > By default the display pixel clock needs to be evenly divide down from
> > 594MHz which rules out a significant number of resolution and refresh r=
ates.
> > The current clock tree looks something like:
> >
> >  video_pll                594000000
> >   video_pll_bypass        594000000
> >    video_pll_out          594000000
> >     disp_pixel            148500000
> >      disp_pixel_clk       148500000
> >
> > To enable CLK_SET_RATE_PARENT on disp_pixel, a helper function needs to
> > be added called imx8m_clk_hw_composite_flags which can pass the
> > additional flag to the clock controller. Letting disp_pixel set video_p=
ll_out
> > rate should actually lower the clock rates of video_pll_bypass and vide=
o_pll
> > as well, since those clocks are already configured to enable
> > CLK_SET_RATE_PARENT.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >
> > This is an RFC, because even with this patch, the video_pll_out clock d=
oes
> > not drop to 148500000 like I would expect.  The video_pll clock is a
> > fractional pll, so it should be able to generate a significant number o=
f
> > optional clock frequencies to facilitate video.
> [Peng Fan]
>
> Have you ever tried to directly set video pll out clk to the freq that yo=
u wanna?

In the application I am using, I have the DSI connected to an HDMI
bridge, so some resolutions and refresh rates work, as long as they
are evenly divisible from 594000000.  I am testing a series that was
recently submitted to enable DSI on the i.MX8M Mini and Nano.

If I manually change the video_pll to different frequencies, I can get
other resolutions and refresh rates to work, but it then breaks the
ones that I had previously working.  NXP's downstream code [1] as a
comment added code to the ADV7511 driver which filters out clocks that
are not divisible from 594 to mask the issue. It's listed as a TODO,
and I think the author is blaming the ADV7511 driver, but  from my
experience it's from the LCDIF clock not being able to reach to the
proper value.  I think fixing this would also fix NXP's TODO list as
well.

I had modified the MXSFB driver to set the video_pll in addition to
setting the disp_plixel_clk and I was able to sync many different
resolutions and refresh rates, but I was told [2] that the solution
would be to fix the clock driver by setting the parent clock rate,
which is how I got here.

adam

[1] - https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/gpu/drm/b=
ridge/adv7511/adv7511_drv.c#L80
[2] - https://lore.kernel.org/linux-arm-kernel/20230313112937.GC7446@pengut=
ronix.de/T/

>
> Regards,
> Peng.
>
> >
> > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.=
c
> > index af256ade554f..a116cc40d7d0 100644
> > --- a/drivers/clk/imx/clk-imx8mn.c
> > +++ b/drivers/clk/imx/clk-imx8mn.c
> > @@ -470,7 +470,7 @@ static int imx8mn_clocks_probe(struct
> > platform_device *pdev)
> >       hws[IMX8MN_CLK_DRAM_ALT] =3D
> > imx8m_clk_hw_fw_managed_composite("dram_alt",
> > imx8mn_dram_alt_sels, base + 0xa000);
> >       hws[IMX8MN_CLK_DRAM_APB] =3D
> > imx8m_clk_hw_fw_managed_composite_critical("dram_apb",
> > imx8mn_dram_apb_sels, base + 0xa080);
> >
> > -     hws[IMX8MN_CLK_DISP_PIXEL] =3D
> > imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base +
> > 0xa500);
> > +     hws[IMX8MN_CLK_DISP_PIXEL] =3D
> > +imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels,
> > base
> > ++ 0xa500, CLK_SET_RATE_PARENT);
> >       hws[IMX8MN_CLK_SAI2] =3D imx8m_clk_hw_composite("sai2",
> > imx8mn_sai2_sels, base + 0xa600);
> >       hws[IMX8MN_CLK_SAI3] =3D imx8m_clk_hw_composite("sai3",
> > imx8mn_sai3_sels, base + 0xa680);
> >       hws[IMX8MN_CLK_SAI5] =3D imx8m_clk_hw_composite("sai5",
> > imx8mn_sai5_sels, base + 0xa780); diff --git a/drivers/clk/imx/clk.h
> > b/drivers/clk/imx/clk.h index 689b3ad927c0..9977b512845b 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -414,6 +414,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> > char *name,
> >       _imx8m_clk_hw_composite(name, parent_names, reg, \
> >                       0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
> >
> > +#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags)
> > \
> > +     _imx8m_clk_hw_composite(name, parent_names, reg, \
> > +                     0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
> > +
> >  #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
> >       _imx8m_clk_hw_composite(name, parent_names, reg, \
> >                       0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
> > --
> > 2.37.2
>
