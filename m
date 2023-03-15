Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF36BB4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjCONgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjCONgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:36:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CDA98EA1;
        Wed, 15 Mar 2023 06:36:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ja10so10365150plb.5;
        Wed, 15 Mar 2023 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OHXFBpvtWGJG+u8SOqErFKXvCBGW4eaVjbx5BMO3Io=;
        b=hqh64HPYvJeP1WzwBd5OC4QhvoQ+QN/E/wPRjxL/C4MBuW88XnmRxu3H9uGzkJ8n/q
         YkpYpMjBLCx1o3b7TVtVzLSrVVJL2FCbTdpjAXPfGnmg31lvC+FaOJO1F3UD9GVvsA1r
         Z5H/vlOFrfEsco9qt59pURE7hTukPdcOL9bxw+oRIIcemFLIfeuRD4CjxUdESBxOmA8F
         zXhKZSRauk8ZdGIu1S1mtmlx8e/1ARbdQamQCN82s5QdLHtMqCiVcNQVe8ZpUpwm3Lc0
         4rT0a6LkGSNhOYQ3s4bL8jy9yCn2cyogc/m2CadIDQKecFGmVSmMlkSJy89I0CNejaoR
         NScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OHXFBpvtWGJG+u8SOqErFKXvCBGW4eaVjbx5BMO3Io=;
        b=Oo5jB93vDUliTXWB8Cp1UBrQyfqmk7KytrcLdMNxE5jGK3TDcFIUZtjuNbPrUREk8c
         eH60dTZSGS5u38e4LHeRJFr08Zn49piNElhF9L7GzEn/HfV4QvToizlDftYXsowv4Kh7
         zIuKpMNi2BuDXgLkJ4EuKRgJtLZQU8WSL31/lnftPOehBJHVMpIqffjKDpCxqhQ/h1Q+
         GRr9wlZ5XHcRRRGmYzg569D1nacISZRwmisgpJGgXhYdvHlxhWiNg69fBsAT2+xIQ4us
         aKNIP+sDJitZhnAtu6Ya87/S12nFAtyCfGL77D/rKDgpmKT3hT8YyGt1oMkv7ZRz82t4
         VZSg==
X-Gm-Message-State: AO0yUKWn2T89VcIG66c9KBbd4/QFNXqF9bUGwgE6k3D2A0xi02V3iLvw
        v8wj//CObqpGq7b9kVT+OniTnhY9Rm3OLHeaDDc=
X-Google-Smtp-Source: AK7set8MOYNa49u0p/Z54edFUbkIZwJrnnJ8YlDN+jrsUaHE+uIKDN0s1htL2w2bkc6v9xf/3H9su5O/1mKcBgdyrcI=
X-Received: by 2002:a17:902:dac3:b0:1a0:503a:2a42 with SMTP id
 q3-20020a170902dac300b001a0503a2a42mr1236616plx.12.1678887359976; Wed, 15 Mar
 2023 06:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230315104411.73614-1-minda.chen@starfivetech.com> <20230315104411.73614-5-minda.chen@starfivetech.com>
In-Reply-To: <20230315104411.73614-5-minda.chen@starfivetech.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 15 Mar 2023 21:32:57 +0800
Message-ID: <CAD-N9QX92GXMUG_RRAinna1tcrMFVWQo_Xxz0rOjAJ5Nitte7g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] usb: cdns3: add StarFive JH7110 USB driver.
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
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.

