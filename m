Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FB74D5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGJMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJMhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:37:38 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18141D8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:37:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579efc32377so50095587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688992656; x=1691584656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+4ETNnXEEIrUabO7XSXb0/uWa2F8tZk9bAJbwXI7Gs=;
        b=N2mrNEPdno1WGhAjOeQdYHWV2aGzQo7aOrodhjWo0rxhnrmcx7a7nwnNj3zKpYqw9r
         5GZYtUefXvoW4DrRW2NI/sxU4t4sUkhhdBVFkadtBp+QupG0Y3rEixzDH39Qt+niLEMK
         5QFtH/Y8rf5BS27nSdo8Dh8mXO+ts0/IU8iFW5+xmnfBfBGl8n8tnrJwzs77VWHTU6FV
         Uj5OLyIjsIlDoYOav2Nh4X8YQP8bbXMWE8RItasPPgl01T0B8etEJEvTwxtQcS3gitrx
         qSKSEtXrsPX+2hQJsLLLwB4qMVwod+R+tqHiCNTu6hEamdL/nzKzbYPFtHE4XIs/CSY2
         LgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992656; x=1691584656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+4ETNnXEEIrUabO7XSXb0/uWa2F8tZk9bAJbwXI7Gs=;
        b=fcTngdk1WIGGMcNrwU0OPtiNjoZKTqPKYfX/qy41v2KOI6GmXW/qldA1sL97XQeiu8
         KaSfo3KZ67eHZyfOAvZce7/HxglQjhQ6bmC4g6bhbwZhiZx4uDZTijVjACCgdwj+KtYb
         bBtD0DgdRoO1gr7Njv2rtqbI3Dcxq1bug5YH3mlgPkQkrk4iG71jEXFoF4ucvUdZTSTt
         s1aW4d7LVLmD29ZY4CF5mIOqrTjtCzKCgsCPouR0cdhlf5THF4nrf3k4J+r8HvXaq+Qm
         EeinPrTqs56cQZleOx0laZY0OByyG7v7OJ2N6bjBrl+gcHE/ymsHom4o1WAJ3etHkpfU
         HpzA==
X-Gm-Message-State: ABy/qLbKF7rCCCe6AUe3hPh1UOy/AgjJj+64zQOYuYzk5khQoU6LnaVj
        4ZZyupdbeFwWdy0nzzAdKAFIBYXxbL1tSyUw+3T3LQ==
X-Google-Smtp-Source: APBJJlFfNDnfTLuhBhNMxxs9meN/aT8dA4DyAJodczZG5et458C2HMSMxoay4jvpzvlnUJl0aE5Uoqspw+fvlsfQpD8=
X-Received: by 2002:a0d:ea48:0:b0:577:60d4:a879 with SMTP id
 t69-20020a0dea48000000b0057760d4a879mr11018410ywe.33.1688992656290; Mon, 10
 Jul 2023 05:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org> <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
 <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org> <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
 <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
