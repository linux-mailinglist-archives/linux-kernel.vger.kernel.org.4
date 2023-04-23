Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCAD6EBCB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDWDiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:38:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797DF210E;
        Sat, 22 Apr 2023 20:38:03 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-541b69a8355so1131645eaf.2;
        Sat, 22 Apr 2023 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682221083; x=1684813083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/T5aAlGMmo9C6Jsr4unnjRckJPsX4dGyKjKrxTVfd8=;
        b=C6TvZTlDBCYgVqqa1iaiYaK3pUjUipxcqR1vQ4NuKh7cDQsPw0Ba52KZFdHmIAHoTE
         ir03Su2Mceds8CAxGzD7EE4IxdHdHnNDPD/9k1iE9R7kOAsrhC2yw2Oz3cK/rPn15cZm
         EAX2UjzJx1//GkJk0CtRoZFBos7fINozmnWKUBzo1OREgYEzI8dn7DMRsGNX+L1sgmrd
         q+RZ7+AY+1nCgkSF5fgMKwsRqXy/Ch9a3T/g+OHMbVdPl5Phj2kbl/7eiNoZyNhsNULt
         zBee3u1ZYLqfaSdfCVQNOJrqQjODhCfiW7QL4y/CnsKm2lFJZrxsnaDHBzzy82YI/yOX
         /QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682221083; x=1684813083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/T5aAlGMmo9C6Jsr4unnjRckJPsX4dGyKjKrxTVfd8=;
        b=QvYiqvA/ccHAipUfQJO7bUPZzNpRvBxlEErdPAfznRUs3D9s9+kkkXfSzjqLXE8drI
         /W03FiNHjdmIkDajUYzaSrVAg7M3aOUeuJpQiPcH+zzkIPy6jfOmFYx8obd9KE9jZpBb
         BgalAuBXLJwZk4JdxGNJF2hrumD6EuJKmDcTE3n5Ss/aihh2OKNbmlH2CZjoWAaSgarH
         4XGCHpLvhfnE9gYxUsWOJf/oXi7DXpmHlF5agEto9J8/x38hCHr7f5vgVMtY3ueM1tjK
         u4/yJoQaTvWx381vj49A5Pr9QauI1O3BzOr6hXsg+pxkIc8UQbhp2i0z5uXuMezli9wc
         kXlQ==
X-Gm-Message-State: AAQBX9dMTc/d6KZeTbVSBIk4+CYbsXcBy83g2Mbz9I4HjfN47h9npp7u
        m6zAxurkFQyagOR3yLrg2+XJiwMAIpsxkqlDR4M=
X-Google-Smtp-Source: AKy350Yasskar6meddRyWFoJ7dS1Wd5QiSExjAgbklhR3jAX2UysBkpD1FkAoOVkqejghzh2F4ZpmEMJ1+18T7//RSs=
X-Received: by 2002:a05:6808:f0b:b0:378:2df5:49f5 with SMTP id
 m11-20020a0568080f0b00b003782df549f5mr6229460oiw.2.1682221082605; Sat, 22 Apr
 2023 20:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230420110052.3182-1-minda.chen@starfivetech.com> <20230420110052.3182-7-minda.chen@starfivetech.com>
In-Reply-To: <20230420110052.3182-7-minda.chen@starfivetech.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Sun, 23 Apr 2023 11:37:51 +0800
Message-ID: <CAL411-ocXSpjBjFKN7wzV3skJ528kvUxci3JjQdqNfU+Hc23hQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] usb: cdns3: Add StarFive JH7110 USB driver
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 7:01=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
> Adds Specific Glue layer to support USB peripherals on
> StarFive JH7110 SoC.
> There is a Cadence USB3 core for JH7110 SoCs, the cdns
> core is the child of this USB wrapper module device.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

