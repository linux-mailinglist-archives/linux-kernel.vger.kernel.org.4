Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8C706656
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEQLOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjEQLOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB75262
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e4f674356so693403a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684322075; x=1686914075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xmg0O869YONDDMLwqg9d/3/NvawOKxY5WTUQTRsXs4=;
        b=gsJEmNx011NZDQBVn9JarypfjzrP9WDlPO7alzVcBkMUU3laeNeMqHKj4nr+jW5QdI
         qVdDN5bKAkOPmAq6ylek2sXRXvoUuOg4emMTSyPwJLa4Q18TTNOucGsksdBOqhX/KWjA
         mEIlXPOd6mlzFtobzaxjdNn+RhpNTJSPJkZikEWuqKBspfslOO2/kRGWTKDeWwGYdK40
         v0Ukvahg6BqNlM7NKd2PT7Hpycuvcx2WG/2JsqRWXek03dksyzMlMLw6Z9sHUm97wMxs
         rP7Mo/lsYRtsWagPT1kzP3C4VX/MpSGr9QJN6BtHXTp4iAzdDIMdCasaPi2MNC6aZrfa
         RHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322075; x=1686914075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Xmg0O869YONDDMLwqg9d/3/NvawOKxY5WTUQTRsXs4=;
        b=XW3wOAM5gowmMZa49Z7jo4x6Y2DQaemc7AyQbNBEvpj0HQ9SK45KbI78h8lUlkg7Xr
         kucc00nw6A9g7lo+56QwMqFt+CxwC8+TtwBT390/pVYU5bf5oAPlFM0oy1d+ZKC2Fh0f
         eApHyUghljvSFoZEyD5wipMUV2Ko+B9IBtx1jFJAjExPXosK+HFIV3mzSuKk0/tApJu5
         iOxHDpvbZPOHiRNzrVpis1OPBDAW2cRVHcn502zCUDKuXhEQUT2QcS+rWXzEozhOpKM3
         B9xhA/QRBNyU2WyLsiMvI692tSyDE/gnC06Gk5YielX5+L2nk+vZA/ucfDv9mTqnfGUZ
         V9uQ==
X-Gm-Message-State: AC+VfDyAhz8GsD+w7TQg5/DT0eAVfDBrIpEvM1PZw29qjffbzgvHyfCl
        kKLMrA8gZbyxgYht1vcYkVy/sRKathBb033UJKs=
X-Google-Smtp-Source: ACHHUZ4OfzYF7x5ng3MrSzcFycroJmBpDU07iAMnA1Ywp/koOW+8aaV/zJ0+iXsq5LZsC/PgdZqKRDC/ykobGmQ1k2g=
X-Received: by 2002:a17:90a:fcf:b0:253:4c99:6342 with SMTP id
 73-20020a17090a0fcf00b002534c996342mr681855pjz.46.1684322075405; Wed, 17 May
 2023 04:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-5-aford173@gmail.com>
 <CAMty3ZAU3NG8yk1dFB4Y3QtCZ7j7XUTqKHkJVKhhOduc4V5XpQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAU3NG8yk1dFB4Y3QtCZ7j7XUTqKHkJVKhhOduc4V5XpQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 17 May 2023 06:14:23 -0500
Message-ID: <CAHCN7xKweWg2OtvWzBaBMzEQgV9ychK+U9J3=Z+-0XwR4cHrqA@mail.gmail.com>
Subject: Re: [PATCH V6 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
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

On Wed, May 17, 2023 at 6:05=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> Hi Adam,
>
> On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > In order to support variable DPHY timings, it's necessary
> > to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> > can be used to determine the nominal values for a given resolution
> > and refresh rate.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index f076a09afac0..82c68b042444 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> >         select DRM_PANEL_BRIDGE
> > +       select GENERIC_PHY_MIPI_DPHY
>
> Is it really required? phy is optional as it is not required for
> imx8mm/n/p as of now. May be we can add it while supporting it.

This was added to the series because build errors were reported
without it due to the fact that I added calls to
phy_mipi_dphy_get_default_config_for_hsclk.
Selecting this config option guarantees
phy_mipi_dphy_get_default_config_for_hsclk will be built and removes
the build error for Exynos and some 32-bit builds.

phy_mipi_dphy_get_default_config_for_hsclk sets the DSI configurations
like lpx, hs_exit, clk_prepare, clk_zero, clk_trail, hs_prepare,
hs_zero and hs_trail and those need to be
dynamic in order to functional at various resolutions.  I did try
leaving the hard-coded values you used, and I wasn't successful in
getting much to sync.

adam

>
> Thanks,
> Jagan.
