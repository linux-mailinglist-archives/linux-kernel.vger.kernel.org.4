Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC527068F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjEQNKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjEQNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:10:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B11BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:10:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25343f0c693so509884a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684329011; x=1686921011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5kKVzXc1ddW+HM8Pa2gQRIWA34V+//pRWEjd4SIrrk=;
        b=q9sUxQBexYe9V48hqcGeoqjkSpJX8XsZtD3X0LIWN9ZhwbGQGykoWqSLXMI857PGRs
         gCrpz4e6yKCHl1AjFI/C294/QT7+uovQMhiXHLTRZCf/F9su4uQwRxd9wiQEc74owWur
         /7e/w0PivY/ij7nXF/tOydgC8Qn7CyKFy0vmODbzc6be9S/3AmPTLM/RxwQNDGRjr2dI
         aZzdzLRYNxldDZY7uvriBHHICTrnIT0M4MITkzMYsh7D0/xb1vEk4jODczzOclMYSqGU
         bt/j7AG3rNFP6H5CFMge4XGO1hOsPFSebcaz6pyhvkCy73PAUVHrVcMTnEKsdedL0aYz
         FRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329011; x=1686921011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5kKVzXc1ddW+HM8Pa2gQRIWA34V+//pRWEjd4SIrrk=;
        b=kt9W07nY0QgOC+CKTOGuq3DHdbL6Hbdd5Iuo1UhFVgMC52P0n0p61VqAmluRFQGCog
         XjUaS++z+Jjn3VN9EhS77sfVRN2unG500SigYGA/2qZIRAlwC9S/f6cSbQMC1ZxACanj
         O/ximy9fe/evhJda1JOctyW3yYM6k7rx6Own5X5nivQwaVTDkmhDI0xxC31qnraeUVhh
         fQa0b7VpMj0xKH3rPF3w3b+22SDjgfbzkANk7u9UCLzRkL1VgYdjkIgfK4lu8gBPpjdU
         x3eL/oTIEJS82aqcw6w1OZ5wtMnfxEWeq98DIQGpr8mAULOWThM4ISZv6yF3WKFFcBRN
         8E7A==
X-Gm-Message-State: AC+VfDwNZiuUjcEPEw4mx2nAFQy0pEutlZi3PGvQ15xi0Oo/6SuWaX7D
        184QNxkzbbPm8VwL86P5gysMHL6pPKleowuKWqU=
X-Google-Smtp-Source: ACHHUZ7gQavplJEf5Suf8KTDCR92gDR1e5AE2C/sGwbSukSWMtUT4oUjK9xeHqdgGaTNYkWOKtSrXm9EXewRdC/ti6g=
X-Received: by 2002:a17:90b:350:b0:250:1905:ae78 with SMTP id
 fh16-20020a17090b035000b002501905ae78mr40489258pjb.15.1684329010517; Wed, 17
 May 2023 06:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-4-aford173@gmail.com>
 <1c8997c7c72143d130ebbc9ba438cebddc9d35e0.camel@pengutronix.de>
In-Reply-To: <1c8997c7c72143d130ebbc9ba438cebddc9d35e0.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 17 May 2023 08:09:59 -0500
Message-ID: <CAHCN7x+7QMiD6jeoHqTEcN+Rm22gddiqVDUO8ThVi4TnKER4iA@mail.gmail.com>
Subject: Re: [PATCH V6 3/6] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Wed, May 17, 2023 at 7:56=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Adam,
>
> Am Montag, dem 15.05.2023 um 18:57 -0500 schrieb Adam Ford:
> > Make the pll-clock-frequency optional.  If it's present, use it
> > to maintain backwards compatibility with existing hardware.  If it
> > is absent, read clock rate of "sclk_mipi" to determine the rate.
> > Since it can be optional, change the message from an error to
> > dev_info.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index bf4b33d2de76..08266303c261 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1712,11 +1712,11 @@ static const struct mipi_dsi_host_ops samsung_d=
sim_ops =3D {
> >  };
> >
> >  static int samsung_dsim_of_read_u32(const struct device_node *np,
> > -                                 const char *propname, u32 *out_value)
> > +                                 const char *propname, u32 *out_value,=
 bool optional)
> >  {
> >       int ret =3D of_property_read_u32(np, propname, out_value);
> >
> > -     if (ret < 0)
> > +     if (ret < 0 && !optional)
> >               pr_err("%pOF: failed to get '%s' property\n", np, propnam=
e);
> >
> >       return ret;
> > @@ -1726,20 +1726,29 @@ static int samsung_dsim_parse_dt(struct samsung=
_dsim *dsi)
> >  {
> >       struct device *dev =3D dsi->dev;
> >       struct device_node *node =3D dev->of_node;
> > +     struct clk *pll_clk;
> >       int ret;
> >
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
> > -                                    &dsi->pll_clk_rate);
> > -     if (ret < 0)
> > -             return ret;
> > +                                    &dsi->pll_clk_rate, 1);
> > +
> > +     /* If it doesn't exist, read it from the clock instead of failing=
 */
> > +     if (ret < 0) {
> > +             dev_info(dev, "Using sclk_mipi for pll clock frequency\n"=
);
>
> While this is certainly helpful while debugging the driver, I don't
> think it warrants a info print. Remove or downgrade to dev_dbg?

I can move to dbg.

>
> On the other hand the changed driver behavior should be documented in
> the devicetree binding by moving "samsung,pll-clock-frequency" into the
> optional properties and spelling out which clock rate is used when the
> property is absent.

Once this series is accepted, I was planning on doing a binding patch
which describes the items that are now optional followed by a patch to
add DSI->HDMI for the Beacon boards.  I can see the value in putting
the bindings patch in this series instead. I'll add it to the next
revision to cover both items that are now optional.

adam

>
> Regards,
> Lucas
>
> > +             pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> > +             if (!IS_ERR(pll_clk))
> > +                     dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> > +             else
> > +                     return PTR_ERR(pll_clk);
> > +     }
> >
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
> > -                                    &dsi->burst_clk_rate);
> > +                                    &dsi->burst_clk_rate, 0);
> >       if (ret < 0)
> >               return ret;
> >
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequen=
cy",
> > -                                    &dsi->esc_clk_rate);
> > +                                    &dsi->esc_clk_rate, 0);
> >       if (ret < 0)
> >               return ret;
> >
>
