Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E86A850D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCBPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:16:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB64ECCF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:16:49 -0800 (PST)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F182A3F22E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677770206;
        bh=4N07li82obP0Hkm70LaKXQjir2DSxDLKh74uJ58iLoE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dfOfYjlNDCGBpSpa1+VT+SGA4OvNoFhyFocRU+Ro15w+UOUAwnWsGGSkQ0GDz8B+d
         4W0uhbPVdxnHoo4orkyMDhpR0gLGHbbQnixBzNIwA5wAkiWGcyQwcLEgyn7OX3o+cO
         QjQc0d4s+CYMprPOe0ho0HzoXfIVfnEZl8CVyKFGHxqSlpOT+0bExpwJ8rFlTi0EZ/
         /UAPhcAnfhOXJ3kubUJXfGXYiFhh4ikHgXRGj4Jsx7DdgCTc4hdBWu1aod+hJQp9ZZ
         4WoiaveqGytIeJgCL8zWN8Aw6hO2+jbmcZVianNg9+jsMEdc+zwl6B1+ui1d7OnCuN
         kbaY9igI5uKVw==
Received: by mail-qk1-f199.google.com with SMTP id q25-20020a37f719000000b00742bfdd63ecso6677976qkj.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677770206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N07li82obP0Hkm70LaKXQjir2DSxDLKh74uJ58iLoE=;
        b=VKpN8INSKH++CDR5NWwxDGIXrjV7BkP/iKmecgQYgG5UfHnO18ogeGtFJMXd0HNjGw
         sc3uakqemcOrFzwEEMyPZlmRuMo/ZSaR1WTa9SuPdUol25O8HCG1eQoMLDbHFrPrHUg4
         na3W0nso/++XE9S9vCj9tTIC8DAs+7CPPBztViAmJ9huPYvm93+5qMnVKosITT8Ujizs
         RXqI20yvOwfHd5+nRDbHNRXyHaFt7wiHRqdmHwuPcjmRtEkgo3D3qzW0o3L4Ap3HhPeG
         Oc/yFmm1FSXC3Pcl7XvXY+TwvRnosqxa0SKb4bd/DZr1PKDWQ2Wbqt72/Bz9OEhySZxJ
         Iftw==
X-Gm-Message-State: AO0yUKUl8yGAD0exhSjq/pk+ggt9PhdR0lm6Hoa1WZilxMvwSFIlJJ/9
        oYeoWPx96KUFbUzPqIrzf/jLRhBR9B786E8cMuJjAMXHDSrw2S9oJjzZIFAf+9HuJd7ceV4U6TL
        6lUruILevcI6V4FicQxcu/lB/y0MVwdX/BDceS+UmWOVHHmJtXP3U/Orjyg==
X-Received: by 2002:ac8:435d:0:b0:3bf:c62b:4651 with SMTP id a29-20020ac8435d000000b003bfc62b4651mr2830139qtn.3.1677770205659;
        Thu, 02 Mar 2023 07:16:45 -0800 (PST)
X-Google-Smtp-Source: AK7set9P9qEdPX03UeOBRsfVx/0HELk92uKiacehr2aZRU4XptLaHnvSXz+FLPXn36TXEmRxEXBQ2umO0ThbkivuWFs=
X-Received: by 2002:ac8:435d:0:b0:3bf:c62b:4651 with SMTP id
 a29-20020ac8435d000000b003bfc62b4651mr2830122qtn.3.1677770205382; Thu, 02 Mar
 2023 07:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com> <20230221083323.302471-4-xingyu.wu@starfivetech.com>
In-Reply-To: <20230221083323.302471-4-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 2 Mar 2023 16:16:29 +0100
Message-ID: <CAJM55Z9aXPzwT3vuJFjF+oD1enULzNzny-RiNuomx2=Fv+=a-w@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: starfive: Add StarFive JH7110
 System-Top-Group clock driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 09:38, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add driver for the StarFive JH7110 System-Top-Group clock controller.
>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Again, this driver is almost identical to the first STGCRG driver I
pushed. You really ought to have kept the authorship like Hal Feng did
for the SYSCRG and AONCRG drivers.

