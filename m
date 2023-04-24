Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D96EC9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjDXKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjDXKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:00:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CA196
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:00:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b6d0b9430so3272687a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682330420; x=1684922420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUMRNHc1IOPvtn61NaRliWajnbOQ2JnYVpMoyrR6jps=;
        b=ksjcdvRamKkSMZEKA/vEAJ0XlgtzkXUIkC/Du4VtUU9X7CTiVzPMYUvDjSa3c5+4li
         x1zzd+9epZfHWAAwIcEa2E/n6sf5GZnQS4iYJM++OotNWPsHxewi3uPc686+XmMJik9G
         I/9DjXUg04FNDgiZg5B0QHdVjT4f5SlszJEUtAc1tVWLaemQmdo20Qo7bgpjARJVqXKx
         bMFlNL9lpNmTRCmBHrVDjDMiB56wJnhJAZnXTbeGw9zf9EYvQphDYAhm4Y7ytviRrH9o
         ezkINx3DgZirGId7U4BLS4yEg7J0cE+Aq3uGNCWl2yesZsmq2y9wO4Pg8T+DCIEioLIU
         3J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330420; x=1684922420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUMRNHc1IOPvtn61NaRliWajnbOQ2JnYVpMoyrR6jps=;
        b=HIqUEhUsA8mXjVSadWDJ0A6pdCSnGh9F+maLwWBBblxd8LE6WSDkDn2mrBQJzwexep
         kelg1dj40kfvr+u8Ew6V++/XSgtJkQMdLvU2VlIpJISeMzLCtHkL0V/ClMNiPMVbKIV1
         JFEtIlwLfBwvw5zv0gNKc8LCpxdUFfjnSfQrxkQTQOIks1NdsXylfZqC7Pf/ipru1NWL
         Iux1StgzIeEzhHxaQMaY/y5+cV5PVEiQ1Q/5VJSCur58s8h4vypY66jBSrXhg3dhBxl5
         SpQAoRHdek4kMIn0T9x8Iw481T8KBV3EWzxtupyST1jTwAkKeWLS27bw2h2cfIjv6DA8
         TFDQ==
X-Gm-Message-State: AAQBX9c12gAXMkSboLs5fHrMkpFwhLRBIDki632YzPVmyXqiQjxvkSGX
        yjMZoh9S9ljkCT8zKzUTTA3Biwsrxa/pMLl7yPM=
X-Google-Smtp-Source: AKy350YUY1ReqHJOT7z0DA806c3GV+dlkDAcLbZdmJUpeKLYce3dM6MZm7Bi7vtEySOMlCMSPrH6x1xFWGYiPL+w734=
X-Received: by 2002:a17:90a:4b42:b0:247:944d:b75e with SMTP id
 o2-20020a17090a4b4200b00247944db75emr13573601pjl.12.1682330420421; Mon, 24
 Apr 2023 03:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <CGME20230423121305eucas1p287a952d41b1884b117fa15a748b9e1a2@eucas1p2.samsung.com>
 <20230423121232.1345909-6-aford173@gmail.com> <b6b53da5-6986-a958-ef84-650b3a57ad9c@samsung.com>
In-Reply-To: <b6b53da5-6986-a958-ef84-650b3a57ad9c@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 Apr 2023 05:00:09 -0500
Message-ID: <CAHCN7x+vd-bP8NgS-cRrnm8ojq0kwUg6aXokJv6xSU7BrT04Vw@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com, l.stach@pengutronix.de,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 3:25=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 23.04.2023 14:12, Adam Ford wrote:
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
> > device like an HDMI bridge chip.  This should have no
> > impact for people using burst-mode and setting the burst
> > clock rate is still required for those users.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> This one breaks Exynos-5433 based TM2e board with a DSI panel.

Marek S,

Thank you for testing!  I knoiw there are several of us who appreciate
your testing this since it's hard to know if something broke without
hardware.  Is there any way you can tell me if the flag is set to
enable MIPI_DSI_MODE_VIDEO_BURST?
I was trying to be diligent about not breaking your boards, but
without your boards, it's difficult.  The theory was that if
MIPI_DSI_MODE_VIDEO_BURST is set and there is a burst clock set in the
device tree, it would use the burst clock.

As a fall-back I could just simply check for the presence of the
burst_clock_rate instead of both MIPI_DSI_MODE_VIDEO_BURST and
burst_clock_rate.


>
> > ---
> >   drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index f165483d5044..cea847b8e23c 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -657,11 +657,21 @@ static unsigned long samsung_dsim_set_pll(struct =
samsung_dsim *dsi,
> >
> >   static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
> >   {
> > -     unsigned long hs_clk, byte_clk, esc_clk;
> > +     unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
> >       unsigned long esc_div;
> >       u32 reg;
> > +     struct drm_display_mode *m =3D &dsi->mode;
> > +     int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> > +
> > +     /* m->clock is in KHz */
> > +     pix_clk =3D m->clock * 1000;
> > +
> > +     /* Use burst_clk_rate for burst mode, otherwise use the pix_clk *=
/
> > +     if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) && dsi->burst_c=
lk_rate)

Would you be willing to test this if this line just read:

              if (dsi->burst_clk_rate)

That would tell me if my fallback idea works.

Thank you,

adam

> > +             hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rate)=
;
> > +     else
> > +             hs_clk =3D samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk=
 * bpp, dsi->lanes));
> >
> > -     hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
> >       if (!hs_clk) {
> >               dev_err(dsi->dev, "failed to configure DSI PLL\n");
> >               return -EFAULT;
> > @@ -1800,10 +1810,11 @@ static int samsung_dsim_parse_dt(struct samsung=
_dsim *dsi)
> >                       return PTR_ERR(pll_clk);
> >       }
> >
> > +     /* If it doesn't exist, use pixel clock instead of failing */
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
> >                                      &dsi->burst_clk_rate);
> >       if (ret < 0)
> > -             return ret;
> > +             dsi->burst_clk_rate =3D 0;
> >
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequen=
cy",
> >                                      &dsi->esc_clk_rate);
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
