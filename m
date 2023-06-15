Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD97314BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbjFOKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjFOKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490426A8;
        Thu, 15 Jun 2023 03:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D67761031;
        Thu, 15 Jun 2023 10:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C601C433D9;
        Thu, 15 Jun 2023 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686823214;
        bh=sgaQTjMumcDntF1+Rw8qMCOdQ78re8DXY7PV6swIiBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lL2jn3Au7wkj+GPGZfZHI0hvj3WXWXV1BdbZJvO8gkBDLaNaCXir5n0ngtSDKHLH6
         5jlgD9PgYx8foBPTisXuAvOhI2HOq/Y6Un7v2VePrUe07MZdwP9VVx4lnW2LS1/R4l
         mmZN+yg2EiJ8vB/gRnymrmsdApxReF5RGm0ZCWyq0XWDaLvSahS7IbcXD+AoQjk3Bv
         3PN4O4lCr4Y4lLZIPpc9m3jsaP8vYFSEoMhutq6p/gMiXned88RAl7PsS/GUxKA411
         /oENPeizAKoyjDxDfMa6ErdNZPkmJnVrxpN5bFxEXf5zLKfVafVIltE6nNJuXYwi4n
         En05SrJL8l7EA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso11374565a12.3;
        Thu, 15 Jun 2023 03:00:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDwwgrJ6gSvbOe8y7OauX2bbzTJWXIXXJ7uZvr/kLxuwL5CSzBWZ
        qaKSJ1nRSq4LdMk8wwM31Q2ONVSdVpBsyGCawZM=
X-Google-Smtp-Source: ACHHUZ4g5SZt9F+fFnfXd0o3pCw+8JYiLgE6DdlVHtXfxCF4jj1z54KwCpr1lZeskAOQRjjoWGVWomtADuMZTNxwFbU=
X-Received: by 2002:aa7:d703:0:b0:514:95e8:566c with SMTP id
 t3-20020aa7d703000000b0051495e8566cmr8524050edq.42.1686823212731; Thu, 15 Jun
 2023 03:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230615091757.24686-1-zhuyinbo@loongson.cn> <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
In-Reply-To: <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Z13wpOsj5GxkuwMK1D6N6=sArQ52yHjcdiEen=dUpjg@mail.gmail.com>
Message-ID: <CAAhV-H4Z13wpOsj5GxkuwMK1D6N6=sArQ52yHjcdiEen=dUpjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] soc: loongson2_pm: add power management support
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

I'm sorry I still have some comments.

