Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456236F5BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjECQSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjECQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:18:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F116F1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:18:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e4f674356so708984a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683130682; x=1685722682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmKZspVB74y8KHaujMmKpQPz93YiFFN2bzMFb4mgq1o=;
        b=Q4Ot9zXTgNgD0strUAihBbymUptaXwEyFHutNOzqHf70COhEz0B4r6UBHbNfo0YULN
         CUKHiHMxW10d0m4/u2MdRzuT36JryMXu/v8wzTs5BsdwyngeMQqcM2wqUgLVmaUtjTrr
         tx9Q1MsfFBklXwZNCpX7s0u6gEE9iwVmXGvvWy0VNaFJMN5MYNvoIGvKG2lfNm/dFboP
         kFpb0DsAFA9gnlMRjxhNcYt4Pih5R56vjzluoeTQikprSC8e540eshNvl0A6cg10+1Qj
         vzxLxKRmbV89iPyDQyD+heEQhkZHNmD1e158SQ9E2flojyzeGXZgHAsuEYYwafxUzL1w
         H4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130682; x=1685722682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmKZspVB74y8KHaujMmKpQPz93YiFFN2bzMFb4mgq1o=;
        b=KQ3vRIjQCNYmZ6Duco7ScLvzG9LC301MM6bSMsrX1u6M1khsINd1+JG+f6crMj4NiB
         PwzceWqh6/di5VfJj+UDNd/DTfV+TqC4mfjo3R0eWAeXlNE1Uc9mYzR0T3P2lJL0PXdj
         ll31uwqM/YdxzpgZ45ub2beM78kV6MzXJgwGS5MXWIRwhxjjeNMRD2vm/GEXBrWAVAlr
         NLRAgnXAr4yosDsagTIJ20Okz2E2MdQ1qemZwZjH2m1L1QHnX51hqKoTOoPWVaYfmD7G
         eE8KrATPByRu7TX9UD1AeH4D9c15RSnhEqSU/fj+4Ogy9ehuv68lyikt7uP4NKm/Wt2q
         SAAA==
X-Gm-Message-State: AC+VfDyMj/9nInDWpYwXAsvJ1noKTlPzUDHsXhHFB4KbsTDrtqIgoXi2
        4+pBvUDsGDxAQlFP+hEstMxIBpZRX3eJwXxhvkU=
X-Google-Smtp-Source: ACHHUZ7J2U5JE/rIMcy4i2ok3/I41F44ypaSOWGNPZ9hXcPpCyTr3JavDAAKGO/0IQMTysI+qWj8BNnsAcL13ND2Nu4=
X-Received: by 2002:a17:90a:8b92:b0:24d:f59a:d331 with SMTP id
 z18-20020a17090a8b9200b0024df59ad331mr12791706pjn.26.1683130682321; Wed, 03
 May 2023 09:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230502010759.17282-1-aford173@gmail.com> <20230502010759.17282-8-aford173@gmail.com>
 <ba50c423-2678-3865-8f9a-907480c9870a@kontron.de>
In-Reply-To: <ba50c423-2678-3865-8f9a-907480c9870a@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 May 2023 11:17:50 -0500
Message-ID: <CAHCN7x+ZQWspfiJVyrsJ=2E6OBya1o4vhBh9efxcjC09hv=Ziw@mail.gmail.com>
Subject: Re: [PATCH V3 7/7] drm: bridge: samsung-dsim: Let blanking calcuation
 work in non-burst mode
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        aford@beaconembedded.com, Chen-Yu Tsai <wenst@chromium.org>,
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

On Wed, May 3, 2023 at 10:52=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 02.05.23 03:07, Adam Ford wrote:
> > The blanking calculation currently uses burst_clk_rate for calculating
> > the settings. Since it's possible to use this in non-burst mode, it's
> > possible that where won't be burst_clk_rate.  Instead, cache the
>
> "possible that burst_clk_rate is 0"
>
> > clock rate configured from of samsung_dsim_set_pll and use it instead.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com> Tested-by: Chen-Yu Tsai <=
wenst@chromium.org>
>
> Maybe this patch should be squashed into patch 6/7 as otherwise
> burst_clk_rate could be 0 here causing bisection issues?

I thought about squashing them and I went back and forth on that.
Since there are some other minor edits in this series, I can push a V4
with these squashed.

>
> Apart from that:
>
> Tested on Kontron BL i.MX8MM with SN65DSI84 and ADV7535 bridges.
>

Thank you for testing this series.

> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>

adam
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
> >  include/drm/bridge/samsung-dsim.h     | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 53099461cdc2..1dc913db2cb3 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -652,6 +652,8 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
> >               reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
> >       } while ((reg & DSIM_PLL_STABLE) =3D=3D 0);
> >
> > +     dsi->hs_clock =3D fout;
> > +
> >       return fout;
> >  }
> >
> > @@ -960,7 +962,7 @@ static void samsung_dsim_set_display_mode(struct sa=
msung_dsim *dsi)
> >       u32 reg;
> >
> >       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > -             int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> > +             int byte_clk_khz =3D dsi->hs_clock / 1000 / 8;>          =
 int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
> >               int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz / m=
->clock;
> >               int hsa =3D (m->hsync_end - m->hsync_start) * byte_clk_kh=
z / m->clock;
> > diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/sam=
sung-dsim.h
> > index 76ea8a1720cc..14176e6e9040 100644
> > --- a/include/drm/bridge/samsung-dsim.h
> > +++ b/include/drm/bridge/samsung-dsim.h
> > @@ -94,6 +94,7 @@ struct samsung_dsim {
> >
> >       u32 pll_clk_rate;
> >       u32 burst_clk_rate;
> > +     u32 hs_clock;
> >       u32 esc_clk_rate;
> >       u32 lanes;
> >       u32 mode_flags;
