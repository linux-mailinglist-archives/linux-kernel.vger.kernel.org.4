Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282EA6F7087
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjEDRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEDRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A15258
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso5728655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220227; x=1685812227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJpYk7FyfhnD3BtuxCCzvxRDbIq/0dZEMKhDfDZ1Z+U=;
        b=Q9AvnvHwE5GSMeGC8jWp6Nj/YSzX0zhUv0s9ljtRnNTHUQK2qAkxwqPV1wU2d5ZwfN
         lQSV5Kbyj57j+s9eCtYj3LUZ17NawG7sqWXH14qLZlo1s/0QVda0M2YCTV9I3hsIkViv
         gWyxno1lg/nwW0bYxUUKm88jzKrZj0/QtcM0VC902mxWIK0GVCfeu9K2PXBS7RU9U2wv
         sY942RASuaqv6oqEuhvBtjACcZV85c1N9wtmG9rdYdZr0TuT1b04p23lzKCZ2Pjx0Kth
         MFwQOIZI456IlTaeeKnqaxLaHNtvA6TV6YGCQijuryq3rHJJpoIYBrRpHb7HwMMakd07
         S+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220227; x=1685812227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJpYk7FyfhnD3BtuxCCzvxRDbIq/0dZEMKhDfDZ1Z+U=;
        b=Z3Slup/HbrJ+7UBONVft33BTWAFc7gSWDpMAjyULo5rS5ff2FxmPxsGJYuRtcMcYtD
         KCLtq1Bslt+nEGN6EHr0BHuKSoE+ieDjUuVf/gwD9gs64Rqh/gDBRqAdFH7xjJsRF4hL
         i6Z0ubqf+c3jrQ+yX01/dpc1Nud40NMcMCUeWxw5HAzE3N6eHTZdkXy+raZqzaeLdy/n
         ykrivwvh12mTo4E+j3v0GPiOhCtBUoQujPJm3K/YR+Ivvvb5MyKO1GgNsWuWCtW3VxwO
         aVGJInoy06peAqqRyhDtPX3cAjn2DA110tCBurwv6Fz/z2fVuo4/d0C56410hyEqOmls
         D+Vw==
X-Gm-Message-State: AC+VfDwjowaIROB8DvY64Io0jgJ1MmXhRMyL9S0gmJ4FXaY6Bn6mhLcW
        YB2tupa9eOQ6msw2PIV3l08DDomo+u0Uh6nbAugTSJsAr479mP1l
X-Google-Smtp-Source: ACHHUZ41LmJZheJk/hsWyMJ2KDBn+M67xJfyItsrxUnGzlMD8NznalIeiSZvmwu8HOuRatJjMpWQM2HmtzeAsTHMc24=
X-Received: by 2002:a5d:5547:0:b0:306:30e2:c84c with SMTP id
 g7-20020a5d5547000000b0030630e2c84cmr2929684wrw.49.1683220226723; Thu, 04 May
 2023 10:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
 <20230504082644.1461582-4-bhupesh.sharma@linaro.org> <344b34d8-c69e-bde4-7446-30d32657ee40@linaro.org>
In-Reply-To: <344b34d8-c69e-bde4-7446-30d32657ee40@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 22:40:14 +0530
Message-ID: <CAH=2NtzVEatke2LFyTFJDBgrQ07yz-AQgV7ubq+F6oxPmbKiZw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] usb: misc: eud: Add driver support for SM6115 / SM4250
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
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

On Thu, 4 May 2023 at 15:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 4.05.2023 10:26, Bhupesh Sharma wrote:
> > Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> >
> > On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> > needs to be accessed only via the secure world (through 'scm'
> > calls).
> >
> > Also, the enable bit inside 'tcsr_check_reg' needs to be set
> > first to set the eud in 'enable' mode on these SoCs.
> >
> > Since this difference comes from how the firmware is configured, so
> > the driver now relies on the presence of an extra boolean DT property
> > to identify if secure access is needed.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/usb/misc/Kconfig    |  1 +
> >  drivers/usb/misc/qcom_eud.c | 66 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 62 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 99b15b77dfd5..fe1b5fec1dfc 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
> >  config USB_QCOM_EUD
> >       tristate "QCOM Embedded USB Debugger(EUD) Driver"
> >       depends on ARCH_QCOM || COMPILE_TEST
> > +     select QCOM_SCM
> >       select USB_ROLE_SWITCH
> >       help
> >         This module enables support for Qualcomm Technologies, Inc.
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index b7f13df00764..b4736edcc64c 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -5,12 +5,14 @@
> >
> >  #include <linux/bitops.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> > @@ -30,15 +32,22 @@
> >  #define EUD_INT_SAFE_MODE    BIT(4)
> >  #define EUD_INT_ALL          (EUD_INT_VBUS | EUD_INT_SAFE_MODE)
> >
> > +struct eud_soc_cfg {
> > +     u32 tcsr_check_offset;
> > +};
> Not sure if turning this into a struct is necessary.. can't
> we just store the offset, or do we expect more changes?

