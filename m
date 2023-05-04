Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD86F6C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjEDM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEDM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:57:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95149768F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:57:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf21bb42bso2798025ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683205033; x=1685797033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r3+FqvWqUwbYAK6Z7KEo2OC+w4vPYMJW6RIm0+aJDQ=;
        b=IkDDfEcg4jNFdU84dpo+hIdyZnXORSiPTRs8JLMFikhU3ExvgOYAzeDsTplXeKY3CR
         2wTUHO2YKdvL+/sXu617jN0orWLcwAumeGG9CyH+3XDMgEU5MWXdWfj/AzZRfnz7Hm9O
         UjKwfkRZ2cFdNZgUbxXGkqZfEBr8gfXILQ/22MM9ffSgqUjwqMtX879kUvG1XRRbmYB7
         6g86gN8KpHYHZswugZKJUkVN+xyj6i1WqoBpSM8R+YcNq3Y3cSvBOfRpu98owKouNFlN
         ++z02hkoljPG6H+olrDlZT1RDr0tX7z/xxgsbc0r26g0xXcm6nvE+yaXqxG9iEWM77Z+
         dv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683205033; x=1685797033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r3+FqvWqUwbYAK6Z7KEo2OC+w4vPYMJW6RIm0+aJDQ=;
        b=GSrM6eFq8a7m6u29XP6KgNnnj7F4v73swwEbW0POw146ykJx9sgkn6dMKj3zkh3xX5
         szEOq4oWpYT4VYma7Y/rHOyrKztSmPJDVV2hnMTO2SMUl1d3VnWx/UEynkDKUGxmB2tI
         dfShe8SBZGV0oYyWrMuwFXqmRaZEiEJaRhuN4NYZD3/xFQJ6cxUULkZJRn8MNvteVani
         pk0xURb+phjjKa+xlr+/vtzdkVXOOapIvqsMTX7rQbCpNNP6K8NAb8E/DnzjRGvjPNZ/
         4PFrvp8dFwQgn3EISsPXHFa/ON6DTsNENpepiDGhuR7o+uG9vqZzmNLiomEhxr/uiZOe
         WYrg==
X-Gm-Message-State: AC+VfDxIlANqkvEqP1qOtDPeIjXjbIrRwZ8D0l0gmWJL6sKQq8Rayyj0
        BaxNr6kqaO+3OsmgTODf0clRGVMo1hr7LxkqY9g=
X-Google-Smtp-Source: ACHHUZ5Gv8OxDojRdcFPQxG40zhBXAMDh4fXvpHyyJf/4zD+E+EA2VdKQKBgjdVInFlSweWhmf5eMDFywC6QpslTPGo=
X-Received: by 2002:a17:902:bc8b:b0:1a9:6b57:f400 with SMTP id
 bb11-20020a170902bc8b00b001a96b57f400mr3015510plb.16.1683205032698; Thu, 04
 May 2023 05:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230502010759.17282-1-aford173@gmail.com> <7519081.EvYhyI6sBW@steina-w>
 <CAHCN7x+7YWyvy+cDXcD2D5twJt_Ys6tP+TsLgjH4TgcORW0LPA@mail.gmail.com> <1759996.VLH7GnMWUR@steina-w>
In-Reply-To: <1759996.VLH7GnMWUR@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 4 May 2023 07:57:01 -0500
Message-ID: <CAHCN7x+Me-wbUNNyN9fJwg3KETE+0S2MfPOsAb=-CSuSUvZvPg@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 7:40=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Adam,
>
> Am Donnerstag, 4. Mai 2023, 14:00:08 CEST schrieb Adam Ford:
> > On Thu, May 4, 2023 at 4:21=E2=80=AFAM Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Am Dienstag, 2. Mai 2023, 03:07:55 CEST schrieb Adam Ford:
> > > > Make the pll-clock-frequency optional.  If it's present, use it
> > > > to maintain backwards compatibility with existing hardware.  If it
> > > > is absent, read clock rate of "sclk_mipi" to determine the rate.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > b/drivers/gpu/drm/bridge/samsung-dsim.c index bf4b33d2de76..2dc02a9=
e37c0
> > > > 100644
> > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct
> > > > samsung_dsim *dsi) {
> > > >
> > > >       struct device *dev =3D dsi->dev;
> > > >       struct device_node *node =3D dev->of_node;
> > > >
> > > > +     struct clk *pll_clk;
> > > >
> > > >       int ret;
> > > >
> > > >       ret =3D samsung_dsim_of_read_u32(node,
> > > >       "samsung,pll-clock-frequency",
> > > >
> > > >                                      &dsi->pll_clk_rate);
> > > >
> > > > -     if (ret < 0)
> > > > -             return ret;
> > > > +
> > > > +     /* If it doesn't exist, read it from the clock instead of fai=
ling
> > > > */
> > > > +     if (ret < 0) {
> > > > +             pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> > > > +             if (!IS_ERR(pll_clk))
> > > > +                     dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> > > > +             else
> > > > +                     return PTR_ERR(pll_clk);
> > > > +     }
> > >
> > > Now that 'samsung,pll-clock-frequency' is optional the error in
> > > samsung_dsim_of_read_u32() should be changed. Otherwise you will get
> > >
> > > > /soc@0/bus@32c00000/dsi@32e10000: failed to get 'samsung,pll-clock-
> > >
> > > frequency' property
> >
> > I'll change the message from err to info with a message that reads "no
> > samsung,pll-clock-frequency, using pixel clock"
> >
> > Does that work?
>
> Having just a info is totally fine with me. Thanks.
> Although your suggested message somehow implies (to me) using pixel clock=
 is
> just a fallback. I'm a bit concerned some might think "samsung,pll-clock-
> frequency" should be provided in DT. But this might just be me.

Oops, I got the PLL and burst burst clock confused.  I think both
burst-clock and pll clock messages should get updates.

The pll clock should say something like "samsung,pll-clock-frequency
not defined, using sclk_mipi"

The imx8m n/m/p have the sclk_mipi defined in the device tree, and
this patch allows them to not have
to manually set the pll clock since it can be read.  This allows to
people to change the frequency of the PLL in
in one place and let the driver read it instead of having to set the
value in two places for the same clock.

For the burst clock, I'd like to propose
"samsung,burst-clock-frequency not defined, using pixel clock"

Does that work for you?

adam

> frequency

>
> Best regards,
> Alexander
>
> > adam
> >
> > > Best regards,
> > > Alexander
> > >
> > > >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-
> > >
> > > frequency",
> > >
> > > >                                      &dsi->burst_clk_rate);
> > >
> > > --
> > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld=
, Germany
> > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stef=
an Schneider
> > > http://www.tq-group.com/
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>
