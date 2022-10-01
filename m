Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480315F1A80
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJAHLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:11:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6495EDE6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:11:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 203so7660470ybc.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tIQI0W9g6hyEvwhihGkuekIq503oR5dN7OHUfiOl914=;
        b=ljXonJZitHR+gg35SjsW5EHgcJ2d5sasSU5i4EPIvrxQ6MNm9W99KJRLyk0nx28Ff9
         TaD0GRITtoCxkzNsZcgpIQkEYGhYk0CqTqdnOLLsFhQzdvzBEYIudhofhdn1gHeUZfs3
         4cf/PjhvewK/ORqroVausmwhONtsMaSYN6Nw5f1CkY3ld01XBJFK+4iW6/3qOHNiiigL
         VQwhsbnIgm2a2VokNL/ktSHXUVOBMtMCL1oWAOb4eio+4ohVqtlI5VMzD0C6O52OnKxS
         3dNusauNEgxOoUxKxVQjpsyyVY8agR6Vpk/qV9kxoMSh59lSyAE5GQRFFON+Nk9XFBXH
         wW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tIQI0W9g6hyEvwhihGkuekIq503oR5dN7OHUfiOl914=;
        b=EnJZDhIIhrL8VTtNE2p9ea5qO/xWf7hLmcOd84R0dHg+VN4cHfhr1D6UbeVUuUtbKg
         1ZjxThCpIN+4kA3eooW0cg7Wa6QabG6TlJQlzr29dGvezVaDcKUIgQp7JoCKiMGB0aKO
         v/0X0e/A0FtM2oUoA8r/fgcVeXxSj92uHsoZxkHOaUXHIGGIptIzUt91DbZB2o3gZjtH
         Rmybpx/12PXg/Psrl7NmVY68gm5dWCwDhpv6IY3iLE8zWLDpTeJuKKP7MxtuBHpbZyYI
         +ihHaEICd28DHPUCqJFoIOAMFPtx781VWC3z77hvlUpWmLcf8Z7p3AceYVGOxKQUZQQ1
         1b5Q==
X-Gm-Message-State: ACrzQf1zpZPxvTlObNVVmkP/wFAdx1WEx6onL82AMQ8CunYIeNHYa/l+
        luJewmES9PV8WTiGA+0G/56nlH23SGUhS7asEqdQug==
X-Google-Smtp-Source: AMsMyM43wb5Q3pxcVTEyK5+Qm18AtY2Prv8YODqylNKf4JY0VWXzmT0CxgPSt3wIv9ham1+Z36RsXXIOU/cFn/s46yA=
X-Received: by 2002:a25:a502:0:b0:6bc:2835:a88a with SMTP id
 h2-20020a25a502000000b006bc2835a88amr11280082ybi.15.1664608269799; Sat, 01
 Oct 2022 00:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030403.27659-1-quic_molvera@quicinc.com> <20221001030403.27659-4-quic_molvera@quicinc.com>
