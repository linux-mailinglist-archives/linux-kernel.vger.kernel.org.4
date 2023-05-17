Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5EE70677E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjEQMFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEQMEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:04:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756BC61AF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:01:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae4e49727eso8180185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684324894; x=1686916894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wJlwiloE3+nuW0LYCKoJcJcNbRRwPyYMQz34VEuBFQ=;
        b=RmEZapjncbG2NP8yCl8Qvuz02FmKf8muzRax7BZ92EpQKLC45BVjZZWGJE/cCf9fuO
         bbEau2jh0cLF6DsE9dBEUV73tt3lbSNQs+IeP6o5UY+psQybrQm4PkLpawDoQCQXKspj
         GSi258UPxWTQFIA7k4D/mV+OW/9dGGhBwpQirfb5ERW9EC520nlJelOHqQGe12chIibP
         BD4iIEARovjKkhSk03DTa6xk1si04gksv5DKNKIFX19e+PgT57PBaOej1xSY1uOrCTGe
         xhdGvHDAtBiuh16IHmOzRXKJUUqUPZU/aBUB3MJMtoJOdLiietQVlnPrQoX9L8avi+Ys
         gbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684324894; x=1686916894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wJlwiloE3+nuW0LYCKoJcJcNbRRwPyYMQz34VEuBFQ=;
        b=W/khY5n4mvoc4iLdxs18HAtmYEfLgK7gTeT4e/4f9D/CFygO9trFNxLzNAmlO54Oie
         M2wgvCOHzW4yyH+BDk+bx8iQ6CXb0adgDYfX9BKNmnc+94ojkFAghL3nIGM0sDY5Gi1U
         M5C+QoYUyxhGwk/9UBDMBCbNA2l3Y17P+3hHSl824uwT9acbUDxWPYwFrncCCc6+0sSW
         q5HswqWeXTa/vTo7PUW9HtYhaZuw48WgHm+tUEHC79TzQpguJyu8ttO3ejBfPvfy9jsx
         79wQB12brlUyiQUOTOQuT6HBqhR/D2Gwv6LKs1d8ir8S3PAhVTxiMj4ltOO0eITsJ8O6
         584Q==
X-Gm-Message-State: AC+VfDyKC40EnJEoThysWpRvbezkgc3SuWGyu6Q+k6i6eiXuCzKnp6sN
        9DjIL9no9SEzNr+Ist2nUx5iELYCynCGxu3mhdo=
X-Google-Smtp-Source: ACHHUZ5lPCu45/B8CsJwcgOCY5JaFUExLqa7pVvwbXQIdiE8dHeAgtF/07djnfyJsgkYN1TrK8phyGX0i7g+E9iwHIk=
X-Received: by 2002:a17:902:b08d:b0:1ad:e099:fc04 with SMTP id
 p13-20020a170902b08d00b001ade099fc04mr18083254plr.38.1684324893729; Wed, 17
 May 2023 05:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-6-aford173@gmail.com>
 <CAMty3ZBk-Zg-RFZv1Owo5aE9C8VpFXq45nLE-mBVSc=2o=iq4w@mail.gmail.com>
