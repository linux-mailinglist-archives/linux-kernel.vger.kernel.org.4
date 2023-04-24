Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31896EC95B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjDXJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjDXJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:47:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C493593
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:47:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b73203e0aso26342470b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329636; x=1684921636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAISL+GRpU6SsSBHg/ya3DxahdjCFsvz5twTkYKfKiE=;
        b=YhWlvytb/xX4K/sErPeoc2dMxv9ckbJwfV0cmffwJNnUv5vOv4cWew70RVrJ1hkN3O
         XCruppbjHm3iy7sp3d7uMKabTaAurcPEYa+rLp8LWMx47YJ6oWyuMPHt9b/3JcxZvB8z
         dcwg6V8nRRLgO+PQ2EJGZzKUvmmhKYtHQkgHrbuV/k6HGQ9Hx6Zf2mDpGgvwtSWIWuAV
         9wiNurJLOVc6/SXgEGr2jIQ3EeNyghtMEXMX9ag+IzjRvH7KygY61flkTANF1hybnVWw
         GwYT2B5bUor/gFsqaE5vtJDDC070yjb8a/b7VLjIPsybZDNF6zeoihePl58m4ORe+EZV
         YavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329636; x=1684921636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAISL+GRpU6SsSBHg/ya3DxahdjCFsvz5twTkYKfKiE=;
        b=WLvu5PX4fNydvzpYsS37MI6CN9GsanqiZpkgVREJOUGZd3qHB/+u2N19+QFKOqx7Ns
         6JhvAD2hTyDQ9VSf7wytQztfanQHObj5mnUwJiYwtWi6sfpCOZDOAfxNyW4VilJR4Nzk
         kXWlXBBumNey5DrWhXJwFzngbNPFGSU4uTIxZjlMihekMX+UpJzWKUfgWoHkaVIP43DM
         eP1rg0ZDPQsK9frtxL+AEw3eDuFBPJCzIlTxgmN/7gyE5KqBteMoHzXlRx62VdaXIiSx
         ibihfLWK3Ca1plZYSx8FAq9byIJ7CQTRRmnnOcI1/xO2uPWpU8PcJv1le1jF3fN8iV4+
         xm2w==
X-Gm-Message-State: AAQBX9fJ8RkqQG0KQ1c/iifWNPmpH2b+UtUp5BkZuo282Pt01bBAr3o7
        PsofkjIibXBVwSWtBWBR2LvBqiFI1XJPJT5/PF66aFbBOnQppQ==
X-Google-Smtp-Source: AKy350auTsyZsYtcMAYd1CDjkR0cyubUg/DY615MQDX3JNzgSgUqxq1TAK/QoEPqm9A/3FZFIMcr2dLOiKOcPpSjKrA=
X-Received: by 2002:a17:902:ce89:b0:1a9:778b:c1a8 with SMTP id
 f9-20020a170902ce8900b001a9778bc1a8mr3444487plg.12.1682329635853; Mon, 24 Apr
 2023 02:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <20230423121232.1345909-2-aford173@gmail.com>
 <CAMty3ZCn9_AT8SOfFD-MYox16ZcqOEezt_0x6aES6LWQFj8Kpg@mail.gmail.com>
In-Reply-To: <CAMty3ZCn9_AT8SOfFD-MYox16ZcqOEezt_0x6aES6LWQFj8Kpg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 Apr 2023 04:47:04 -0500
Message-ID: <CAHCN7xLYfEO9Pxq91vZSDG0QXjnx3BEKYdsTXgQ1BTbtuTbLGQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/6] drm: bridge: samsung-dsim: fix blanking packet
 size calculation
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     l.stach@pengutronix.de, dri-devel@lists.freedesktop.org,
        m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
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

On Mon, Apr 24, 2023 at 4:03=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Sun, Apr 23, 2023 at 5:42=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > Scale the blanking packet sizes to match the ratio between HS clock
> > and DPI interface clock. The controller seems to do internal scaling
> > to the number of active lanes, so we don't take those into account.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index e0a402a85787..2be3b58624c3 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -874,17 +874,29 @@ static void samsung_dsim_set_display_mode(struct =
samsung_dsim *dsi)
> >         u32 reg;
> >
> >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > +               int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> > +               int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk_k=
hz / m->clock;
>
> I do not quite understand why it depends on burst_clk_rate, would you
> please explain? does it depends on bpp something like this
>
> mipi_dsi_pixel_format_to_bpp(format) / 8

The pixel clock is currently set to the burst clock rate.  Dividing
the clock by 1000 gets the pixel clock in KHz, and dividing by 8
converts bits to bytes.
Later in the series, I change the clock from the burst clock to the
cached value returned from samsung_dsim_set_pll.

>
> > +               int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz /=
 m->clock;
> > +               int hsa =3D (m->hsync_end - m->hsync_start) * byte_clk_=
khz / m->clock;
> > +
> > +               /* remove packet overhead when possible */
> > +               hfp =3D max(hfp - 6, 0);
> > +               hbp =3D max(hbp - 6, 0);
> > +               hsa =3D max(hsa - 6, 0);
>
> 6 blanking packet overhead here means, 4 bytes + payload + 2 bytes
> format? does this packet overhead depends on the respective porch's
> like hpf, hbp and hsa has different packet overheads?

Lucas might be able to explain this better.  However, it does match
the values of the downstream NXP kernel, and I tried playing with
these values manually, and 6 appeared to be the only number that
seemed to work for me too.  I abandoned my approach for Lucas'
implementation, because it seemed more clear than mine.
Maybe Lucas can chime in, since this is really his patch.

adam
>
> Jagan.