On Wed, Mar 15, 2023 at 6:48=E2=80=AFPM Minda Chen <minda.chen@starfivetech=
.com> wrote:
>
> There is a Cadence USB3 core for JH7110 SoCs, the cdns
> core is the child of this USB wrapper module device.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  MAINTAINERS                        |   7 +
>  drivers/usb/cdns3/Kconfig          |  11 ++
>  drivers/usb/cdns3/Makefile         |   1 +
>  drivers/usb/cdns3/cdns3-starfive.c | 305 +++++++++++++++++++++++++++++
>  4 files changed, 324 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4263c005e45c..c530c966ab26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19985,6 +19985,13 @@ F:     Documentation/devicetree/bindings/phy/sta=
rfive,jh7110-usb-pcie-phy.yaml
>  F:     drivers/phy/starfive/phy-jh7110-pcie.c
>  F:     drivers/phy/starfive/phy-jh7110-usb.c
>
> +STARFIVE JH71X0 USB DRIVERS
> +M:     Emil Renner Berthing <kernel@esmil.dk>
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
> index 000000000000..a99f98f85235
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-starfive.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Contr=
oller
> + *
> + * Copyright (C) 2022 Starfive, Inc.
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
> +
> +#define USB_SUSPENDM_BYPS              BIT(20)
> +#define USB_REFCLK_MODE                        BIT(23)
> +#define USB_PLL_EN                     BIT(22)
> +#define USB_PDRSTN_SPLIT               BIT(17)
> +
> +#define PCIE_CKREF_SRC_MASK            GENMASK(19, 18)
> +#define PCIE_CLK_SEL_MASK              GENMASK(21, 20)
> +#define PCIE_PHY_MODE                  BIT(20)
> +#define PCIE_PHY_MODE_MASK             GENMASK(21, 20)
> +#define PCIE_USB3_BUS_WIDTH_MASK       GENMASK(3, 2)
> +#define PCIE_USB3_RATE_MASK            GENMASK(6, 5)
> +#define PCIE_USB3_RX_STANDBY_MASK      BIT(7)
> +#define PCIE_USB3_PHY_ENABLE           BIT(4)
> +
> +struct cdns_starfive {
> +       struct device *dev;
> +       struct regmap *stg_syscon;
> +       struct regmap *sys_syscon;
> +       struct reset_control *resets;
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       u32 sys_offset;
> +       u32 stg_offset_4;
> +       u32 stg_offset_196;
> +       u32 stg_offset_328;
> +       u32 stg_offset_500;
> +       bool usb2_only;
> +};
> +
> +static int cdns_mode_init(struct platform_device *pdev,
> +                               struct cdns_starfive *data, const char **=
out_mode)
> +{
> +       struct device_node *child;
> +       const char *dr_mode =3D NULL;
> +
> +       child =3D of_get_compatible_child(pdev->dev.of_node, "cdns,usb3")=
;
> +       if (!child) {
> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                       "Failed to find child node\n");
> +       }
> +
> +       /* Init usb 2.0 utmi phy */
> +       regmap_update_bits(data->stg_syscon, data->stg_offset_4,
> +               USB_SUSPENDM_BYPS, USB_SUSPENDM_BYPS);
> +       regmap_update_bits(data->stg_syscon, data->stg_offset_4,
> +               USB_PLL_EN, USB_PLL_EN);
> +       regmap_update_bits(data->stg_syscon, data->stg_offset_4,
> +               USB_REFCLK_MODE, USB_REFCLK_MODE);
> +
> +       if (!of_find_property(child, "cdns3,usb3-phy", NULL)) {
> +               /* Disconnect usb 3.0 phy mode */
> +               regmap_update_bits(data->sys_syscon, data->sys_offset,
> +                       USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
> +               data->usb2_only =3D 1;
> +       } else {
> +               /* Config usb 3.0 pipe phy */
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_196=
,
> +                       PCIE_CKREF_SRC_MASK, 0);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_196=
,
> +                       PCIE_CLK_SEL_MASK, 0);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_328=
,
> +                       PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_500=
,
> +                       PCIE_USB3_BUS_WIDTH_MASK, 0);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_500=
,
> +                       PCIE_USB3_RATE_MASK, 0);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_500=
,
> +                       PCIE_USB3_RX_STANDBY_MASK, 0);
> +               regmap_update_bits(data->stg_syscon, data->stg_offset_500=
,
> +                       PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
> +
> +               /* Connect usb 3.0 phy mode */
> +               regmap_update_bits(data->sys_syscon, data->sys_offset,
> +                       USB_PDRSTN_SPLIT, 0);
> +       }
> +
> +       if (!of_property_read_string(child, "dr_mode", &dr_mode)) {
> +               if (!strcmp(dr_mode, "host")) {
> +                       regmap_update_bits(data->stg_syscon,
> +                               data->stg_offset_4,
> +                               USB_STRAP_MASK,
> +                               USB_STRAP_HOST);
> +                       regmap_update_bits(data->stg_syscon,
> +                               data->stg_offset_4,
> +                               USB_SUSPENDM_MASK,
> +                               USB_SUSPENDM_HOST);
> +               } else if (!strcmp(dr_mode, "peripheral")) {
> +                       regmap_update_bits(data->stg_syscon, data->stg_of=
fset_4,
> +                               USB_STRAP_MASK, USB_STRAP_DEVICE);
> +                       regmap_update_bits(data->stg_syscon, data->stg_of=
fset_4,
> +                               USB_SUSPENDM_MASK, 0);
> +               }
> +       }
> +
> +       if (out_mode)
> +               *out_mode =3D dr_mode;
> +
> +       return 0;
> +}
> +
> +static int cdns_clk_rst_init(struct cdns_starfive *data)
> +{
> +       int ret;
> +
> +       data->num_clks =3D devm_clk_bulk_get_all(data->dev, &data->clks);
> +       if (data->num_clks < 0)
> +               return dev_err_probe(data->dev, -ENODEV,
> +                       "Failed to get clocks\n");
> +
> +       ret =3D clk_bulk_prepare_enable(data->num_clks, data->clks);
> +       if (ret)
> +               return dev_err_probe(data->dev, ret,
> +                       "failed to enable clocks\n");
> +
> +       data->resets =3D devm_reset_control_array_get_exclusive(data->dev=
);
> +       if (IS_ERR(data->resets)) {
> +               ret =3D dev_err_probe(data->dev, PTR_ERR(data->resets),
> +                       "Failed to get resets");
> +               goto err_clk_init;
> +       }
> +
> +       ret =3D reset_control_deassert(data->resets);
> +       if (ret) {
> +               ret =3D dev_err_probe(data->dev, ret,
> +                       "failed to reset clocks\n");
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
> +static int cdns_starfive_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D pdev->dev.of_node;
> +       struct cdns_starfive *data;
> +       unsigned int args[4];
> +       const char *dr_mode;
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
> +       data->stg_syscon =3D syscon_regmap_lookup_by_phandle_args(pdev->d=
ev.of_node,
> +               "starfive,stg-syscon", 4, args);
> +
> +       if (IS_ERR(data->stg_syscon))
> +               return dev_err_probe(dev, PTR_ERR(data->stg_syscon),
> +                       "Failed to parse starfive,stg-syscon\n");
> +
> +       data->stg_offset_4 =3D args[0];
> +       data->stg_offset_196 =3D args[1];
> +       data->stg_offset_328 =3D args[2];
> +       data->stg_offset_500 =3D args[3];
> +
> +       data->sys_syscon =3D syscon_regmap_lookup_by_phandle_args(pdev->d=
ev.of_node,
> +               "starfive,sys-syscon", 1, args);
> +       if (IS_ERR(data->sys_syscon))
> +               return dev_err_probe(dev, PTR_ERR(data->sys_syscon),
> +                       "Failed to parse starfive,sys-syscon\n");
> +
> +       data->sys_offset =3D args[0];
> +
> +       ret =3D cdns_mode_init(pdev, data, &dr_mode);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cdns_clk_rst_init(data);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_platform_populate(node, NULL, NULL, dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to create children=
\n");

For this error handling, you need to add some paired undo operations
for cdns_clk_rst_init, i.e., reset_control_assert and
clk_bulk_disable_unprepare.

> +
> +       device_set_wakeup_capable(dev, true);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       dev_info(dev, "usb mode %s %s probe success\n",
> +               dr_mode ? dr_mode : "unknown", data->usb2_only ? "2.0" : =
"3.0");
> +
> +       return 0;
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
> +       reset_control_assert(data->resets);
> +       clk_bulk_disable_unprepare(data->num_clks, data->clks);
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
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int cdns_starfive_suspend(struct device *dev)
> +{
> +       struct cdns_starfive *data =3D dev_get_drvdata(dev);
> +
> +       clk_bulk_disable_unprepare(data->num_clks, data->clks);
> +       reset_control_assert(data->resets);
> +
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
> --
> 2.17.1
>
