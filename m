Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1DE6E95CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDTNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDTNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:24:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5463455A8;
        Thu, 20 Apr 2023 06:24:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-247526f0eceso685678a91.2;
        Thu, 20 Apr 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681997087; x=1684589087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwnhlLJyEh47311bVCrbK3D/ImOBY4/qp9iGa9ZeGIo=;
        b=ONIzX+fsmDFZ4VbgBdRcHCgYHnrSBP1dFd4aeE6I/29jSqTT3oOqtHUSmy8E2/Ki0A
         tSuP6Sh+TV8SNTGnG2V269F++sAwCMx/idYluhMe60Ihd1umwwpTKOjVY7wDo0trl6+E
         TEM/iFJhyla8toZ69F301BIJQSJiBWzWnGjrgib0aNCDydCMw58wBOYy4ESOOGZTYET7
         D+bjvDnhu7F32xSO9A4iXFmfHwdjerlFtiNilL+yEsA8qlbrlKLo12pbtJhQSBx7YbCU
         v/luq3oLXXXoQ/8A5LxnVmiY6APx6fn2PukIWFuL1lVrRiKbCJMJoqITAXbULrGLnybz
         ST1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997087; x=1684589087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwnhlLJyEh47311bVCrbK3D/ImOBY4/qp9iGa9ZeGIo=;
        b=gTu9gEu4A23dj6qNXr3yBbGFQ5TGsBjOtIEx7q36oh+J1yf3xQxk9MTP8JBP/CexsJ
         qOar8j4XZofSjcG5T9UWtXRBFaHbYFiIdNv2jmJTyR6sRdlLlS8uL4Yp3r5MgrdlsWsK
         GFJrvoEDYOKJ10/KqkN4EONcM5IUrJrRhQw3q6H7psTwbMJZEhucaC+uMDxVnmkWhBFd
         aPSoWeeU1K36w0Yd3kINaJmSw/VOB/29qT1aGCzIqDz8GWlfsN0Q2U3zRWWxVcAb9De9
         qWXuYro/RGToaX7hMkjABetPeizEDvwxVZyiMy46xAKeQFTqQUSGKb5LM5f8RpejY+UV
         Uk2A==
X-Gm-Message-State: AAQBX9f6Z/sStXxizlilgfok42TneqyMV8hRNiD919jZGwv+7WVx21dB
        4X2ZnxSw/orNrziZLGbiwKMCcOZ8Xv50MX/8Q7k=
X-Google-Smtp-Source: AKy350ZxG7RnlBrwRhQPUD6zN9rrL3FtZOktidwEmb9/Y/dRFeXtlhMFYCzZzu1ezgYBgH1ZgYDRjh15kvl1e16dSkU=
X-Received: by 2002:a17:90a:e7cf:b0:246:f710:4f01 with SMTP id
 kb15-20020a17090ae7cf00b00246f7104f01mr1573886pjb.35.1681997086466; Thu, 20
 Apr 2023 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
 <CAHCN7xL4+9NogrnXA1PEWorwY7JpSGBozDtHT83JvzjfinmS+A@mail.gmail.com>
 <CAHCN7xK8K+DsNAFTVAezwJQzZ7RCDb2CjCBZ8dNb=S8d1BmtMA@mail.gmail.com> <f42a2a11c1a2df4d773b61a449e8f4d5a9a010d1.camel@pengutronix.de>
In-Reply-To: <f42a2a11c1a2df4d773b61a449e8f4d5a9a010d1.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 20 Apr 2023 08:24:35 -0500
Message-ID: <CAHCN7x+bZHZHxYk=qC3QFS07kLO85w_rj1tOuX1Y3fJXekmvMQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane calculations
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
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

On Thu, Apr 20, 2023 at 8:06=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Adam,
>
> Am Mittwoch, dem 19.04.2023 um 05:47 -0500 schrieb Adam Ford:
> > On Mon, Apr 17, 2023 at 6:55=E2=80=AFAM Adam Ford <aford173@gmail.com> =
wrote:
> > >
> > > On Mon, Apr 17, 2023 at 3:43=E2=80=AFAM Lucas Stach <l.stach@pengutro=
nix.de> wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > Am Samstag, dem 15.04.2023 um 05:40 -0500 schrieb Adam Ford:
> > > > > If there is more than one lane, the HFP, HBP, and HSA is calculat=
ed in
> > > > > bytes/pixel, then they are divided amongst the different lanes wi=
th some
> > > > > additional overhead. This is necessary to achieve higher resoluti=
ons while
> > > > > keeping the pixel clocks lower as the number of lanes increase.
> > > > >
> > > >
> > > > In the testing I did to come up with my patch "drm: bridge: samsung=
-
> > > > dsim: fix blanking packet size calculation" the number of lanes did=
n't
> > > > make any difference. My testing might be flawed, as I could only
> > > > measure the blanking after translation from MIPI DSI to DPI, so I'm
> > > > interested to know what others did here. How did you validate the
> > > > blanking with your patch? Would you have a chance to test my patch =
and
> > > > see if it works or breaks in your setup?
> >
> > Lucas,
> >
> > I tried your patch instead of mine.  Yours is dependent on the
> > hs_clock being always set to the burst clock which is configured by
> > the device tree.  I unrolled a bit of my stuff and replaced it with
> > yours.  It worked at 1080p, but when I tried a few other resolutions,
> > they did not work.  I assume it's because the DSI clock is fixed and
> > not changing based on the pixel clock.  In the version I did, I only
> > did that math when the lanes were > 1. In your patch, you divide by 8,
> > and in mine, I fetch the bits-per-pixel (which is 8) and I divide by
> > that just in case the bpp ever changes from 8.  Overall,  I think our
> > patches basically do the same thing.
>
> The calculations in your and my patch are quite different. I'm not
> taking into account the number of lanes or the MIPI format. I'm basing

I was looking more at the division by 8 and the overhead correction of 6.
This number 6 also appears in the NXP downstream kernel [1].  I know
Marek V had some concerns about that.

> the blanking size purely on the ratio between MIPI DSI byte clock and
> the DPI interface clock. It's quite counter-intuitive that the host
> would scale the blanking to the number of lanes automatically, but
> still require the MIPI packet offset removed, but that's what my
> measurements showed to produce the correct blanking after translation
> to DPI by the TC358767 bridge chip.

How many lanes is your DSI interface using?

>
> If you dynamically scale the HS clock, then you would need to input the
> real used HS clock to the calculation in my patch, instead of the fixed
> burst mode rate.

I think what you're saying makes sense.

The code I originally modeled this from was from the NXP downstream
kernel where they define the calculation as being in words [2]. I am
not saying the NXP code is perfect, but the NXP code works.  With this
series, my monitors are able to sync a bunch of different resolutions
from 1080p down to 640x480 and a bunch in between with various refresh
rates too. That was the goal of this series.

Instead of just using your patch as-is, I will adapt yours to use the
scaled clock to see how it behaves and get back to you.  I have
finished reworking the dynamic DPHY settings, and I've fixed up making
the PLL device tree optional. If your patch works, I'll drop my
calculation and just build off what you have to use the scaled HS
clock when I submit the V2 and I'll make sure I CC you.

adam

[1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/br=
idge/sec-dsim.c#L270
[2] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/br=
idge/sec-dsim.c#L914

>
> Regards,
> Lucas