In-Reply-To: <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jul 2023 14:37:00 +0200
Message-ID: <CAPDyKFoRtEXTGQkNzGza-sS_j1ajGmjtCTaoPB7PXVDE2bS0tQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2023 at 04:21, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Fri, Jul 07, 2023 at 05:27:39PM +0200, Ulf Hansson wrote:
> > On Fri, 7 Jul 2023 at 17:12, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 07/07/2023 16:54, Ulf Hansson wrote:
> > > > On Fri, 7 Jul 2023 at 16:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> On 07/07/2023 16:04, Ulf Hansson wrote:
> > > >>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > >>> Cc: Kevin Hilman <khilman@baylibre.com>
> > > >>> Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > >>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > >>> Cc: <linux-amlogic@lists.infradead.org>
> > > >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > >>> ---
> > > >>>    MAINTAINERS                                        | 1 +
> > > >>>    drivers/genpd/Makefile                             | 1 +
> > > >>>    drivers/genpd/amlogic/Makefile                     | 4 ++++
> > > >>>    drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
> > > >>>    drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
> > > >>>    drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
> > > >>>    drivers/soc/Makefile                               | 1 -
> > > >>>    drivers/soc/amlogic/Makefile                       | 3 ---
> > > >>>    8 files changed, 6 insertions(+), 4 deletions(-)
> > > >>>    create mode 100644 drivers/genpd/amlogic/Makefile
> > > >>>    rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
> > > >>>    rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
> > > >>>    rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
> > > >>>
> > > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > > >>> index 588769fab516..9b8c9ae2375d 100644
> > > >>> --- a/MAINTAINERS
> > > >>> +++ b/MAINTAINERS
> > > >>> @@ -1843,6 +1843,7 @@ F:      Documentation/devicetree/bindings/phy/amlogic*
> > > >>>    F:  arch/arm/boot/dts/amlogic/
> > > >>>    F:  arch/arm/mach-meson/
> > > >>>    F:  arch/arm64/boot/dts/amlogic/
> > > >>> +F:   drivers/genpd/amlogic/
> > > >>>    F:  drivers/mmc/host/meson*
> > > >>>    F:  drivers/phy/amlogic/
> > > >>>    F:  drivers/pinctrl/meson/
> > > >>> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> > > >>> index a2d5b2095915..cdba3b9f0c75 100644
> > > >>> --- a/drivers/genpd/Makefile
> > > >>> +++ b/drivers/genpd/Makefile
> > > >>> @@ -1,2 +1,3 @@
> > > >>>    # SPDX-License-Identifier: GPL-2.0-only
> > > >>>    obj-y                                       += actions/
> > > >>> +obj-y                                        += amlogic/
> > > >>> diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
> > > >>> new file mode 100644
> > > >>> index 000000000000..3d58abd574f9
> > > >>> --- /dev/null
> > > >>> +++ b/drivers/genpd/amlogic/Makefile
> > > >>> @@ -0,0 +1,4 @@
> > > >>> +# SPDX-License-Identifier: GPL-2.0-only
> > > >>> +obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> > > >>> +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > > >>> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> > > >>> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
> > > >>> similarity index 100%
> > > >>> rename from drivers/soc/amlogic/meson-ee-pwrc.c
> > > >>> rename to drivers/genpd/amlogic/meson-ee-pwrc.c
> > > >>> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > > >>> similarity index 100%
> > > >>> rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> > > >>> rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > > >>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> > > >>> similarity index 100%
> > > >>> rename from drivers/soc/amlogic/meson-secure-pwrc.c
> > > >>> rename to drivers/genpd/amlogic/meson-secure-pwrc.c
> > > >>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > >>> index 3b0f9fb3b5c8..dc93e1762ca7 100644
> > > >>> --- a/drivers/soc/Makefile
> > > >>> +++ b/drivers/soc/Makefile
> > > >>> @@ -23,7 +23,6 @@ obj-y                               += mediatek/
> > > >>>    obj-y                               += microchip/
> > > >>>    obj-y                               += nuvoton/
> > > >>>    obj-y                               += pxa/
> > > >>> -obj-y                                += amlogic/
> > > >>>    obj-y                               += qcom/
> > > >>>    obj-y                               += renesas/
> > > >>>    obj-y                               += rockchip/
> > > >>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> > > >>> index 7b8c5d323f5c..c25f835e6a26 100644
> > > >>> --- a/drivers/soc/amlogic/Makefile
> > > >>> +++ b/drivers/soc/amlogic/Makefile
> > > >>> @@ -2,7 +2,4 @@
> > > >>>    obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
> > > >>>    obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
> > > >>>    obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> > > >>> -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> > > >>>    obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> > > >>> -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > > >>> -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> > > >>
> > > >> I've a few changes for v6.6, how shall we handle that ?
> > > >
> > > > I think we should continue to use the soc tree until v6.6-rc1 (or if
> > > > Arnd have some other ideas), there are some more thoughts around this
> > > > in the cover letter.
> > > >
> > > > Beyond v6.6-rc1 I plan to help with maintenance in practice  and run
> > > > my own separate git tree.
> > >
> > > If it helps I can send you a PR with only the pwrc changes you can merge
> > > before applying this serie.
> >
> > Right, that could be a good idea, but let's defer to Arnd before we
> > agree on the way forward.
> >
>
> How about sharing an immutable branch/tag with patch 1, then each one of
> us can merge that together with the soc-specific change, followed by any
> subsequent patches - leading up to the next merge window.
>
> Stephen will have a merge conflict in drivers/genpd/Makefile as each
> soc-specific addition comes in, and Arnd will see this conflict too. But
> this is going to be extremely trivial. But apart from this, there will
> not be any conflicts or additional branching constraints for us...
>

If I understand correctly, you are suggesting that each platform
maintainer should merge the immutable branch with patch1 - and that I
should send the patches (based on the immutable branch) to each of the
platform maintainers to manage. Instead of one pull request with
everything directly to Arnd, right?

This still means that Arnd will have to resolve the conflicts as the
pull requests arrive in his inbox.

Although, I guess what you are looking for is less work for the soc/
maintainers, which seems reasonable. Although, in that case, I might
as well share an immutable branch with the complete series, rather
than just patch1. That should help Arnd too, I think.

Again, let's leave the call to Arnd on what to do.

Kind regards
Uffe
