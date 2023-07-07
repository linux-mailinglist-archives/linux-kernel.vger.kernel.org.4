Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516674B365
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjGGOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGGOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:55:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10526AD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:55:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso2018608276.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688741724; x=1691333724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fD8UqByjVQZaOYrRH9n00mG/JWxOflxhgkt3jKtV60=;
        b=e0hb2EAf6WHbY5geehHqIq7YESqpwGvat037XDdpfWRZfWXcWlo9Vu0WtyxhTB5gii
         hDE7eifmi/ROEpYHjnuENTOTuJNOHCl2dcFDc903Ulstmf8zRFj2gTEaI1tShs79U4ot
         704VJZksXadue5fq0wx/0Gfj9q1VfAIV7gm1H/tVl+ros4g+/Uf/TUOUWkJr9HI9Ee1x
         CIYkJr5/3pw6I8BLP1UvHU03jFmGvUjn3rF4/bRIfwwwxoNyKbLctNsMsH1E98BseWoQ
         Se4PJfgCeK/y3T8Z7hIAw+/aIy+St0AK723wjrC1UV48MQaEKpWGhllVc+8RH730WE1Q
         OWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741724; x=1691333724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fD8UqByjVQZaOYrRH9n00mG/JWxOflxhgkt3jKtV60=;
        b=LLJGA7AFMD21buDlAINXW6/si1W6fQjulcawH1pXs9/cDEWtJiCrdg5c6PclAPURp8
         NdeLJT6nYvcjeQzyCyEkk+1CVGuyqeVs0Fa1taeHQNH/VWPqMqgTxHXA4DTqVz/kLeTf
         0VasQ5/iQlr+pei/jt0xRG6+TXSV4JKDqd29MWBm+Rx7SY1/0lu8aQ0bg0rVYh96NATj
         ZBko4+LNiXNrfMoG1WU7TEJzmpbU1ng499eJstIbJ+/THS1iF3ZEJslZxpDMEUfxCMCD
         MSm0Fa+U1wgAxsOUmy/m6P1uwPcJW9grF4a2X21s3jRuJIGR+wrKr6JPzzWL/iooRrrz
         tewg==
X-Gm-Message-State: ABy/qLYUwEYITe6SejBhtV0YQEm13QKlFUfm50wgr7Gh2MyQ0E7kr6ES
        EWVSoZ1IxLFsB9GQOzjrSjY8CqHwO/UVKIlSFKLqYw==
X-Google-Smtp-Source: APBJJlFrxFaG6bMvHkWjJa+Y/Zsglssbt8lE2+df1lfmaJ2asc9CJWHX4MFlS3Ein1oiJ/ppMK5rWUQLy28WoX5vMuk=
X-Received: by 2002:a25:6dd6:0:b0:c5d:37ca:a413 with SMTP id
 i205-20020a256dd6000000b00c5d37caa413mr4225615ybc.28.1688741723707; Fri, 07
 Jul 2023 07:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org> <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
In-Reply-To: <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jul 2023 16:54:48 +0200
Message-ID: <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
To:     neil.armstrong@linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 16:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 07/07/2023 16:04, Ulf Hansson wrote:
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: <linux-amlogic@lists.infradead.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   MAINTAINERS                                        | 1 +
> >   drivers/genpd/Makefile                             | 1 +
> >   drivers/genpd/amlogic/Makefile                     | 4 ++++
> >   drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
> >   drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
> >   drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
> >   drivers/soc/Makefile                               | 1 -
> >   drivers/soc/amlogic/Makefile                       | 3 ---
> >   8 files changed, 6 insertions(+), 4 deletions(-)
> >   create mode 100644 drivers/genpd/amlogic/Makefile
> >   rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
> >   rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
> >   rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 588769fab516..9b8c9ae2375d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1843,6 +1843,7 @@ F:      Documentation/devicetree/bindings/phy/amlogic*
> >   F:  arch/arm/boot/dts/amlogic/
> >   F:  arch/arm/mach-meson/
> >   F:  arch/arm64/boot/dts/amlogic/
> > +F:   drivers/genpd/amlogic/
> >   F:  drivers/mmc/host/meson*
> >   F:  drivers/phy/amlogic/
> >   F:  drivers/pinctrl/meson/
> > diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> > index a2d5b2095915..cdba3b9f0c75 100644
> > --- a/drivers/genpd/Makefile
> > +++ b/drivers/genpd/Makefile
> > @@ -1,2 +1,3 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   obj-y                                       += actions/
> > +obj-y                                        += amlogic/
> > diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
> > new file mode 100644
> > index 000000000000..3d58abd574f9
> > --- /dev/null
> > +++ b/drivers/genpd/amlogic/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> > +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> > diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
> > similarity index 100%
> > rename from drivers/soc/amlogic/meson-ee-pwrc.c
> > rename to drivers/genpd/amlogic/meson-ee-pwrc.c
> > diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > similarity index 100%
> > rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> > rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> > similarity index 100%
> > rename from drivers/soc/amlogic/meson-secure-pwrc.c
> > rename to drivers/genpd/amlogic/meson-secure-pwrc.c
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index 3b0f9fb3b5c8..dc93e1762ca7 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -23,7 +23,6 @@ obj-y                               += mediatek/
> >   obj-y                               += microchip/
> >   obj-y                               += nuvoton/
> >   obj-y                               += pxa/
> > -obj-y                                += amlogic/
> >   obj-y                               += qcom/
> >   obj-y                               += renesas/
> >   obj-y                               += rockchip/
> > diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> > index 7b8c5d323f5c..c25f835e6a26 100644
> > --- a/drivers/soc/amlogic/Makefile
> > +++ b/drivers/soc/amlogic/Makefile
> > @@ -2,7 +2,4 @@
> >   obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
> >   obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
> >   obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> > -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> >   obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> > -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>
> I've a few changes for v6.6, how shall we handle that ?

I think we should continue to use the soc tree until v6.6-rc1 (or if
Arnd have some other ideas), there are some more thoughts around this
in the cover letter.

Beyond v6.6-rc1 I plan to help with maintenance in practice  and run
my own separate git tree.

>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> Thanks !
> Neil

Thanks!

Kind regards
Uffe