> ---
>  drivers/clk/starfive/Kconfig                  |  11 ++
>  drivers/clk/starfive/Makefile                 |   1 +
>  .../clk/starfive/clk-starfive-jh7110-stg.c    | 176 ++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 2aa664f2cdee..a462b6e53543 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -42,3 +42,14 @@ config CLK_STARFIVE_JH7110_AON
>         help
>           Say yes here to support the always-on clock controller on the
>           StarFive JH7110 SoC.
> +
> +config CLK_STARFIVE_JH7110_STG
> +       tristate "StarFive JH7110 System-Top-Group clock support"
> +       depends on CLK_STARFIVE_JH7110_SYS
> +       select AUXILIARY_BUS
> +       select CLK_STARFIVE_JH71X0
> +       select RESET_STARFIVE_JH7110
> +       default CLK_STARFIVE_JH7110_SYS

The JH7110 boots perfectly fine without this driver built in, so just do
default m if ARCH_STARFIVE

> +       help
> +         Say yes here to support the System-Top-Group clock controller
> +         on the StarFive JH7110 SoC.
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index f3df7d957b1e..b81e97ee2659 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO) += clk-starfive-jh7100-audio.o
>
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)  += clk-starfive-jh7110-sys.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)  += clk-starfive-jh7110-aon.o
> +obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)  += clk-starfive-jh7110-stg.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
> new file mode 100644
> index 000000000000..a39d2fdb8011
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 System-Top-Group Clock Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.

Removing my copyright line is definitely not ok.

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +#include "clk-starfive-jh71x0.h"
> +
> +/* external clocks */
> +#define JH7110_STGCLK_OSC                      (JH7110_STGCLK_END + 0)
> +#define JH7110_STGCLK_HIFI4_CORE               (JH7110_STGCLK_END + 1)
> +#define JH7110_STGCLK_STG_AXIAHB               (JH7110_STGCLK_END + 2)
> +#define JH7110_STGCLK_USB_125M                 (JH7110_STGCLK_END + 3)
> +#define JH7110_STGCLK_CPU_BUS                  (JH7110_STGCLK_END + 4)
> +#define JH7110_STGCLK_HIFI4_AXI                        (JH7110_STGCLK_END + 5)
> +#define JH7110_STGCLK_NOCSTG_BUS               (JH7110_STGCLK_END + 6)
> +#define JH7110_STGCLK_APB_BUS                  (JH7110_STGCLK_END + 7)
> +#define JH7110_STGCLK_EXT_END                  (JH7110_STGCLK_END + 8)
> +
> +static const struct jh71x0_clk_data jh7110_stgclk_data[] = {
> +       /* hifi4 */
> +       JH71X0_GATE(JH7110_STGCLK_HIFI4_CLK_CORE, "hifi4_clk_core", 0,
> +                   JH7110_STGCLK_HIFI4_CORE),
> +       /* usb */
> +       JH71X0_GATE(JH7110_STGCLK_USB0_APB, "usb0_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_UTMI_APB, "usb0_utmi_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_AXI, "usb0_axi", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GDIV(JH7110_STGCLK_USB0_LPM, "usb0_lpm", 0, 2, JH7110_STGCLK_OSC),
> +       JH71X0_GDIV(JH7110_STGCLK_USB0_STB, "usb0_stb", 0, 4, JH7110_STGCLK_OSC),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_APP_125, "usb0_app_125", 0, JH7110_STGCLK_USB_125M),
> +       JH71X0__DIV(JH7110_STGCLK_USB0_REFCLK, "usb0_refclk", 2, JH7110_STGCLK_OSC),
> +       /* pci-e */
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_AXI_MST0, "pcie0_axi_mst0", 0,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_APB, "pcie0_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_TL, "pcie0_tl", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_AXI_MST0, "pcie1_axi_mst0", 0,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_APB, "pcie1_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_TL, "pcie1_tl", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE01_SLV_DEC_MAINCLK, "pcie01_slv_dec_mainclk",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_STG_AXIAHB),
> +       /* security */
> +       JH71X0_GATE(JH7110_STGCLK_SEC_HCLK, "sec_hclk", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_SEC_MISCAHB, "sec_miscahb", 0, JH7110_STGCLK_STG_AXIAHB),
> +       /* stg mtrx */
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_MAIN, "mtrx_grp0_main",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_CPU_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_BUS, "mtrx_grp0_bus",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_NOCSTG_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_STG, "mtrx_grp0_stg",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_MAIN, "mtrx_grp1_main",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_CPU_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_BUS, "mtrx_grp1_bus",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_NOCSTG_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_STG, "mtrx_grp1_stg",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_HIFI, "mtrx_grp1_hifi",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_HIFI4_AXI),
> +       /* e24_rvpi */
> +       JH71X0_GDIV(JH7110_STGCLK_E2_RTC, "e2_rtc", 0, 24, JH7110_STGCLK_OSC),
> +       JH71X0_GATE(JH7110_STGCLK_E2_CORE, "e2_core",
> +                   CLK_IGNORE_UNUSED, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_E2_DBG, "e2_dbg", 0, JH7110_STGCLK_STG_AXIAHB),
> +       /* dw_sgdma1p */
> +       JH71X0_GATE(JH7110_STGCLK_DMA1P_AXI, "dma1p_axi", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
> +};

