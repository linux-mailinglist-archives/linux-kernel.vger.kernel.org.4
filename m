Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9938E707E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjERKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjERKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:38:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093D1BFC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:38:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42711865eso11972425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684406283; x=1686998283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WgXpFHyqifOXUE8I1+PymSK/x9dYBAVGMZl7up5+PU0=;
        b=Bm7LxaqDtN3SA67GPQgi0QxFFOBWRFu+4Uv5ve+71Jh6p0oo4Ntm8r7kHGXHh03EQe
         7JxrjonR5wz67YoC+sHKgECU+idi6ReKayX636uWLR9HU54BKlBrCnp15qF54UX+JZXD
         FZPUiPE4jP+3yiHdtH6fi4j2KCilBzUddThPzRZy+Z1yExVzSwpmSZ/EZh5Qf3MDynBU
         tUCwXFC74h/Mgh4nimu6pQ1QBC3k5zAiEheLaDDpbhiaieL7viCsqdF/QT8o/yHCgRwY
         /okZ3z7APJXu9APd1ccwecmtgJITjco/mbJjStK9W3NyS/707xS0hb3mXPNtv5uZHl5z
         fkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684406283; x=1686998283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgXpFHyqifOXUE8I1+PymSK/x9dYBAVGMZl7up5+PU0=;
        b=Dw7BX3NWsJDQxywXp4siP3od+o/zdnfShEL8icM4697PQf3X/NHFpMjrSyLHvTzpYF
         K8cpWnAD2I3TxIVUBVkufJ9TVJw468v3CBgblVKGD8X5lbxEzldIL+by5mHhoAClnaeO
         KM2/tBE/S01oky5VAXjlcMAILxDzhaAbo056xUKvL7EGRdNQAtL72QhkfOpJZTOdJPoo
         ytH04ruFHRC7bGwAOSDK+vZqoHBouierNi/TnoZuF1lO8QtuN6os4q29UuD3VotDLx8K
         OSh5XquXoIs8ndMWNDfkw8HQcSAe8a/x4c00D3ubWxnqlZrnI3liIhPLDvu6HV3HcN2l
         TD3Q==
X-Gm-Message-State: AC+VfDzgxFBUH4hhSa4y+8IsZnq9tWwecL9cMdHorbZ4G8ea+/uyxdzh
        1Zpw4KZ135LA4t8erPV1JNbSI52JLQv4W3Ai6RIbQQ==
X-Google-Smtp-Source: ACHHUZ7DJsLPY4beCCBkNY1sLavEjQX/ODkHWwEquHghfxTa80akrKboqELguxfMAk3rRa+5n3YqnKtlNElakWMJGpQ=
X-Received: by 2002:a5d:6309:0:b0:309:433b:8414 with SMTP id
 i9-20020a5d6309000000b00309433b8414mr939323wru.54.1684406283064; Thu, 18 May
 2023 03:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
 <20230517211756.2483552-5-bhupesh.sharma@linaro.org> <e3ed8dc6-61f1-e73c-2bc7-4e57e86b8647@linaro.org>