I can see future versions already supporting newer features, so I kept
it a struct for now.

> > +
> >  struct eud_chip {
> >       struct device                   *dev;
> >       struct usb_role_switch          *role_sw;
> > +     const struct eud_soc_cfg        *eud_cfg;
> >       void __iomem                    *base;
> >       void __iomem                    *mode_mgr;
> >       unsigned int                    int_status;
> >       int                             irq;
> >       bool                            enabled;
> >       bool                            usb_attached;
> > +     bool                            secure_mode_enable;
> > +     phys_addr_t                     secure_mode_mgr;
> >  };
> >
> >  static int enable_eud(struct eud_chip *priv)
> > @@ -46,7 +55,11 @@ static int enable_eud(struct eud_chip *priv)
> >       writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> >       writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> >                       priv->base + EUD_REG_INT1_EN_MASK);
> > -     writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, BIT(0));
> #define [field name] BIT(0)

Ok.

> > +     else
> > +             writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> s/1/[field name]/

Ok.

> >       return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> >  }
> > @@ -54,7 +67,11 @@ static int enable_eud(struct eud_chip *priv)
> >  static void disable_eud(struct eud_chip *priv)
> >  {
> >       writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> > -     writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, 0);
> > +     else
> > +             writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> >  }
> >
> >  static ssize_t enable_show(struct device *dev,
> > @@ -178,12 +195,15 @@ static void eud_role_switch_release(void *data)
> >  static int eud_probe(struct platform_device *pdev)
> >  {
> >       struct eud_chip *chip;
> > +     struct resource *res;
> > +     phys_addr_t tcsr_base, tcsr_check;
> >       int ret;
> >
> >       chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> >       if (!chip)
> >               return -ENOMEM;
> >
> > +
> ?

Oops, I will fix it in v4.

> >       chip->dev = &pdev->dev;
> >
> >       chip->role_sw = usb_role_switch_get(&pdev->dev);
> > @@ -200,9 +220,40 @@ static int eud_probe(struct platform_device *pdev)
> >       if (IS_ERR(chip->base))
> >               return PTR_ERR(chip->base);
> >
> > -     chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(chip->mode_mgr))
> > -             return PTR_ERR(chip->mode_mgr);
> > +     chip->secure_mode_enable = of_property_read_bool(chip->dev->of_node,
> > +                                             "qcom,secure-mode-enable");
> If we map this region iff it's supposed to be used, we may just check
> for its presence and skip the additional property. Then, the address
> being non-NULL would invalidate the boolean property.

Bjorn requested during the review of the last version that we should not ioremap
the secure mode_mgr region. So, I followed this approach instead.

> > +     /*
> > +      * EUD block on a few Qualcomm SoCs need secure register access.
> > +      * Check for the same.
> > +      */
> > +     if (chip->secure_mode_enable) {
> > +             res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +             if (!res)
> > +                     return dev_err_probe(chip->dev, -ENODEV,
> > +                                          "failed to get secure_mode_mgr reg base\n");
> > +
> > +             chip->secure_mode_mgr = res->start;
> > +     } else {
> > +             chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> > +             if (IS_ERR(chip->mode_mgr))
> > +                     return PTR_ERR(chip->mode_mgr);
> > +     }
> > +
> > +     /* Check for any SoC specific config data */
> > +     chip->eud_cfg = of_device_get_match_data(&pdev->dev);
> > +     if (chip->eud_cfg) {
> > +             res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> I'd vouch to use _byname, in case we get some EUD impl that needs a
> different sort of a register set..

Sure, it makes sense.

> > +             if (!res)
> > +                     return dev_err_probe(chip->dev, -ENODEV,
> > +                                          "failed to get tcsr reg base\n");
> > +
> > +             tcsr_base = res->start;
> > +             tcsr_check = tcsr_base + chip->eud_cfg->tcsr_check_offset;
> > +
> > +             ret = qcom_scm_io_writel(tcsr_check, BIT(0));
> s/BIT(0)/..

Ok.

Thanks,
Bhupesh
