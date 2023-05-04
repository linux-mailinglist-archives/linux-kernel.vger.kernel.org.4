Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE22F6F6CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEDNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:30:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656864C24
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:30:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64395e2a715so330347b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683207034; x=1685799034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5zsZyieTVAbp2iRxHeQ6n3AI+4u6cFOmhvnnOshY8E=;
        b=E8quQU+cUGSfXkNGJShwkhCuwJjqDNhbti1Y4b019xq7w0dS++lpvHBnw2QSiPSMxf
         LuaeypMAOIiyIfqmCxiwOluwfRTIaPBV06A3yuXOOw68c+y+gwSWyYIvdBKbkecsq86g
         rR1Lo6wYkHJ9bzswQzSinQmcnFfnxTIh8udre29Nn5LNn8TIL0wdjy3U8YqRqmVp4MPh
         KlGchG1khmNbJejhidFwncu9YWgxYxy7yR0QUHcGmyzfNAXaVC7+k5KLExoIyyx/OmdC
         fuygIFZeSYM1hC9gq3ehmbFmmqkcGJYRQYzuXUquMc6nlq418nnDWvH98RG5Xbd54vLu
         Y6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207034; x=1685799034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5zsZyieTVAbp2iRxHeQ6n3AI+4u6cFOmhvnnOshY8E=;
        b=I4uc9JT/V3Y2lt7eQDQbOkaQ7qTaFDqj+AQIZYqF5ybQvGTfed8UMqcNH1VKRl/qqt
         wmQ5nK4EHRMUTHka7XQTz345GA+HvPB1mgsIM+zk/KXd8uiYPCqdxZpP6jg6wCcpFdgo
         a2NBKNyu4ce9pGnUBnMvKkXATszXsEUWzbXReA5LPP64DLU9vgMgt4bUqpvozrw0kHLQ
         7UDh88HD52BpL69RU2ej0Y17HOKOEQPNvHJiSv+TfR3Hz5gJgHv5k9+t+fXgHBRaloWb
         4HNEI4py5hcSMq6D3v4//ZBSesrXd3hywylUHkoz611XaBqUD4C/2Hjgq1XeMvgYHcpX
         8bGQ==
X-Gm-Message-State: AC+VfDzyzcV4xJuf4rXqCcb7sA5U/J/Lhn+Z07XgUIbt7qY75lvAlcAy
        Nc8LhNWVRvxvO/TaLUBooAsLq10Mo3VBgqFoH8w=
X-Google-Smtp-Source: ACHHUZ5ffjYF492JruMj8ZfHqNuPp7FprBS7oBRNSilULYkqheWPo8hzmZDSdXYCqgXvwFMUg6B4PH7mh7jbtm4WC24=
X-Received: by 2002:a05:6a20:a226:b0:f5:6530:c7a8 with SMTP id
 u38-20020a056a20a22600b000f56530c7a8mr1766188pzk.22.1683207033691; Thu, 04
 May 2023 06:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230502010759.17282-1-aford173@gmail.com> <1759996.VLH7GnMWUR@steina-w>
 <CAHCN7x+Me-wbUNNyN9fJwg3KETE+0S2MfPOsAb=-CSuSUvZvPg@mail.gmail.com> <1856543.CQOukoFCf9@steina-w>
In-Reply-To: <1856543.CQOukoFCf9@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 4 May 2023 08:30:22 -0500
Message-ID: <CAHCN7xKcpD5w640a-W3cofdY4g3uK=Vt_w2BMWOuz-Q6m4gjaQ@mail.gmail.com>
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

On Thu, May 4, 2023 at 8:18=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Donnerstag, 4. Mai 2023, 14:57:01 CEST schrieb Adam Ford:
> > On Thu, May 4, 2023 at 7:40=E2=80=AFAM Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi Adam,
> > >
> > > Am Donnerstag, 4. Mai 2023, 14:00:08 CEST schrieb Adam Ford:
> > > > On Thu, May 4, 2023 at 4:21=E2=80=AFAM Alexander Stein
> > > >
> > > > <alexander.stein@ew.tq-group.com> wrote:
> > > > > Am Dienstag, 2. Mai 2023, 03:07:55 CEST schrieb Adam Ford:
> > > > > > Make the pll-clock-frequency optional.  If it's present, use it
> > > > > > to maintain backwards compatibility with existing hardware.  If=
 it
