Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761CF705D93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjEQC5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjEQC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:57:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA210B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:57:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64ab2a37812so9964014b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292239; x=1686884239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnuOU8YZAY2VdqLuuDl2JlOLCdJtcLvx8QAsfmZtytQ=;
        b=gUEQ6YIP2h5+1FZnw1wscP/BqNiEbFJUjthuEiXF+Hq2wNGM1iN8si6GtIL1xkt+0k
         9ESv70UIDz5VwcDpzIvhgVvXeFv5hWkUhdtaq0+JNcEKRWFXImTZ2rgHwNvYd8tGIgub
         HUijtNzTKRYNQFGvlNigpj57SKaNi8VAbz5tXr9RFFXh2igjZzrBiZtCVCSHiB0cxsVq
         w5fj6tId55AjyI/9ZKuWovEazea8HhZzBSusdUsu4oJuUXaBb2kFfbf/ytcPzp3FxfcR
         js7Szm2uu7NSfVeKHiZUQW4QhL5rOkbEM7DG4UrD6OZvY0ZIFbig7IuZU/Ph1otejvO3
         TS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292239; x=1686884239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnuOU8YZAY2VdqLuuDl2JlOLCdJtcLvx8QAsfmZtytQ=;
        b=BRRWVVixoOOMqidb9c4KjFhvnlZfxOo9TWqaFiWx1yTesB38N6DEfNgimA+YOqPHWg
         fQMRyIlOGP1RYZ+v6rtGVEhfA8Yoegb/kxYm8wUPlcEkVImcI+mxBRi6e+z9bj/AEAcz
         23H7JAGwtfqetZDwLBp8DABJMhMwb/LKF2dKgQl5Q2Q8Z+OcP//Iv/7sSvbpy0nuLtyj
         Ej7FYiNoU409jL+mipoukidi2a1RWZiOaCY0PW+K/19MtuwRIKRn1J3a6Qh8C4zmhAFc
         JhlP2ebg2uZwahEceAkVxV8IzF6vBQ/2HhGmDjcgaG01k+Y3z/C1KTgFifGnb8pDl/r9
         3SnQ==
X-Gm-Message-State: AC+VfDx8eCDLiy4ZXzEkEDwJSwAbXzdosSSR8dDEFHDG15BNwjLFaoce
        p3xes3Mg9+PlsIngFPx+UntSFZjaSeorNR6pe80=
X-Google-Smtp-Source: ACHHUZ6C/K6E71/HMSBYvo2HCCxEdxC2ibAbxU1NrJc/biM0wWE13sTLyo8tpdUBLY79SHF6uCFZ1iSx0GVIaNsGMY0=
X-Received: by 2002:a17:903:192:b0:1a9:2a9e:30a8 with SMTP id
 z18-20020a170903019200b001a92a9e30a8mr1082475plg.9.1684292239204; Tue, 16 May
 2023 19:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230515235729eucas1p2c5a85ead90e0fc033e41dc81b67d6922@eucas1p2.samsung.com>
 <20230515235713.232939-1-aford173@gmail.com> <9ea571ea-2252-d550-830c-861bbb94a4ba@samsung.com>
In-Reply-To: <9ea571ea-2252-d550-830c-861bbb94a4ba@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 16 May 2023 21:57:07 -0500
Message-ID: <CAHCN7x+o=jYJsvKr3b-WB3o2=nHtMZU7CvvVu62mVU5UPGT1pg@mail.gmail.com>
Subject: Re: [PATCH V6 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
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

On Tue, May 16, 2023 at 5:57=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 16.05.2023 01:57, Adam Ford wrote:
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
> >    drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
> >    drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
> >    drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
> >    drm: bridge: samsung-dsim: Dynamically configure DPHY timing
> >    drm: bridge: samsung-dsim: Support non-burst mode
> >
> > Lucas Stach (1):
> >    drm: bridge: samsung-dsim: fix blanking packet size calculation
> >
> >   drivers/gpu/drm/bridge/Kconfig        |   1 +
> >   drivers/gpu/drm/bridge/samsung-dsim.c | 143 +++++++++++++++++++++----=
-
> >   include/drm/bridge/samsung-dsim.h     |   4 +
> >   3 files changed, 125 insertions(+), 23 deletions(-)
>
> Feel free to add to all patches:
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for all your help testing.  I hope the V7 will be the last
attempt.  I've fixed the repeated declaration in patch 6, and added
your t-b statements to each of the patches with code changes.

I'm hoping to push V7 in a day or two pending any more feedback.

adam
>
>
> > V6:  Squash-in an additional error fix from Lucas Stach regarding the
> >       DPHY calcuations.  Remove the dynamic_dphy variable and let
> >       everyone use the new calculations.  Move the hs_clock caching
> >       from patch 6 to patch 5 to go along with the DPHY calcuations
> >       since they are now based on the recorded hs_clock rate.
> >
> > V5:  Update error message to dev_info and change them to indicate
> >       what is happening without sounding like an error when optional
> >       device tree entries are missing.
> >
> > V4:  Undo some accidental whitespace changes, rename PS_TO_CYCLE
> >       variables to ps and hz from PS and MHz. Remove if check
> >       before the samsung_dsim_set_phy_ctrl call since it's
> >       unnecessary.
> >       Added additional tested-by and reviewed-by comments.
> >       Squash patches 6 and 7 together since the supporting
> >       non-burst (patch 6) mode doesn't really work until
> >       patch 7 was applied.
> >
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
> >       This also maintains backwards compatibility with older device
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