In-Reply-To: <e3ed8dc6-61f1-e73c-2bc7-4e57e86b8647@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 18 May 2023 16:07:51 +0530
Message-ID: <CAH=2Ntwrs=+dg8_KRRoEaKg3j6boyMNd6XDxaEK45=BVXqyoQA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] usb: misc: eud: Add driver support for SM6115 / SM4250
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, quic_schowdhu@quicinc.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 15:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 17.05.2023 23:17, Bhupesh Sharma wrote:
> > Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> >
> > On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> > needs to be accessed only via the secure world (through 'scm'
> > calls).
> >
> > Also, the enable bit inside 'tcsr_check_reg' needs to be set
> > first to set the eud in 'enable' mode on these SoCs.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/usb/misc/Kconfig    |  2 +-
> >  drivers/usb/misc/qcom_eud.c | 65 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 61 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 99b15b77dfd5..51eb5140caa1 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -146,7 +146,7 @@ config USB_APPLEDISPLAY
> >
> >  config USB_QCOM_EUD
> >       tristate "QCOM Embedded USB Debugger(EUD) Driver"
> > -     depends on ARCH_QCOM || COMPILE_TEST
> > +     depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
> >       select USB_ROLE_SWITCH
> >       help
> >         This module enables support for Qualcomm Technologies, Inc.
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index 74f2aeaccdcb..6face21b7fb7 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -11,9 +11,11 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/usb/role.h>
> >
> >  #define EUD_REG_INT1_EN_MASK 0x0024
> > @@ -30,15 +32,25 @@
> >  #define EUD_INT_SAFE_MODE    BIT(4)
> >  #define EUD_INT_ALL          (EUD_INT_VBUS | EUD_INT_SAFE_MODE)
> >
> > +#define EUD_EN2_EN           BIT(0)
> > +#define EUD_EN2_DISABLE              (0)
> > +#define TCSR_CHECK_EN                BIT(0)
> > +
> > +struct eud_soc_cfg {
> > +     u32 tcsr_check_offset;
> > +};
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
> > +     phys_addr_t                     secure_mode_mgr;
> >  };
> >
> >  static int enable_eud(struct eud_chip *priv)
> > @@ -46,7 +58,11 @@ static int enable_eud(struct eud_chip *priv)
> >       writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> >       writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> >                       priv->base + EUD_REG_INT1_EN_MASK);
> > -     writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_EN);
> > +     else
> > +             writel(EUD_EN2_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
> >
> >       return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> >  }
> > @@ -54,7 +70,11 @@ static int enable_eud(struct eud_chip *priv)
> >  static void disable_eud(struct eud_chip *priv)
> >  {
> >       writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> > -     writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
> > +     else
> > +             writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
> >  }
> >
> >  static ssize_t enable_show(struct device *dev,
> > @@ -178,6 +198,8 @@ static void eud_role_switch_release(void *data)
> >  static int eud_probe(struct platform_device *pdev)
> >  {
> >       struct eud_chip *chip;
> > +     struct resource *res;
> > +     phys_addr_t tcsr_check;
> >       int ret;
> >
> >       chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > @@ -200,9 +222,37 @@ static int eud_probe(struct platform_device *pdev)
> >       if (IS_ERR(chip->base))
> >               return PTR_ERR(chip->base);
> >
> > -     chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(chip->mode_mgr))
> > -             return PTR_ERR(chip->mode_mgr);
> > +     /*
> > +      * EUD block on a few Qualcomm SoCs needs secure register access.
> > +      * Check for the same.
> > +      */
> > +     if (of_device_is_compatible(chip->dev->of_node, "qcom,sm6115-eud")) {
> I didn't notice that this changed between v4 and v5, but in my v4 review
> I suggested using
>
> if (of_property_read_bool(chip->dev->of_node, "qcom,secure-mode-enable"))
>
> as this was the only place where the value of that function was checked
> and caching it in the driver struct simply made no sense (as of today, anyway)
>
> checking the device compatible does not scale very well for something
> generic, as now it'd require adding each qcom,smABCD-eud to this condition
> as well.
>
> > +             res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +             if (!res)
> > +                     return dev_err_probe(chip->dev, -ENODEV,
> > +                                          "failed to get secure_mode_mgr reg base\n");
> This suggests the reg-name is "secure_mode_mgr" which is not true,
> according to your binding patch. I thought about adding a separate
> entry, but ultimately this would be against the DT philosophy, as it
> references the same physical region as "eud-mode-mgr", just that due
> to ACL software running at a higher exception level it's not
> directly accessible..
>
> I was debating suggesting moving it to SoC configuration, but that
> also depends on the software stack (e.g. there are windows and cros
> 7280 laptops with different security restrictions).. so I think
> the dt property is the way to go.

Well, the changes were done as per Krzysztof's comments on the earlier
versions (see [1] and [2]):

[1]. https://lore.kernel.org/linux-arm-msm/fe326d38-ee52-b0a4-21d8-f00f22449417@linaro.org/
[2]. https://lore.kernel.org/linux-arm-msm/e60af365-4260-a56f-1ec1-c7c60d172b38@linaro.org/

I am fine with either approach. As I originally argued, having a
dt-property seems more useful to me to indicate a secure-mode access.

May be @Krzysztof Kozlowski , can share his opinions on the same.

Thanks,
Bhupesh