> > > > > > is absent, read clock rate of "sclk_mipi" to determine the rate=
.
> > > > > >
> > > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
> > > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > > > b/drivers/gpu/drm/bridge/samsung-dsim.c index
> > > > > > bf4b33d2de76..2dc02a9e37c0
> > > > > > 100644
> > > > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > > > @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct
> > > > > > samsung_dsim *dsi) {
> > > > > >
> > > > > >       struct device *dev =3D dsi->dev;
> > > > > >       struct device_node *node =3D dev->of_node;
> > > > > >
> > > > > > +     struct clk *pll_clk;
> > > > > >
> > > > > >       int ret;
> > > > > >
> > > > > >       ret =3D samsung_dsim_of_read_u32(node,
> > > > > >       "samsung,pll-clock-frequency",
> > > > > >
> > > > > >                                      &dsi->pll_clk_rate);
> > > > > >
> > > > > > -     if (ret < 0)
> > > > > > -             return ret;
> > > > > > +
> > > > > > +     /* If it doesn't exist, read it from the clock instead of
> > > > > > failing
> > > > > > */
> > > > > > +     if (ret < 0) {
> > > > > > +             pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> > > > > > +             if (!IS_ERR(pll_clk))
> > > > > > +                     dsi->pll_clk_rate =3D clk_get_rate(pll_cl=
k);
> > > > > > +             else
> > > > > > +                     return PTR_ERR(pll_clk);
> > > > > > +     }
> > > > >
> > > > > Now that 'samsung,pll-clock-frequency' is optional the error in
> > > > > samsung_dsim_of_read_u32() should be changed. Otherwise you will =
get
> > > > >
> > > > > > /soc@0/bus@32c00000/dsi@32e10000: failed to get 'samsung,pll-cl=
ock-
> > > > >
> > > > > frequency' property
> > > >
> > > > I'll change the message from err to info with a message that reads =
"no
> > > > samsung,pll-clock-frequency, using pixel clock"
> > > >
> > > > Does that work?
> > >
> > > Having just a info is totally fine with me. Thanks.
> > > Although your suggested message somehow implies (to me) using pixel c=
lock
> > > is just a fallback. I'm a bit concerned some might think
> > > "samsung,pll-clock- frequency" should be provided in DT. But this mig=
ht
> > > just be me.
> >
> > Oops, I got the PLL and burst burst clock confused.  I think both
> > burst-clock and pll clock messages should get updates.
> >
> > The pll clock should say something like "samsung,pll-clock-frequency
> > not defined, using sclk_mipi"
> >
> > The imx8m n/m/p have the sclk_mipi defined in the device tree, and
> > this patch allows them to not have
> > to manually set the pll clock since it can be read.  This allows to
> > people to change the frequency of the PLL in
> > in one place and let the driver read it instead of having to set the
> > value in two places for the same clock.
>
> That's why I would like to make it sound less error-like.
> How about "Using sclk_mipi for pll clock frequency"?
>
> > For the burst clock, I'd like to propose
> > "samsung,burst-clock-frequency not defined, using pixel clock"
>
> Similar to above how about "Using pixel clock for burst clock frequency"?

I like that.

>
> > Does that work for you?
>
> But I'm okay with both ways. Up to you.

 I'll wait another day or two to see if anyone else has any feedback,
and I'll submit V4 with some other items addressed too.

Thank you for your review!

adam

>
> Thanks and best regards,
> Alexander
>
>
> > > frequency
> > >
> > >
> > > Best regards,
> > > Alexander
> > >
> > > > adam
> > > >
> > > > > Best regards,
> > > > > Alexander
> > > > >
> > > > > >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clo=
ck-
> > > > >
> > > > > frequency",
> > > > >
> > > > > >                                      &dsi->burst_clk_rate);
> > > > >
> > > > > --
> > > > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 See=
feld, Germany
> > > > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, =
Stefan Schneider
> > > > > http://www.tq-group.com/
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
