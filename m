Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC374B374
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGGPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGGPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:00:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED11FE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:00:01 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-576a9507a9bso46587947b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688742000; x=1691334000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXWXkSUzw9+6yEZh83K8PUDQEmfYrr8qCrzZLCEBY/o=;
        b=jki+DGL7JvgqT4DeMqboGGZ38iarIwXTm5dyf+lNpH2jvgyoY1DbmR2oLjWleDV2tI
         //HuSOQx+LlFfK/8ovnzxODRvl6hxUoNzkQ65+CDssv0s2qSiuj4TihvnWnrahrGOcw2
         isswuDp1fu1xZl0PQRKD+scVHE+JKI92pMDgU9tuq9cO+H26QKZGDCug4YvKpY3wsRHf
         5gIyQ4I9q9Bv2d3u8YvDWMNwtFw+vFXmAKCDW7Pyw68K4h1DI1rCKdMp3wskoKHRJb9i
         Ef9yf4JAWOXRqX9zlUNW6ExsYgxqDmNPBZsHl0VrgUBwa6Uw/qEHcRUTiOpTbEkQbr9o
         LWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742000; x=1691334000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXWXkSUzw9+6yEZh83K8PUDQEmfYrr8qCrzZLCEBY/o=;
        b=RshojWFH529oE8rey5D8A6Ib1JWS6FuAl7PntzwB1BeSm0uMXuZqDCCbkpxSIDIhzx
         NylzLc7L9m8BwodGNctOOT5T2C2VXpzssRT2eDKsiPuSGUn8hnBfGWzEedol8wWz3juA
         GLYcc83KYiNVMSPvBSv7U9qtKuo3x8ePzzPA0VpLh1M3kN7KyT/q7C4DH+0Nrk/eTSVa
         ZmNkzq65RuFYOQj3W8fTejKv3AfUwP2aMeZBFlDm5ymFHqdupaoKDR2q43sLeV0rqDxd
         1vUrYuCJNwaZe/NELbyD75J8crTe54Qw5/I+qTKXDEw7I2HexmmttJr38gi3BfABp2lk
         SnAg==
X-Gm-Message-State: ABy/qLZGORWlc+FABPc1LBJ5PbTgIjZ4KM/voMyjdAAujjA14mWJpdzg
        0v3fkRm7RR60MTQt0JPg+egKYshPBs0dzRkcsoSazA==
X-Google-Smtp-Source: APBJJlE1BZcabAFehqNCs//dqigKyMMoDXX4Syr09uTj4SE7BfYLXhHLaSzqjf58oTSZlAvE8sVD/ilI2HCtgHiWmxk=
X-Received: by 2002:a25:5502:0:b0:bcf:d645:bd9 with SMTP id
 j2-20020a255502000000b00bcfd6450bd9mr4478249ybb.3.1688742000568; Fri, 07 Jul
 2023 08:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-8-ulf.hansson@linaro.org> <0364cab8-25b0-5850-9791-4b0451d2adbe@gmail.com>
In-Reply-To: <0364cab8-25b0-5850-9791-4b0451d2adbe@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jul 2023 16:59:24 +0200
Message-ID: <CAPDyKFroGAF1rH3HaQXFw2prNWa2Saz73FM0Hsy0pJ=Eojnt0Q@mail.gmail.com>
Subject: Re: [PATCH 07/18] soc: mediatek: Move power-domain drivers to the
 genpd dir
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 16:45, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 07/07/2023 16:04, Ulf Hansson wrote:
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Cc: <linux-mediatek@lists.infradead.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> We are missing a complete commit message here, is that intentional?

I was lazy and added the motivations behind this in patch 1. I will
re-spin and fix this.

> It would also need a patch against the maintainers file.

You already have this in the Mediatek SoC section. But I can add the
genpd directory too, to make it explicit if you prefer that?

N:      mtk
N:      mt[2678]
K:      mediatek


>
> Apart from that patch looks good.
>
> Regards,
> Matthias

Thanks!

Kind regards
Uffe

>
> > ---
> >   drivers/genpd/Makefile                              | 1 +
> >   drivers/genpd/mediatek/Makefile                     | 3 +++
> >   drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h | 0
> >   drivers/{soc => genpd}/mediatek/mtk-pm-domains.c    | 0
> >   drivers/{soc => genpd}/mediatek/mtk-pm-domains.h    | 0
> >   drivers/{soc => genpd}/mediatek/mtk-scpsys.c        | 0
> >   drivers/soc/mediatek/Makefile                       | 2 --
> >   14 files changed, 4 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/genpd/mediatek/Makefile
> >   rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
> >   rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
> >   rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)
> >
> > diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> > index 6b9e9fe907f3..1a0a56925756 100644
> > --- a/drivers/genpd/Makefile
> > +++ b/drivers/genpd/Makefile
> > @@ -3,3 +3,4 @@ obj-y                                 += actions/
> >   obj-y                                       += amlogic/
> >   obj-y                                       += apple/
> >   obj-y                                       += bcm/
> > +obj-y                                        += mediatek/
> > diff --git a/drivers/genpd/mediatek/Makefile b/drivers/genpd/mediatek/Makefile
> > new file mode 100644
> > index 000000000000..8cde09e654b3
> > --- /dev/null
> > +++ b/drivers/genpd/mediatek/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_MTK_SCPSYS)             += mtk-scpsys.o
> > +obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS)  += mtk-pm-domains.o
> > diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/genpd/mediatek/mt6795-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt6795-pm-domains.h
> > rename to drivers/genpd/mediatek/mt6795-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/genpd/mediatek/mt8167-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8167-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8167-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/genpd/mediatek/mt8173-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8173-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8173-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/genpd/mediatek/mt8183-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8183-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8183-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/genpd/mediatek/mt8186-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8186-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8186-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/genpd/mediatek/mt8188-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8188-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8188-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/genpd/mediatek/mt8192-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8192-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8192-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/genpd/mediatek/mt8195-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mt8195-pm-domains.h
> > rename to drivers/genpd/mediatek/mt8195-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
> > similarity index 100%
> > rename from drivers/soc/mediatek/mtk-pm-domains.c
> > rename to drivers/genpd/mediatek/mtk-pm-domains.c
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/genpd/mediatek/mtk-pm-domains.h
> > similarity index 100%
> > rename from drivers/soc/mediatek/mtk-pm-domains.h
> > rename to drivers/genpd/mediatek/mtk-pm-domains.h
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
> > similarity index 100%
> > rename from drivers/soc/mediatek/mtk-scpsys.c
> > rename to drivers/genpd/mediatek/mtk-scpsys.c
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 8c0ddacbcde8..9d3ce7878c5c 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -4,8 +4,6 @@ obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
> >   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> >   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >   obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
> > -obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > -obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
> >   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> >   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> >   obj-$(CONFIG_MTK_SVS) += mtk-svs.o