In-Reply-To: <20221001030403.27659-4-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:10:58 +0300
Message-ID: <CAA8EJpqh83jB-32f8QCSjDtCrxtVtoFf7JVQgQ3s60cz=WT2Jg@mail.gmail.com>
Subject: Re: [PATCH 3/5] clk: qcom: Add QDU1000 and QRU1000 GCC support
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:05, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> From: Taniya Das <quic_tdas@quicinc.com>
>
> Add Global Clock Controller (GCC) support for QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |    8 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/clk-branch.c   |    5 +
>  drivers/clk/qcom/clk-branch.h   |    2 +
>  drivers/clk/qcom/gcc-qdru1000.c | 2649 +++++++++++++++++++++++++++++++
>  5 files changed, 2665 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-qdru1000.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1cf1ef70e347..195c018c6f87 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -696,6 +696,14 @@ config SM_GCC_8450
>           Say Y if you want to use peripheral devices such as UART,
>           SPI, I2C, USB, SD/UFS, PCIe etc.
>
> +config QDRU_GCC_1000
> +       tristate "QDU1000/QRU1000 Global Clock Controller"
> +       select QCOM_GDSC
> +       help
> +         Support for the global clock controller on QDU1000 and
> +         QRU1000 devices. Say Y if you want to use peripheral
> +         devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
> +
>  config SM_GPUCC_6350
>         tristate "SM6350 Graphics Clock Controller"
>         select SM_GCC_6350
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index fbcf04073f07..080253a338e7 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
>  obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
>  obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
>  obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
> +obj-$(CONFIG_QDRU_GCC_1000) += gcc-qdru1000.o
>  obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>  obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>  obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index f869fc6aaed6..b5dc1f4ef277 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
>  #include <linux/kernel.h>
> @@ -56,6 +57,10 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
>
>         if (enabling) {
>                 val &= mask;
> +
> +               if (br->halt_check == BRANCH_HALT_INVERT)
> +                       return (val & BRANCH_CLK_OFF) == BRANCH_CLK_OFF;
> +
>                 return (val & BRANCH_CLK_OFF) == 0 ||
>                         val == BRANCH_NOC_FSM_STATUS_ON;
>         } else {
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 17a58119165e..4ac1debeb91e 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved. */
>
>  #ifndef __QCOM_CLK_BRANCH_H__
>  #define __QCOM_CLK_BRANCH_H__
> @@ -33,6 +34,7 @@ struct clk_branch {
>  #define BRANCH_HALT_ENABLE_VOTED       (BRANCH_HALT_ENABLE | BRANCH_VOTED)
>  #define BRANCH_HALT_DELAY              2 /* No bit to check; just delay */
>  #define BRANCH_HALT_SKIP               3 /* Don't check halt bit */
> +#define BRANCH_HALT_INVERT             4 /* Invert logic for halt bit */
>
>         struct clk_regmap clkr;
>  };

I'm tempted to ask to move these two chunks to a separate commit.

> diff --git a/drivers/clk/qcom/gcc-qdru1000.c b/drivers/clk/qcom/gcc-qdru1000.c
> new file mode 100644
> index 000000000000..4bc54f7b43a0
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-qdru1000.c
> @@ -0,0 +1,2649 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-qdru1000.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "reset.h"
> +
> +enum {
> +       P_BI_TCXO,
> +       P_GCC_GPLL0_OUT_EVEN,
> +       P_GCC_GPLL0_OUT_MAIN,
> +       P_GCC_GPLL1_OUT_MAIN,
> +       P_GCC_GPLL2_OUT_MAIN,
> +       P_GCC_GPLL3_OUT_MAIN,
> +       P_GCC_GPLL4_OUT_MAIN,
> +       P_GCC_GPLL5_OUT_MAIN,
> +       P_GCC_GPLL6_OUT_MAIN,
> +       P_GCC_GPLL7_OUT_MAIN,
> +       P_GCC_GPLL8_OUT_MAIN,
> +       P_PCIE_0_PHY_AUX_CLK,
> +       P_PCIE_0_PIPE_CLK,
> +       P_SLEEP_CLK,
> +       P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
> +
> +static struct clk_alpha_pll gcc_gpll0 = {
> +       .offset = 0x0,
> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +       .clkr = {
> +               .enable_reg = 0x62018,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data){
> +                       .name = "gcc_gpll0",
> +                       .parent_data = &(const struct clk_parent_data){
> +                               .fw_name = "bi_tcxo",

New drivers are requested to use .index rather than .fw_name.

> +                       },
> +                       .num_parents = 1,
> +                       .ops = &clk_alpha_pll_fixed_lucid_evo_ops,
> +               },
> +       },
> +};
> +
> +static const struct clk_div_table post_div_table_gcc_gpll0_out_even[] = {
> +       { 0x1, 2 },
> +       { }

No need for a sentinel here

> +};
> +

[skipped]


> +
> +static int gcc_qdru1000_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       regmap = qcom_cc_map(pdev, &gcc_qdru1000_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       /* Update FORCE_MEM_CORE_ON for gcc_pcie_0_mstr_axi_clk */
> +       regmap_update_bits(regmap, 0x9d024, BIT(14), BIT(14));
> +
> +       ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +                                      ARRAY_SIZE(gcc_dfs_clocks));
> +       if (ret)
> +               return ret;
> +
> +       ret = qcom_cc_really_probe(pdev, &gcc_qdru1000_desc, regmap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register GCC clocks\n");
> +               return ret;
> +       }

if (ret)
    return dev_err_probe(....);

> +
> +       dev_info(&pdev->dev, "Registered GCC clocks\n");


No need to spam here.

> +
> +       return ret;
> +}
> +
> +static struct platform_driver gcc_qdru1000_driver = {
> +       .probe = gcc_qdru1000_probe,
> +       .driver = {
> +               .name = "gcc-qdru1000",
> +               .of_match_table = gcc_qdru1000_match_table,
> +       },
> +};
> +
> +static int __init gcc_qdru1000_init(void)
> +{
> +       return platform_driver_register(&gcc_qdru1000_driver);
> +}
> +subsys_initcall(gcc_qdru1000_init);
> +
> +static void __exit gcc_qdru1000_exit(void)
> +{
> +       platform_driver_unregister(&gcc_qdru1000_driver);
> +}
> +module_exit(gcc_qdru1000_exit);
> +
> +MODULE_DESCRIPTION("QTI GCC QDRU1000 Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