Like the SYSCRG and AONCRG driver in Hal Feng's series I only added
the CLK_IGNORE_UNUSED flag as a placeholder for clocks where I didn't
yet know if
they were ok to turn off when unused. Please go through the clocks and
figure out if they're critical and mark them with CLK_IS_CRITICAL or
they are fine to turn off and just remove the CLK_IGNORE_UNUSED flag.

> +static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *data)
> +{
> +       struct jh71x0_clk_priv *priv = data;
> +       unsigned int idx = clkspec->args[0];
> +
> +       if (idx < JH7110_STGCLK_END)
> +               return &priv->reg[idx].hw;
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static int jh7110_stgcrg_probe(struct platform_device *pdev)
> +{
> +       struct jh71x0_clk_priv *priv;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, reg, JH7110_STGCLK_END),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev = &pdev->dev;
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       dev_set_drvdata(priv->dev, (void *)(&priv->base));
> +
> +       for (idx = 0; idx < JH7110_STGCLK_END; idx++) {
> +               u32 max = jh7110_stgclk_data[idx].max;
> +               struct clk_parent_data parents[4] = {};
> +               struct clk_init_data init = {
> +                       .name = jh7110_stgclk_data[idx].name,
> +                       .ops = starfive_jh71x0_clk_ops(max),
> +                       .parent_data = parents,
> +                       .num_parents =
> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
> +                       .flags = jh7110_stgclk_data[idx].flags,
> +               };
> +               struct jh71x0_clk *clk = &priv->reg[idx];
> +               unsigned int i;
> +               char *fw_name[JH7110_STGCLK_EXT_END - JH7110_STGCLK_END] = {
> +                       "osc",
> +                       "hifi4_core",
> +                       "stg_axiahb",
> +                       "usb_125m",
> +                       "cpu_bus",
> +                       "hifi4_axi",
> +                       "nocstg_bus",
> +                       "apb_bus"
> +               };
> +
> +               for (i = 0; i < init.num_parents; i++) {
> +                       unsigned int pidx = jh7110_stgclk_data[idx].parents[i];
> +
> +                       if (pidx < JH7110_STGCLK_END)
> +                               parents[i].hw = &priv->reg[pidx].hw;
> +                       else if (pidx < JH7110_STGCLK_EXT_END)
> +                               parents[i].fw_name = fw_name[pidx - JH7110_STGCLK_END];
> +               }
> +
> +               clk->hw.init = &init;
> +               clk->idx = idx;
> +               clk->max_div = max & JH71X0_CLK_DIV_MASK;
> +
> +               ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_get, priv);
> +       if (ret)
> +               return ret;
> +
> +       return jh7110_reset_controller_register(priv, "reset-stg", 2);
> +}
> +
> +static const struct of_device_id jh7110_stgcrg_match[] = {
> +       { .compatible = "starfive,jh7110-stgcrg" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_stgcrg_match);
> +
> +static struct platform_driver jh7110_stgcrg_driver = {
> +       .probe = jh7110_stgcrg_probe,
> +       .driver = {
> +               .name = "clk-starfive-jh7110-stg",
> +               .of_match_table = jh7110_stgcrg_match,
> +       },
> +};
> +module_platform_driver(jh7110_stgcrg_driver);
> +
> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");

Again
MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");

> +MODULE_DESCRIPTION("StarFive JH7110 System-Top-Group clock driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