In-Reply-To: <CAMty3ZBk-Zg-RFZv1Owo5aE9C8VpFXq45nLE-mBVSc=2o=iq4w@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 17 May 2023 07:01:22 -0500
Message-ID: <CAHCN7xKHvJeTVvxRr5SB94sKvN1rX8Sg=NLRnMG0ngUUdJ=3AA@mail.gmail.com>
Subject: Re: [PATCH V6 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
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

On Wed, May 17, 2023 at 6:28=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > The DPHY timings are currently hard coded. Since the input
> > clock can be variable, the phy timings need to be variable
> > too.  To facilitate this, we need to cache the hs_clock
> > based on what is generated from the PLL.
> >
> > The phy_mipi_dphy_get_default_config_for_hsclk function
> > configures the DPHY timings in pico-seconds, and a small macro
> > converts those timings into clock cycles based on the hs_clk.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Tested-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 57 +++++++++++++++++++++++----
> >  include/drm/bridge/samsung-dsim.h     |  1 +
> >  2 files changed, 51 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 08266303c261..3944b7cfbbdf 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -218,6 +218,8 @@
> >
> >  #define OLD_SCLK_MIPI_CLK_NAME         "pll_clk"
> >
> > +#define PS_TO_CYCLE(ps, hz) DIV64_U64_ROUND_CLOSEST(((ps) * (hz)), 100=
0000000000ULL)
> > +
> >  static const char *const clk_names[5] =3D {
> >         "bus_clk",
> >         "sclk_mipi",
> > @@ -651,6 +653,8 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
> >                 reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
> >         } while ((reg & DSIM_PLL_STABLE) =3D=3D 0);
> >
> > +       dsi->hs_clock =3D fout;
> > +
> >         return fout;
> >  }
> >
> > @@ -698,13 +702,46 @@ static void samsung_dsim_set_phy_ctrl(struct sams=
ung_dsim *dsi)
> >         const struct samsung_dsim_driver_data *driver_data =3D dsi->dri=
ver_data;
> >         const unsigned int *reg_values =3D driver_data->reg_values;
> >         u32 reg;
> > +       struct phy_configure_opts_mipi_dphy cfg;
> > +       int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
> > +       int hs_exit, hs_prepare, hs_zero, hs_trail;
> > +       unsigned long long byte_clock =3D dsi->hs_clock / 8;
> >
> >         if (driver_data->has_freqband)
> >                 return;
> >
> > +       phy_mipi_dphy_get_default_config_for_hsclk(dsi->hs_clock,
> > +                                                  dsi->lanes, &cfg);
> > +
> > +       /*
> > +        * TODO:
> > +        * The tech reference manual for i.MX8M Mini/Nano/Plus
>
> Does it mean, Applications Processor Reference Manual? better add it
> clear reference.

I can do that.

>
> > +        * doesn't state what the definition of the PHYTIMING
> > +        * bits are beyond their address and bit position.
> > +        * After reviewing NXP's downstream code, it appears
> > +        * that the various PHYTIMING registers take the number
> > +        * of cycles and use various dividers on them.  This
> > +        * calculation does not result in an exact match to the
> > +        * downstream code, but it is very close, and it appears
> > +        * to sync at a variety of resolutions. If someone
> > +        * can get a more accurate mathematical equation needed
> > +        * for these registers, this should be updated.
> > +        */
> > +
> > +       lpx =3D PS_TO_CYCLE(cfg.lpx, byte_clock);
> > +       hs_exit =3D PS_TO_CYCLE(cfg.hs_exit, byte_clock);
> > +       clk_prepare =3D PS_TO_CYCLE(cfg.clk_prepare, byte_clock);
> > +       clk_zero =3D PS_TO_CYCLE(cfg.clk_zero, byte_clock);
> > +       clk_post =3D PS_TO_CYCLE(cfg.clk_post, byte_clock);
> > +       clk_trail =3D PS_TO_CYCLE(cfg.clk_trail, byte_clock);
> > +       hs_prepare =3D PS_TO_CYCLE(cfg.hs_prepare, byte_clock);
> > +       hs_zero =3D PS_TO_CYCLE(cfg.hs_zero, byte_clock);
> > +       hs_trail =3D PS_TO_CYCLE(cfg.hs_trail, byte_clock);
>
> I think we can do some kind of negotiation has done similar in bsp by
> taking inputs from bit_clk  and PLL_1432X table. Did you try this? we
> thought this approach while writing dsim to support dynamic dphy.

I originally attempted to implement the lookup table that was used in
the downstream NXP kernel, but I was told to not use a lookup table
but to calculate them directly instead.  I reached out to my NXP rep
and I was told that they could not divulge the contents of these
registers since the DSI driver was under a license from Samsung and
that information was not available outside of an NDA.

When I did the testing for this, I tested a variety of resolutions and
refresh rates and compared the values output from here to those
generated by the NXP lookup table, and they are very close.  From what
I could tell, the variance didn't appear to manifest itself on the
monitors that I tried.  I tried to explain this in the TODO message,
but maybe it wasn't clear.

Marek S tested this on Exynos and he didn't report any regressions.

adam
>
> Thanks,
> Jagan.