On Thu, Jun 15, 2023 at 5:37=E2=80=AFPM zhuyinbo <zhuyinbo@loongson.cn> wro=
te:
>
>  From 6edcb9d6a1b18ccbecaf283b4f543afc9e7126d6 Mon Sep 17 00:00:00 2001
> From: Yinbo Zhu <zhuyinbo@loongson.cn>
> Date: Tue, 18 Apr 2023 14:18:00 +0800
> Subject: [PATCH v3 3/3] soc: loongson2_pm: add power management support
>
> The Loongson-2's power management controller was ACPI, supports ACPI
> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> controller support that base on dts for Loongson-2 series SoCs.
>
> Signed-off-by: Liu Yun <liuyun@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>   MAINTAINERS                         |   1 +
>   drivers/soc/loongson/Kconfig        |  10 ++
>   drivers/soc/loongson/Makefile       |   1 +
>   drivers/soc/loongson/loongson2_pm.c | 218 ++++++++++++++++++++++++++++
>   4 files changed, 230 insertions(+)
>   create mode 100644 drivers/soc/loongson/loongson2_pm.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bcd05f1fa5c1..7c4ad0cbaeff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12195,6 +12195,7 @@ M:      Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:    linux-pm@vger.kernel.org
>   S:    Maintained
>   F:    Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.=
yaml
> +F:     drivers/soc/loongson/loongson2_pm.c
>
>   LOONGSON-2 SOC SERIES PINCTRL DRIVER
>   M:    zhanghongchen <zhanghongchen@loongson.cn>
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 707f56358dc4..4f3ce9eb7520 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -16,3 +16,13 @@ config LOONGSON2_GUTS
>          SoCs. Initially only reading SVR and registering soc device are
>          supported. Other guts accesses, such as reading firmware configu=
ration
>          by default, should eventually be added into this driver as well.
> +
> +config LOONGSON2_PM
> +       bool "Loongson-2 SoC Power Management Controller Driver"
> +       depends on LOONGARCH && OF
> +       help
> +        The Loongson-2's power management controller was ACPI, supports =
ACPI
> +        S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Sus=
pend To
> +        Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up met=
hods
> +        (USB, GMAC, PWRBTN, etc.). This driver was to add power manageme=
nt
> +        controller support that base on dts for Loongson-2 series SoCs.
> diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefil=
e
> index 263c486df638..4118f50f55e2 100644
> --- a/drivers/soc/loongson/Makefile
> +++ b/drivers/soc/loongson/Makefile
> @@ -4,3 +4,4 @@
>   #
>
>   obj-$(CONFIG_LOONGSON2_GUTS)          +=3D loongson2_guts.o
> +obj-$(CONFIG_LOONGSON2_PM)             +=3D loongson2_pm.o
> diff --git a/drivers/soc/loongson/loongson2_pm.c
> b/drivers/soc/loongson/loongson2_pm.c
> new file mode 100644
> index 000000000000..287828413d72
> --- /dev/null
> +++ b/drivers/soc/loongson/loongson2_pm.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Loongson-2 PM Support
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/suspend.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/platform_device.h>
> +#include <asm/bootinfo.h>
> +#include <asm/suspend.h>
> +
> +#define LOONGSON2_PM1_CNT_REG          0x14
> +#define LOONGSON2_PM1_STS_REG          0x0c
> +#define LOONGSON2_PM1_ENA_REG          0x10
> +#define LOONGSON2_GPE0_STS_REG         0x28
> +#define LOONGSON2_GPE0_ENA_REG         0x2c
> +
> +#define LOONGSON2_PM1_PWRBTN_STS       BIT(8)
> +#define LOONGSON2_PM1_PCIEXP_WAKE_STS  BIT(14)
> +#define LOONGSON2_PM1_WAKE_STS         BIT(15)
> +#define LOONGSON2_PM1_CNT_INT_EN       BIT(0)
> +#define LOONGSON2_PM1_PWRBTN_EN                LOONGSON2_PM1_PWRBTN_STS
> +
> +static struct loongson2_pm {
> +       void __iomem                    *base;
> +       struct input_dev                *dev;
> +       bool                            suspended;
> +} loongson2_pm;
> +
> +#define loongson2_pm_readw(reg)                readw(loongson2_pm.base +=
 reg)
> +#define loongson2_pm_readl(reg)                readl(loongson2_pm.base +=
 reg)
> +#define loongson2_pm_writew(val, reg)  writew(val, loongson2_pm.base + r=
eg)
> +#define loongson2_pm_writel(val, reg)  writel(val, loongson2_pm.base + r=
eg)
> +
> +static void loongson2_pm_status_clear(void)
> +{
> +       u16 value;
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> +       value |=3D (LOONGSON2_PM1_PWRBTN_STS | LOONGSON2_PM1_PCIEXP_WAKE_=
STS |
> +                 LOONGSON2_PM1_WAKE_STS);
> +       loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
> +       loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG),
> +                           LOONGSON2_GPE0_STS_REG);
Long-line warnings is removed in latest kernel, so you don't need to split =
here.

> +}
> +
> +static void loongson2_power_button_irq_enable(void)

Using loongson2_pm_irq_enable is a little better.

