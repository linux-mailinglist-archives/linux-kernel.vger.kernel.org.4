Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B485B88B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiINM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiINM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:56:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C166A4E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:56:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-345528ceb87so178550707b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mmcKEjTS1hv6gEdnWK2Uvw+XT407+XmrNmwBWhV8Lok=;
        b=E3tQcQgTwxMM8Jz3YFNM2CB98b1QbEi2wST6iyzoPV0qeijgEGW7rV3WUcjqTE71Hn
         0NTSsnXkcz2xFaaGiTt/6YT0CTa9XFVvYlm5zhXzJqJmjyrTuKNkfS9pgFhE8jRHISRR
         fXQOUdhLOPVRGiPar1YyTtu06rfJloenQf9Cdd2TlNv4v+A3wcvluYwD6EfVkQq1wS5k
         deBt9FO2MCw9DcT+zBrJHdxEoCe6Ts3KrzMGE/82yrRnwbeGTRJ48fbRS+lcVkmQKm/q
         Qbx2gdL57D/j8QJTpDZh1bYsBSzbm/yiVmlq/KIFb0nugWvzQR8aTztgPXnOkADYq+ja
         46+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mmcKEjTS1hv6gEdnWK2Uvw+XT407+XmrNmwBWhV8Lok=;
        b=I2+hL0i3sHlDjZIdPBHmq4o+8g0Vh5q7zcSZhuwvnxqquQRHBoPsS48QXyLKeV0O7O
         nHt+MsVZYN4PBeG94hOVgaVZaicOHmTdHtPklCS9oQRCzQFCFbfsxOO7wyvBQG966VGz
         m3Lk0Y7LheH5m9B8UxyD239h7oCvxs5sDwnhk0UwqtZdblfwUUD1GgT+I68F7dX39Fih
         4B718Hs+uxfJqv0vloJairioB7t62FX+5QTJl/7BsPYfGe6L5SEWPWE5qR/KOxnRsBV9
         isOjvdA9mWsQq1b9Tn1jTsPoZDDc1YGO6+HilQgpm7IBAccsglYsJ1r1Trv6CiY2tljU
         kILA==
X-Gm-Message-State: ACgBeo0BzHmWVqJqowm800EH1eALJtCsm4WiGp0Hbgu6DZK6ygESjFdY
        pc5vgOJedceC5nGe4Zl3k98WoIMjVgXXscNmO6WsHg==
X-Google-Smtp-Source: AA6agR4CWQ6/k5R9xvM/2hZ7UEs2ayJ5TYG/Br2SOS3GeCeaVI11cKB8LqqUD5RjhxjT2z6m2HTdQnRqrXAzpUSsxvU=
X-Received: by 2002:a0d:f204:0:b0:333:c23f:d793 with SMTP id
 b4-20020a0df204000000b00333c23fd793mr30919559ywf.71.1663160188392; Wed, 14
 Sep 2022 05:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-2-bchihi@baylibre.com>
 <48cb4f47-754c-9994-2489-7ffabfc1b3b9@collabora.com>
In-Reply-To: <48cb4f47-754c-9994-2489-7ffabfc1b3b9@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 14 Sep 2022 14:55:52 +0200
Message-ID: <CAGuA+oqnqzABCs1fmeH+bmEGgz_7_rt7co8g8GbyeqHnqaOohQ@mail.gmail.com>
Subject: Re: [PATCH v9,1/7] thermal: mediatek: Relocate driver to mediatek folder
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Nice to hear from you again.
Understood. The changes you asked for will be implemented in the v10
of this series.
It will be sent very soon, I'm still working on Daniel's review too.

Thank you for the review!

Best regards,
Balsam