> ---
>  MAINTAINERS                        |   6 +
>  drivers/usb/cdns3/Kconfig          |  11 +
>  drivers/usb/cdns3/Makefile         |   1 +
>  drivers/usb/cdns3/cdns3-starfive.c | 390 +++++++++++++++++++++++++++++
>  drivers/usb/cdns3/core.h           |   3 +
>  5 files changed, 411 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0f755ba91b..3164a5cef6ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19976,6 +19976,12 @@ F:     Documentation/devicetree/bindings/phy/sta=
rfive,jh7110-usb-phy.yaml
>  F:     drivers/phy/starfive/phy-jh7110-pcie.c
>  F:     drivers/phy/starfive/phy-jh7110-usb.c
>
> +STARFIVE JH71X0 USB DRIVERS
> +M:     Minda Chen <minda.chen@starfivetech.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> +F:     drivers/usb/cdns3/cdns3-starfive.c
> +
>  STATIC BRANCH/CALL
>  M:     Peter Zijlstra <peterz@infradead.org>
>  M:     Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index b98ca0a1352a..0a514b591527 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -78,6 +78,17 @@ config USB_CDNS3_IMX
>
>           For example, imx8qm and imx8qxp.
>
> +config USB_CDNS3_STARFIVE
> +       tristate "Cadence USB3 support on StarFive SoC platforms"
> +       depends on ARCH_STARFIVE || COMPILE_TEST
> +       help
> +         Say 'Y' or 'M' here if you are building for StarFive SoCs
> +         platforms that contain Cadence USB3 controller core.
> +
> +         e.g. JH7110.
> +
> +         If you choose to build this driver as module it will
> +         be dynamically linked and module will be called cdns3-starfive.=
ko
>  endif
>
>  if USB_CDNS_SUPPORT
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 61edb2f89276..48dfae75b5aa 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -24,6 +24,7 @@ endif
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)               +=3D cdns3-pci-wrap.o
>  obj-$(CONFIG_USB_CDNS3_TI)                     +=3D cdns3-ti.o
>  obj-$(CONFIG_USB_CDNS3_IMX)                    +=3D cdns3-imx.o
> +obj-$(CONFIG_USB_CDNS3_STARFIVE)               +=3D cdns3-starfive.o
>
>  cdnsp-udc-pci-y                                        :=3D cdnsp-pci.o
>
> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3=
-starfive.c
> new file mode 100644
> index 000000000000..afe1c6652660
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-starfive.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Contr=
oller
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author:     Yanhong Wang <yanhong.wang@starfivetech.com>
> + * Author:     Mason Huo <mason.huo@starfivetech.com>
> + * Author:     Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/usb/otg.h>
> +#include "core.h"
> +
> +#define USB_STRAP_HOST                 BIT(17)
> +#define USB_STRAP_DEVICE               BIT(18)
> +#define USB_STRAP_MASK                 GENMASK(18, 16)
> +
> +#define USB_SUSPENDM_HOST              BIT(19)
> +#define USB_SUSPENDM_MASK              BIT(19)
> +#define CDNS_IRQ_WAKEUP_INDEX          3
> +
> +struct cdns_starfive {
> +       struct device *dev;
> +       struct phy *usb2_phy;
> +       struct phy *usb3_phy;
> +       struct regmap *stg_syscon;
> +       struct reset_control *resets;
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       enum phy_mode phy_mode;
> +       u32 stg_usb_mode;
> +};
> +
> +static int set_phy_power_on(struct cdns_starfive *data)
> +{
> +       int ret;
> +
> +       ret =3D phy_power_on(data->usb2_phy);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D phy_power_on(data->usb3_phy);
> +       if (ret)
> +               phy_power_off(data->usb2_phy);
> +
> +       return ret;
> +}
> +
> +static void cdns_mode_init(struct platform_device *pdev,
> +                          struct cdns_starfive *data)
> +{
> +       enum usb_dr_mode mode;
> +
> +       mode =3D usb_get_dr_mode(&pdev->dev);
> +
> +       switch (mode) {
> +       case USB_DR_MODE_HOST:
> +               regmap_update_bits(data->stg_syscon,
> +                                  data->stg_usb_mode,
> +                                  USB_STRAP_MASK,
> +                                  USB_STRAP_HOST);
> +               regmap_update_bits(data->stg_syscon,
> +                                  data->stg_usb_mode,
> +                                  USB_SUSPENDM_MASK,
> +                                  USB_SUSPENDM_HOST);
> +               data->phy_mode =3D PHY_MODE_USB_HOST;
> +               break;
> +
> +       case USB_DR_MODE_PERIPHERAL:
> +               regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +                                  USB_STRAP_MASK, USB_STRAP_DEVICE);
> +               regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +                                  USB_SUSPENDM_MASK, 0);
> +               data->phy_mode =3D PHY_MODE_USB_DEVICE;
> +               break;
> +
> +       case USB_DR_MODE_OTG:
> +               data->phy_mode =3D PHY_MODE_USB_OTG;
> +       default:
> +               break;
> +       }
> +}
> +
> +static int cdns_clk_rst_init(struct cdns_starfive *data)
> +{
> +       int ret;
> +
> +       ret =3D clk_bulk_prepare_enable(data->num_clks, data->clks);
> +       if (ret)
> +               return dev_err_probe(data->dev, ret,
> +                                    "failed to enable clocks\n");
> +
> +       ret =3D reset_control_deassert(data->resets);
> +       if (ret) {
> +               dev_err(data->dev, "failed to reset clocks\n");
> +               goto err_clk_init;
> +       }
> +
> +       return ret;
> +
> +err_clk_init:
> +       clk_bulk_disable_unprepare(data->num_clks, data->clks);
> +       return ret;
> +}
> +
> +static void cdns_clk_rst_deinit(struct cdns_starfive *data)
> +{
> +       reset_control_assert(data->resets);
> +       clk_bulk_disable_unprepare(data->num_clks, data->clks);
> +}
> +
> +static int cdns_starfive_phy_init(struct cdns_starfive *data)
> +{
> +       int ret;
> +
> +       ret =3D phy_init(data->usb2_phy);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D phy_init(data->usb3_phy);
> +       if (ret)
> +               goto err_phy3_init;
> +
> +       phy_set_mode(data->usb2_phy, data->phy_mode);
> +       phy_set_mode(data->usb3_phy, data->phy_mode);
> +
> +       ret =3D set_phy_power_on(data);
> +       if (ret)
> +               goto err_phy_power_on;
> +
> +       return 0;
> +
> +err_phy_power_on:
> +       phy_exit(data->usb3_phy);
> +err_phy3_init:
> +       phy_exit(data->usb2_phy);
> +       return ret;
> +}
> +
> +static void cdns_starfive_phy_deinit(struct cdns_starfive *data)
> +{
> +       phy_power_off(data->usb3_phy);
> +       phy_power_off(data->usb2_phy);
> +       phy_exit(data->usb3_phy);
> +       phy_exit(data->usb2_phy);
> +}
> +
> +static int cdns_starfive_platform_device_add(struct platform_device *pde=
v,
> +                                            struct cdns_starfive *data)
> +{
> +       struct platform_device *cdns3;
> +       struct resource cdns_res[CDNS_RESOURCES_NUM], *res;
> +       struct device *dev =3D &pdev->dev;
> +       const char *reg_name[CDNS_IOMEM_RESOURCES_NUM] =3D {"otg", "xhci"=
, "dev"};
> +       const char *irq_name[CDNS_IRQ_RESOURCES_NUM] =3D {"host", "periph=
eral", "otg", "wakeup"};
> +       int i, ret, res_idx =3D 0;
> +
> +       cdns3 =3D platform_device_alloc("cdns-usb3", PLATFORM_DEVID_AUTO)=
;
> +       if (!cdns3)
> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "couldn't alloc cdns3 usb device\n")=
;
> +
> +       cdns3->dev.parent =3D dev;
> +       memset(cdns_res, 0, sizeof(cdns_res));
> +
> +       for (i =3D 0; i < CDNS_IOMEM_RESOURCES_NUM; i++) {
> +               res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM=
, reg_name[i]);
> +               if (!res) {
> +                       ret =3D dev_err_probe(dev,
> +                                           -ENXIO,
> +                                           "couldn't get %s reg resource=
\n",
> +                                           reg_name[i]);
> +                       goto free_memory;
> +               }
> +               cdns_res[res_idx] =3D *res;
> +               res_idx++;
> +       }
> +
> +       for (i =3D 0; i < CDNS_IRQ_RESOURCES_NUM; i++) {
> +               if (i =3D=3D CDNS_IRQ_WAKEUP_INDEX) {
> +                       ret =3D platform_get_irq_byname_optional(pdev, ir=
q_name[i]);
> +                       if (ret < 0)
> +                               continue;
> +               } else {
> +                       ret =3D platform_get_irq_byname(pdev, irq_name[i]=
);
> +                       if (ret < 0) {
> +                               dev_err(dev, "couldn't get %s irq\n", irq=
_name[i]);
> +                               goto free_memory;
> +                       }
> +               }
> +               cdns_res[res_idx].start =3D ret;
> +               cdns_res[res_idx].end =3D ret;
> +               cdns_res[res_idx].flags =3D IORESOURCE_IRQ;
> +               cdns_res[res_idx].name =3D irq_name[i];
> +               res_idx++;
> +       }
> +
> +       ret =3D platform_device_add_resources(cdns3, cdns_res, res_idx);
> +       if (ret) {
> +               dev_err(dev, "couldn't add res to cdns3 device\n");
> +               goto free_memory;
> +       }
> +
> +       ret =3D platform_device_add(cdns3);
> +       if (ret) {
> +               dev_err(dev, "failed to register cdns3 device\n");
> +               goto free_memory;
> +       }
> +
> +       return ret;
> +free_memory:
> +       platform_device_put(cdns3);
> +       return ret;
> +}
> +
> +static int cdns_starfive_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct cdns_starfive *data;
> +       unsigned int args;
> +       int ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       data->dev =3D dev;
> +
> +       data->stg_syscon =3D
> +               syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
> +                                                    "starfive,stg-syscon=
", 1, &args);
> +
> +       if (IS_ERR(data->stg_syscon))
> +               return dev_err_probe(dev, PTR_ERR(data->stg_syscon),
> +                                    "Failed to parse starfive,stg-syscon=
\n");
> +
> +       data->stg_usb_mode =3D args;
> +
> +       data->num_clks =3D devm_clk_bulk_get_all(data->dev, &data->clks);
> +       if (data->num_clks < 0)
> +               return dev_err_probe(data->dev, -ENODEV,
> +                                    "Failed to get clocks\n");
> +
> +       data->resets =3D devm_reset_control_array_get_exclusive(data->dev=
);
> +       if (IS_ERR(data->resets))
> +               return dev_err_probe(data->dev, PTR_ERR(data->resets),
> +                                    "Failed to get resets");
> +
> +       data->usb2_phy =3D devm_phy_optional_get(dev, "usb2");
> +       if (IS_ERR(data->usb2_phy))
> +               return dev_err_probe(dev, PTR_ERR(data->usb2_phy),
> +                                   "Failed to parse usb2 PHY\n");
> +
> +       data->usb3_phy =3D devm_phy_optional_get(dev, "usb3");
> +       if (IS_ERR(data->usb3_phy))
> +               return dev_err_probe(dev, PTR_ERR(data->usb3_phy),
> +                                   "Failed to parse usb3 PHY\n");
> +
> +       cdns_mode_init(pdev, data);
> +
> +       ret =3D cdns_clk_rst_init(data);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cdns_starfive_phy_init(data);
> +       if (ret) {
> +               dev_err(dev, "Failed to init PHY\n");
> +               goto err_clk_init;
> +       }
> +
> +       ret =3D cdns_starfive_platform_device_add(pdev, data);
> +       if (ret) {
> +               dev_err(dev, "Failed to create children\n");
> +               goto err_phy_init;
> +       }
> +
> +       device_set_wakeup_capable(dev, true);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       dev_info(dev, "usb mode %d probe success\n", data->phy_mode);
> +
> +       return 0;
> +
> +err_phy_init:
> +       cdns_starfive_phy_deinit(data);
> +err_clk_init:
> +       cdns_clk_rst_deinit(data);
> +       return ret;
> +}
> +
> +static int cdns_starfive_remove_core(struct device *dev, void *c)
> +{
> +       struct platform_device *pdev =3D to_platform_device(dev);
> +
> +       platform_device_unregister(pdev);
> +
> +       return 0;
> +}
> +
> +static int cdns_starfive_remove(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct cdns_starfive *data =3D dev_get_drvdata(dev);
> +
> +       pm_runtime_get_sync(dev);
> +       device_for_each_child(dev, NULL, cdns_starfive_remove_core);
> +
> +       cdns_starfive_phy_deinit(data);
> +       cdns_clk_rst_deinit(data);
> +       pm_runtime_disable(dev);
> +       pm_runtime_put_noidle(dev);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int cdns_starfive_resume(struct device *dev)
> +{
> +       struct cdns_starfive *data =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D clk_bulk_prepare_enable(data->num_clks, data->clks);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D reset_control_deassert(data->resets);
> +       if (ret) {
> +               clk_bulk_disable_unprepare(data->num_clks, data->clks);
> +               return ret;
> +       }
> +
> +       ret =3D cdns_starfive_phy_init(data);
> +       if (ret)
> +               cdns_clk_rst_deinit(data);
> +
> +       return ret;
> +}
> +
> +static int cdns_starfive_suspend(struct device *dev)
> +{
> +       struct cdns_starfive *data =3D dev_get_drvdata(dev);
> +
> +       cdns_starfive_phy_deinit(data);
> +       cdns_clk_rst_deinit(data);
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops cdns_starfive_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume, N=
ULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(cdns_starfive_suspend, cdns_starfive_resu=
me)
> +};
> +
> +static const struct of_device_id cdns_starfive_of_match[] =3D {
> +       { .compatible =3D "starfive,jh7110-usb", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cdns_starfive_of_match);
> +
> +static struct platform_driver cdns_starfive_driver =3D {
> +       .probe          =3D cdns_starfive_probe,
> +       .remove         =3D cdns_starfive_remove,
> +       .driver         =3D {
> +               .name   =3D "cdns3-starfive",
> +               .of_match_table =3D cdns_starfive_of_match,
> +               .pm     =3D &cdns_starfive_pm_ops,
> +       },
> +};
> +module_platform_driver(cdns_starfive_driver);
> +
> +MODULE_ALIAS("platform:cdns3-starfive");
> +MODULE_AUTHOR("YanHong Wang <yanhong.wang@starfivetech.com>");
> +MODULE_AUTHOR("Mason Huo <mason.huo@starfivetech.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 StarFive Glue Layer");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 2d332a788871..8d44ab504898 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -38,6 +38,9 @@ struct cdns_role_driver {
>  };
>
>  #define CDNS_XHCI_RESOURCES_NUM        2
> +#define CDNS_IOMEM_RESOURCES_NUM       3
> +#define CDNS_IRQ_RESOURCES_NUM         4
> +#define CDNS_RESOURCES_NUM     (CDNS_IOMEM_RESOURCES_NUM + CDNS_IRQ_RESO=
URCES_NUM)
>
>  struct cdns3_platform_data {
>         int (*platform_suspend)(struct device *dev,
> --
> 2.17.1
>
