Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17937708D60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjESBeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESBem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:34:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37576E51
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:34:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643a1fed360so1968935b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684460081; x=1687052081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZyv/RHhPnwhEL5/tgJQl4m2REstOca6ErGOq+J0bjg=;
        b=S8yhgsGlLfZxL2GzdgyguvrUlpNV70jyzHbadQN/2yC/JWZRh+vKxjtBoRM314MCvQ
         R8NZV8ghce05Lh9AyVkq2moVPjmOEQjGr3/fvaUNxVZyHozR9EJIx9PcQG2XlcWWpPzx
         YNRNGEljXkKlY6evW4kwQ17MpUgZJMHozpbVwe0DzURzzX2oneOx5bMIwaVwhxcOqNWR
         4YvvcpoRVH3ZYrty82H5auFdrBGc50qTPUr7uGAbcKKzuTos19Ctrt87BPT7c8WZnEsq
         rnspd8ssi0dSVSlQdHEhbT+bUXxx2dDcVy4OeJwdFY7vrOJkJ5KwNA2Rsa3s8HQiQpg3
         8Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460081; x=1687052081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZyv/RHhPnwhEL5/tgJQl4m2REstOca6ErGOq+J0bjg=;
        b=ib+GPljgh71HkdHD8FjQIvsrk32h/mmu4FbDMqg9KOpR8aNyN2NN3GjmgMmqKBhg3S
         BGk+FIVGJmxMY4Fm0UysHoXSIhWKGtlkkEVM973nj33JY/1cHcLztp3ojNNOtryTbpqq
         kA8vm7pkpCZszFCHhz9lwdqRRhYgujik8Q+CgbZ4Ar+c3JAxMvF7U5I1TyEtae8BOXCJ
         +XvKLF71vGLa18fmcT0JUkor1WI6omBWBCeU/kvCqKx1W4ARY9EPEbcZ48cCkB1we1ZY
         OqCEEDoq8c16FXf9pvm7i4uOSQ/HLMseo+SiMuQRFw3gktwxQik/xyBqU7d/HZ/dVjAe
         3zTw==
X-Gm-Message-State: AC+VfDxIaigoSGmlkLvGDNNAe2cfhC9JBlEDrUhs2smHN+QtkX85XRtZ
        rmoeV2IA4JHJQD8/GRUGXnSIIpT0MItEdgy9W/4=
X-Google-Smtp-Source: ACHHUZ7Ovat76LORv3wtlN7xEUBrfFZHgLJHY1NOVClnDzGn8v0MxINbwkx3ylraLPAFdKdbQY8vgo7y0WHFhvOWEW4=
X-Received: by 2002:a17:902:7448:b0:1a6:dd9a:62c5 with SMTP id
 e8-20020a170902744800b001a6dd9a62c5mr1100511plt.10.1684460080477; Thu, 18 May
 2023 18:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
In-Reply-To: <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 18 May 2023 20:34:29 -0500
Message-ID: <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
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

On Thu, May 18, 2023 at 7:29=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Thu, May 18, 2023 at 8:06=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > This series fixes the blanking pack size and the PMS calculation.  It t=
hen
> > adds support to allows the DSIM to dynamically DPHY clocks, and support
> > non-burst mode while allowing the removal of the hard-coded clock value=
s
> > for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> > burst-clock device tree entry when burst-mode isn't supported by connec=
ted
> > devices like an HDMI brige.  In that event, the HS clock is set to the
> > value requested by the bridge chip.
> >
> > This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should
> > work on i.MX8M Mini as well. Marek Szyprowski has tested it on various
> > Exynos boards.
> >
> > Adam Ford (5):
> >   drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
> >   drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
> >   drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
> >   drm: bridge: samsung-dsim: Dynamically configure DPHY timing
> >   drm: bridge: samsung-dsim: Support non-burst mode
> >
> > Lucas Stach (1):
> >   drm: bridge: samsung-dsim: fix blanking packet size calculation
> >
> >  drivers/gpu/drm/bridge/Kconfig        |   1 +
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 142 +++++++++++++++++++++-----
> >  include/drm/bridge/samsung-dsim.h     |   4 +
> >  3 files changed, 124 insertions(+), 23 deletions(-)
> >
> > V7:  Move messages indicating the optional device tree items are going
> >      to be automatically read elsewhere was move to dev_dbg instead of
> >      dev_info.  Cleaned up some of the comments to be a bit more clear.
> >      Eliminated a double variable assignement accidentally introduced
> >      in V6 when some of the items were moved from patch 6 to patch 5.
>
> It seems you missed addressing one previous comment from Lucas:
>
> "Same as with the earlier patch, this needs to be documented in the DT
> binding by moving "samsung,burst-clock-frequency" to be a optional
> property."

Aargh!
I can't believe I did that.

Inki,

Can I do a single patch to which references this one and have you
apply them together when the time is right, or do you want me to
resend the whole series with an additional patch at the end making the
two device tree items optional?
I totally forgot, and I'm sorry.

adam

A