On Wed, Sep 14, 2022 at 1:58 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/08/22 10:07, bchihi@baylibre.com ha scritto:
> > From: Michael Kao <michael.kao@mediatek.com>
> >
> > Add MediaTek proprietary folder to upstream more thermal zone and cooler
> > drivers, relocate the original thermal controller driver to it, and rename it
> > as "auxadc_thermal.c" to show its purpose more clearly.
> >
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   drivers/thermal/Kconfig                       | 14 ++++--------
> >   drivers/thermal/Makefile                      |  2 +-
> >   drivers/thermal/mediatek/Kconfig              | 22 +++++++++++++++++++
> >   drivers/thermal/mediatek/Makefile             |  1 +
> >   .../auxadc_thermal.c}                         |  2 +-
> >   5 files changed, 29 insertions(+), 12 deletions(-)
> >   create mode 100644 drivers/thermal/mediatek/Kconfig
> >   create mode 100644 drivers/thermal/mediatek/Makefile
> >   rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index e052dae614eb..d35f63daca3b 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -412,16 +412,10 @@ config DA9062_THERMAL
> >         zone.
> >         Compatible with the DA9062 and DA9061 PMICs.
> >
> > -config MTK_THERMAL
> > -     tristate "Temperature sensor driver for mediatek SoCs"
> > -     depends on ARCH_MEDIATEK || COMPILE_TEST
> > -     depends on HAS_IOMEM
> > -     depends on NVMEM || NVMEM=n
> > -     depends on RESET_CONTROLLER
> > -     default y
> > -     help
> > -       Enable this option if you want to have support for thermal management
> > -       controller present in Mediatek SoCs
> > +menu "Mediatek thermal drivers"
> > +depends on ARCH_MEDIATEK || COMPILE_TEST
> > +source "drivers/thermal/mediatek/Kconfig"
> > +endmenu
> >
> >   config AMLOGIC_THERMAL
> >       tristate "Amlogic Thermal Support"
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index def8e1a0399c..f7daeb8056c4 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -55,7 +55,7 @@ obj-y                               += st/
> >   obj-$(CONFIG_QCOM_TSENS)    += qcom/
> >   obj-y                               += tegra/
> >   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> > -obj-$(CONFIG_MTK_THERMAL)    += mtk_thermal.o
> > +obj-y                                += mediatek/
> >   obj-$(CONFIG_GENERIC_ADC_THERMAL)   += thermal-generic-adc.o
> >   obj-$(CONFIG_UNIPHIER_THERMAL)      += uniphier_thermal.o
> >   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> > diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> > new file mode 100644
> > index 000000000000..8ff32370b591
> > --- /dev/null
> > +++ b/drivers/thermal/mediatek/Kconfig
> > @@ -0,0 +1,22 @@
> > +config MTK_THERMAL
> > +     tristate "MediaTek thermal drivers"
> > +     depends on THERMAL_OF
> > +     help
> > +       This is the option for MediaTek thermal software solutions.
> > +       Please enable corresponding options to get temperature
> > +       information from thermal sensors or turn on throttle
> > +       mechaisms for thermal mitigation.
> > +
> > +if MTK_THERMAL
> > +
> > +config MTK_SOC_THERMAL
> > +     tristate "AUXADC temperature sensor driver for MediaTek SoCs"
> > +     depends on HAS_IOMEM
> > +     depends on NVMEM
>
> That's not true. This driver doesn't depend on NVMEM, as in function
> mtk_thermal_get_calibration_data(), the calibration params are initialized
> with default values and if no "calibration-data" cell was found, it will
> return 0 and simply go on with probing... and this is because not all SoCs
> need calibration data from eFuses.
> If you check carefully, the original entry says "NVMEM || NVMEM=n".
>
> Please drop the NVMEM dependency from this config entirely.
>
> > +     depends on RESET_CONTROLLER
>
> While at it, can you please also drop the dependency for RESET_CONTROLLER?
> I know it was present on the original config entry, but that's wrong, as
> the driver doesn't strictly require resets, as it uses device_reset_optional().
>
>
> Regards,
> Angelo
>