> +{
> +       u16 value;
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_CNT_REG);
> +       value |=3D LOONGSON2_PM1_CNT_INT_EN;
> +       loongson2_pm_writew(value, LOONGSON2_PM1_CNT_REG);
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_ENA_REG);
> +       value |=3D LOONGSON2_PM1_PWRBTN_EN;
> +       loongson2_pm_writew(value, LOONGSON2_PM1_ENA_REG);
> +}
> +
> +static int loongson2_suspend_enter(suspend_state_t state)
> +{
> +       loongson2_pm_status_clear();
> +       loongarch_common_suspend();
> +       loongarch_suspend_enter();
> +       loongarch_common_resume();
> +       loongson2_power_button_irq_enable();
> +       pm_set_resume_via_firmware();
> +
> +       return 0;
> +}
> +
> +static int loongson2_suspend_begin(suspend_state_t state)
> +{
> +       pm_set_suspend_via_firmware();
> +
> +       return 0;
> +}
> +
> +static int loongson2_suspend_valid_state(suspend_state_t state)
> +{
> +       if (state =3D=3D PM_SUSPEND_MEM)
> +               return 1;
> +
> +       return 0;
"return (state =3D=3D PM_SUSPEND_MEM)" is enough.

Huacai
> +}
> +
> +static const struct platform_suspend_ops loongson2_suspend_ops =3D {
> +       .valid  =3D loongson2_suspend_valid_state,
> +       .begin  =3D loongson2_suspend_begin,
> +       .enter  =3D loongson2_suspend_enter,
> +};
> +
> +static int loongson2_power_button_init(struct device *dev, int irq)
> +{
> +       int ret;
> +       struct input_dev *button;
> +
> +       button =3D input_allocate_device();
> +       if (!dev)
> +               return -ENOMEM;
> +
> +       button->name =3D "Power Button";
> +       button->phys =3D "pm/button/input0";
> +       button->id.bustype =3D BUS_HOST;
> +       button->dev.parent =3D NULL;
> +       input_set_capability(button, EV_KEY, KEY_POWER);
> +
> +       ret =3D input_register_device(button);
> +       if (ret)
> +               goto free_dev;
> +
> +       dev_pm_set_wake_irq(&button->dev, irq);
> +       device_set_wakeup_capable(&button->dev, true);
> +       device_set_wakeup_enable(&button->dev, true);
> +
> +       loongson2_pm.dev =3D button;
> +       dev_info(dev, "Power Button: Init successful!\n");
> +
> +       return 0;
> +
> +free_dev:
> +       input_free_device(button);
> +
> +       return ret;
> +}
> +
> +static irqreturn_t loongson2_pm_irq_handler(int irq, void *dev_id)
> +{
> +       u16 status =3D loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> +
> +       if (!loongson2_pm.suspended && (status & LOONGSON2_PM1_PWRBTN_STS=
)) {
> +               pr_info("Power Button pressed...\n");
> +               input_report_key(loongson2_pm.dev, KEY_POWER, 1);
> +               input_sync(loongson2_pm.dev);
> +               input_report_key(loongson2_pm.dev, KEY_POWER, 0);
> +               input_sync(loongson2_pm.dev);
> +       }
> +
> +       loongson2_pm_status_clear();
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int __maybe_unused loongson2_pm_suspend(struct device *dev)
> +{
> +       loongson2_pm.suspended =3D true;
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused loongson2_pm_resume(struct device *dev)
> +{
> +       loongson2_pm.suspended =3D false;
> +
> +       return 0;
> +}
> +static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend,
> loongson2_pm_resume);
> +
> +static int loongson2_pm_probe(struct platform_device *pdev)
> +{
> +       int irq, retval;
> +       u32 suspend_addr;
> +       struct device *dev =3D &pdev->dev;
> +
> +       loongson2_pm.base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(loongson2_pm.base))
> +               return PTR_ERR(loongson2_pm.base);
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       if (!device_property_read_u32(dev, "suspend-address", &suspend_ad=
dr))
> +               loongson_sysconf.suspend_addr =3D (u64)phys_to_virt(suspe=
nd_addr);
> +       else
> +               dev_err(dev, "No suspend-address, could not support S3!\n=
");
> +
> +       if (loongson2_power_button_init(dev, irq))
> +               return -EINVAL;
> +
> +       retval =3D devm_request_irq(&pdev->dev, irq, loongson2_pm_irq_han=
dler,
> +                                 IRQF_SHARED, "pm_irq", &loongson2_pm);
> +       if (retval)
> +               return retval;
> +
> +       loongson2_power_button_irq_enable();
> +       loongson2_pm_status_clear();
> +
> +       if (loongson_sysconf.suspend_addr)
> +               suspend_set_ops(&loongson2_suspend_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id loongson2_pm_match[] =3D {
> +       { .compatible =3D "loongson,ls2k1000-pmc", },
> +       {},
> +};
> +
> +static struct platform_driver loongson2_pm_driver =3D {
> +       .driver =3D {
> +               .name =3D "ls2k-pm",
> +               .pm =3D &loongson2_pm_ops,
> +               .of_match_table =3D loongson2_pm_match,
> +       },
> +       .probe =3D loongson2_pm_probe,
> +};
> +module_platform_driver(loongson2_pm_driver);
> +
> +MODULE_DESCRIPTION("Loongson-2 PM driver");
> +MODULE_LICENSE("GPL");
> --
> 2.20.1
>
>
