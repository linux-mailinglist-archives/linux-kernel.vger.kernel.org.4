Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9D704E90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjEPNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjEPNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:03:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB126B9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:02:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so13013334a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684242163; x=1686834163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaXORhz+8RW894yoFfhPFe4LLGnVYgme5zSeBCWCFHk=;
        b=EHiMiNDFqzYZH5BSekJGhS8x7xb1zcmnIC701W+wG85+uJQPEJdKPET0bsK1LXHZJQ
         IcDScvY88OyXCdEXFqij1pGx17YZNgkM3Ff+FMp7W5gocdRo2lm9rnd7pwHTeaigt0Jy
         ew0IioPC+UFdRDyDR1hNECB9IYyn1rDdZcFS/7ukvhjavNMlrlhvk3wwNW/xRjHENNyI
         QNfamb/pddXHv/uPkGPD7zxlblSCOKcVjD9P4G6GB3/TsbIwb0vKLxjlEsFUJQhcOXaJ
         y/b1yWsdIb/1eaHvzpym4AKUlUIgAzlzu9J8B1wJU0PEJIMtZIShmRomeR3yNYVfvIyR
         rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242163; x=1686834163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaXORhz+8RW894yoFfhPFe4LLGnVYgme5zSeBCWCFHk=;
        b=CDLSFgYxOioCp1jQQ6dVawWUSe077NDaytT79RK+NOnMCdLtdr2LUjFAHhJxZhW2un
         +BbO1QyOkTucQKUGZfQ1TciB1ubz3qWJUzr6Fq6OE2I6Q0Ge17H45FJjmBhTNAimSWnT
         FcJ7GF/48UA3y/IYbvcXdaXzPLsIt/pkE+6qUPoHj6R5fywowPht7hIEiB0BPTb4F9N6
         CoO1IAfzBujjs4OMliPi0AiaGe/tgmgDc1KpVWLBJmbQJS5Htr/G7tSq7qtPJp81pOZm
         wDpXE9rEHvgElteIbslbVRlV0mQ8pnly51rm1s+yGUc4+T/g7/joPBO3NtRjSSTTpmBt
         ps3g==
X-Gm-Message-State: AC+VfDwVB91wFT+pRlh57wHa/a+2+RTZxNJ17NdZfl9EhYFwf1ZVa6cm
        DI10rjSVAuxCh1iGnYADoQSbMluz5jX/W81vlaE=
X-Google-Smtp-Source: ACHHUZ51C0wEaA3yJ4UzgPmQyHJvXvfxH09GFBbgghyInTN0AWx4Cn/7unwTxVUGykHy2mSFqHyAPkaq0GDsPlkgo0w=
X-Received: by 2002:a17:902:ea07:b0:1ac:b0c5:77e5 with SMTP id
 s7-20020a170902ea0700b001acb0c577e5mr26208073plg.68.1684242162562; Tue, 16
 May 2023 06:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-7-aford173@gmail.com>
 <CAGXv+5EDYvjOiAWDnQsrrp=0iWm54N+pR3O43xDFXYE=UxAw-g@mail.gmail.com>
In-Reply-To: <CAGXv+5EDYvjOiAWDnQsrrp=0iWm54N+pR3O43xDFXYE=UxAw-g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 16 May 2023 08:02:30 -0500
Message-ID: <CAHCN7xKdr1syQS6RKNnuAuEEbsbDQjEnOdJcYdaFNDEnYVuK6w@mail.gmail.com>
Subject: Re: [PATCH V6 6/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
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

On Mon, May 15, 2023 at 10:26=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Tue, May 16, 2023 at 7:57=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > The high-speed clock is hard-coded to the burst-clock
> > frequency specified in the device tree.  However, when
> > using devices like certain bridge chips without burst mode
> > and varying resolutions and refresh rates, it may be
> > necessary to set the high-speed clock dynamically based
> > on the desired pixel clock for the connected device.
> >
> > This also removes the need to set a clock speed from
> > the device tree for non-burst mode operation, since the
> > pixel clock rate is the rate requested from the attached
> > device like a bridge chip.  This should have no impact
> > for people using burst-mode and setting the burst clock
> > rate is still required for those users.  If the burst
> > clock is not present, change the error message to
> > dev_info indicating the clock use the pixel clock.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 3944b7cfbbdf..03b21d13f067 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -655,16 +655,28 @@ static unsigned long samsung_dsim_set_pll(struct =
samsung_dsim *dsi,
> >
> >         dsi->hs_clock =3D fout;
> >
> > +       dsi->hs_clock =3D fout;
> > +
>
> Not sure about the double assignment. Was this caused by a rebase?

Oops,

I moved this to the previous patch since the updated dphy changes
needed to know the hs_clock. I must forgot to check this when I
applied the subsequent patch, so the double assignment appeared.  I am
surprised the patch tool didn't complain.  I guess the good news is
that nothing is broken, but the bad news is I have to spam everyone
with a V7.  I'll wait a couple days to see if anything finds anything
else.

adam
>
> ChenYu
>
> >         return fout;
> >  }
> >
> >  static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
> >  {
> > -       unsigned long hs_clk, byte_clk, esc_clk;
> > +       unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
> >         unsigned long esc_div;
> >         u32 reg;
> > +       struct drm_display_mode *m =3D &dsi->mode;
> > +       int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> > +
> > +       /* m->clock is in KHz */
> > +       pix_clk =3D m->clock * 1000;
> > +
> > +       /* Use burst_clk_rate if available, otherwise use the pix_clk *=
/
> > +       if (dsi->burst_clk_rate)
> > +               hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rat=
e);
> > +       else
> > +               hs_clk =3D samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_c=
lk * bpp, dsi->lanes));
> >
> > -       hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
> >         if (!hs_clk) {
> >                 dev_err(dsi->dev, "failed to configure DSI PLL\n");
> >                 return -EFAULT;
> > @@ -935,7 +947,7 @@ static void samsung_dsim_set_display_mode(struct sa=
msung_dsim *dsi)
> >         u32 reg;
> >
> >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > -               int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> > +               int byte_clk_khz =3D dsi->hs_clock / 1000 / 8;
> >                 int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk_k=
hz / m->clock;
> >                 int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz /=
 m->clock;
> >                 int hsa =3D (m->hsync_end - m->hsync_start) * byte_clk_=
khz / m->clock;
> > @@ -1785,10 +1797,13 @@ static int samsung_dsim_parse_dt(struct samsung=
_dsim *dsi)
> >                         return PTR_ERR(pll_clk);
> >         }
> >
> > +       /* If it doesn't exist, use pixel clock instead of failing */
> >         ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-fre=
quency",
> > -                                      &dsi->burst_clk_rate, 0);
> > -       if (ret < 0)
> > -               return ret;
> > +                                      &dsi->burst_clk_rate, 1);
> > +       if (ret < 0) {
> > +               dev_info(dev, "Using pixel clock for HS clock frequency=
\n");
> > +               dsi->burst_clk_rate =3D 0;
> > +       }
> >
> >         ret =3D samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequ=
ency",
> >                                        &dsi->esc_clk_rate, 0);
> > --
> > 2.39.2
> >
