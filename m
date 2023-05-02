Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2EE6F49D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjEBSk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEBSk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:40:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99701735
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:40:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so4788924b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683052852; x=1685644852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9I/fY681zol8PqXhiDG/vchs4lKKtE1w7jrrREjGas=;
        b=YZt7oVm86x/C+bmILbyE8jSQ+gAV8VbWITg5sCCiZJebKRtlzUNGBdX7uqi07EeVNO
         5SciqNs64BH0ZuhcaepLxfP1PAgpYdqvU99XqBrZFcviFXEiUiNCuLZndVSciiTtMw21
         JkcINtBLQ1yRY6jEVcCKZUBPGsKkMWXr4zyc0Gn9hfLr8AImsMBO2I4g3hr6yoni5DvO
         ioA7dSYKp3JK1UTUw5Si5uUiK44T7cLYrxbZYunV4S9vveKzJ+U8cWmzl73k+6zt57X/
         k9kf+oUncbNiB469BJ+2ma1JmotO9+NvGmeUqKc4i3gs6p7JmukLTtx7om4PfG2tibFc
         OHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052852; x=1685644852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9I/fY681zol8PqXhiDG/vchs4lKKtE1w7jrrREjGas=;
        b=aFUrccLe62I3i+jO5CjxCMDRjuVV5U6rNp8blHWbBQJWFSwEQXPBHfzBxp8ldwcaUN
         MO/8cnbDezGKJYdAPPDi28TfPtJzzKWn95VQCV4868mCYDyVuwP2bWKHyhhvo3Glt54e
         fMAYLQBs8fI3uow3orY0hbofpM0Z3O8SdJgRBu82pMvI9O68RPtyFsIlNmj2Hm9wmMDQ
         ecF2oosBocRvsLHGrTwEbOhwB3e4pNxKaxQtcllbzOhdqTfYOojPvlEmHlFR3RG55WSh
         KxuCWabyC/nDFUfRU1FVXtdpkRzGHlcbQ7bi6TqHyw0nNZTzq0Ul9rL7+auxZiKd5YEL
         UgMg==
X-Gm-Message-State: AC+VfDxkVRo79TTMQ8lwKJ/zfKw1eLZ6JNz5rn/IB1sOyk2kt9gZpo+D
        tyyCP40+wys18rfOjhiGrMyeAwrFENriIZTU+g6IcIXr
X-Google-Smtp-Source: ACHHUZ6PKezicQDj/QRPnP6gMfGXmHL2EzMCzyXxonGT4aSmO1mb09WzaNBULelXXyu5pc/A2moM1SAPoskVoe4fv4s=
X-Received: by 2002:a05:6a21:918c:b0:c6:c0c1:b1fe with SMTP id
 tp12-20020a056a21918c00b000c6c0c1b1femr18593162pzb.57.1683052852144; Tue, 02
 May 2023 11:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230502010811eucas1p1df7fcdcb3e3d363d39eb711f19618628@eucas1p1.samsung.com>
 <20230502010759.17282-1-aford173@gmail.com> <05fb14ea-1083-8efd-dad0-a0e707af8131@samsung.com>
In-Reply-To: <05fb14ea-1083-8efd-dad0-a0e707af8131@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 2 May 2023 13:40:41 -0500
Message-ID: <CAHCN7xKEUOWy=_ABdbwZzYURc-sD9HrR4LGXroBaWo82tHzZUw@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] drm: bridge: samsung-dsim: Support variable clocking
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
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

On Tue, May 2, 2023 at 3:35=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 02.05.2023 03:07, Adam Ford wrote:
> > This series fixes the blanking pack size and the PMS calculation.  It t=
hen
> > adds support to allows the DSIM to dynamically DPHY clocks, and support
> > non-burst mode while allowing the removal of the hard-coded clock value=
s
> > for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> > burst-clock device tree entry when burst-mode isn't supported by connec=
ted
> > devices like an HDMI brige.  In that event, the HS clock is set to the =
value
> > requested by the bridge chip.
> >
> > This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should=
 work
> > on i.MX8M Mini as well.
> >
> > Adam Ford (6):
> >    drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
> >    drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
> >    drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
> >    drm: bridge: samsung-dsim: Dynamically configure DPHY timing
> >    drm: bridge: samsung-dsim: Support non-burst mode
> >    drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst
> >      mode
> >
> > Lucas Stach (1):
> >    drm: bridge: samsung-dsim: fix blanking packet size calculation
> >
> >   drivers/gpu/drm/bridge/Kconfig        |   1 +
> >   drivers/gpu/drm/bridge/samsung-dsim.c | 150 ++++++++++++++++++++++---=
-
> >   include/drm/bridge/samsung-dsim.h     |   5 +
> >   3 files changed, 136 insertions(+), 20 deletions(-)
>
> Works fine (=3D doesn't break) on Exynos.
>
Thank is great news.  Thank you for testing!

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

adam
>
>
> >
> > ---
> > V3:  When checking if the bust-clock is present, only check for it
> >       in the device tree, and don't check the presence of the
> >       MIPI_DSI_MODE_VIDEO_BURST flag as it breaks an existing Exynos
> >       board.
> >
> >       Add a new patch to the series to select GENERIC_PHY_MIPI_DPHY in
> >       Kconfig otherwise the build breaks on the 32-bit Exynos.
> >
> >       Change vco_min variable name to min_freq
> >
> >       Added tested-by from Chen-Yu Tsai
> >
> > V2:  Instead of using my packet blanking calculation, this integrates
> >       on from Lucas Stach which gets modified later in the series to
> >       cache the value of the HS-clock instead of having to do the
> >       calucations again.
> >
> >       Instead of completely eliminating the PLL clock frequency from
> >       the device tree, this makes it optional to avoid breaking some
> >       Samsung devices.  When the samsung,pll-clock-frequency is not
> >       found, it reads the value of the clock named "sclk_mipi"
> >       This also maintains backwords compatibility with older device
> >       trees.
> >
> >       This also changes the DPHY calcuation from a Look-up table,
> >       a reverse engineered algorithm which uses
> >       phy_mipi_dphy_get_default_config to determine the standard
> >       nominal values and calculates the cycles necessary to update
> >       the DPHY timings accordingly.
> >
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
