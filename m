Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE062BC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiKPLqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiKPLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D553EF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:29:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f27so43386783eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2SoQ9ygrZxwElHRWkPB1O298Abhbc3Q5HFt/q0VeiA=;
        b=IYsoU9rTX3q/Ch3uBQqDPTTBKcrKSRMXsBg0wKmgopzfRB8wJ0+X6X76I0S5IzhbZW
         +uW9lZcZnqhzmGZ/U1mMKmPTcTcJ6bFCd2XNp4Z7WJ7/XL593bCPdZB5HZpOFEgiD5Ws
         SCBYPz41H7C3qorpHggHwKsJ5KJHpruFCMg2y4XsOq6NEi9LVG2T14VCoszJdBHTSOGe
         yGQ7qX5xEsriUBCaOW4eQslJvl7ICuMWRORaWmmKnyy5rZuk+LfZnQtEPyQZdCVaRYel
         TE2hkJRY2DfcXel5uaob9oimPTr3HH90xEV+Te3CRbRc7jP7+hcQLPGybU2lR3zLO6Z4
         tlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q2SoQ9ygrZxwElHRWkPB1O298Abhbc3Q5HFt/q0VeiA=;
        b=K1Qr+hw8xwJWYSvUisnvF/fdSNxZFQW4kGnRAzKuhq1Elks0LJYwoi/VErteRmLKR+
         DH16FexvJvqQaR+PtkHNlOPrAIMA5G6wluMhZBZIW4+t5eDZ4T5rr/AfDmFlb/BLqKtT
         5Rt2uxi0GWR5M3iff+0nR62WUKo8jW8/wPBxHKDuuqgj/BRZ0O2tUJ8dGGZdfqgB+1kz
         cKC8iL49jesw9HNHei7gku8uOldDenrbqCQdSsiTTPk/xZP3Rb2or2av7WtkaFeo+gQA
         dJFd8zXtDIkAAo7Hwh9e+2VLj6fk+GxgpwP8bOsgcHNQy/FRpG5U9B5atJ6D+JmEOzSF
         BH+g==
X-Gm-Message-State: ANoB5pmgVukINxIQ6j4JQVVGSYuAqObr0DpC8Jb/WUHN4ZLdXyMPqX11
        J9obDOT1Icl1emCZ8+nXGH3/kmbLPGv4CdwY
X-Google-Smtp-Source: AA0mqf60i7cUpvPkeAwL3bCmZ525anP932HOm6rh+XeoERV8Whmxj6lqEGbCjFpf3ySWITwX3L5f5g==
X-Received: by 2002:a17:906:6c81:b0:7a6:ea24:7b01 with SMTP id s1-20020a1709066c8100b007a6ea247b01mr16249762ejr.410.1668598179517;
        Wed, 16 Nov 2022 03:29:39 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id i20-20020a50fd14000000b004618a89d273sm7434538eds.36.2022.11.16.03.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:29:38 -0800 (PST)
Message-ID: <af7c814a-a82d-199a-7968-243bebae1db3@linaro.org>
Date:   Wed, 16 Nov 2022 12:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 9/9] clk: qcom: Add TCSR clock driver for SM8550
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-10-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116104716.2583320-10-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 11:47, Abel Vesa wrote:
> The TCSR clock controller found on SM8550 provides refclks
> for PCIE, USB and UFS. Add clock driver for it.
> 
> This patch is based on initial code downstream.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/clk/qcom/Kconfig         |   7 ++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/tcsrcc-sm8550.c | 193 +++++++++++++++++++++++++++++++
>   3 files changed, 201 insertions(+)
>   create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 7186faf70562..653049b08a25 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -788,6 +788,13 @@ config SM_GPUCC_8350
>   	  Say Y if you want to support graphics controller devices and
>   	  functionality such as 3D graphics.
>   
> +config SM_TCSRCC_8550
> +	tristate "SM8550 TCSR Clock Controller"
> +	select QCOM_GDSC
> +	help
> +	  Support for the TCSR clock controller on SM8550 devices.
> +	  Say Y if you want to use peripheral devices such as SD/UFS.
> +
>   config SM_VIDEOCC_8150
>   	tristate "SM8150 Video Clock Controller"
>   	select SM_GCC_8150
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dc4b803d3f3d..17d878482a45 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>   obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>   obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
>   obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
> +obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>   obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>   obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/tcsrcc-sm8550.c b/drivers/clk/qcom/tcsrcc-sm8550.c
> new file mode 100644
> index 000000000000..3e6756da1e83
> --- /dev/null
> +++ b/drivers/clk/qcom/tcsrcc-sm8550.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,tcsrcc-sm8550.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "common.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_BI_TCXO_PAD,
> +};
> +
> +static struct clk_branch tcsr_pcie_0_clkref_en = {
> +	.halt_reg = 0x15100,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15100,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_pcie_0_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch tcsr_pcie_1_clkref_en = {
> +	.halt_reg = 0x15114,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15114,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_pcie_1_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch tcsr_ufs_clkref_en = {
> +	.halt_reg = 0x15110,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15110,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_ufs_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch tcsr_ufs_pad_clkref_en = {
> +	.halt_reg = 0x15104,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15104,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_ufs_pad_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch tcsr_usb2_clkref_en = {
> +	.halt_reg = 0x15118,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15118,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_usb2_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO_PAD,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch tcsr_usb3_clkref_en = {
> +	.halt_reg = 0x15108,
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x15108,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "tcsr_usb3_clkref_en",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap *tcsr_cc_sm8550_clocks[] = {
> +	[TCSR_PCIE_0_CLKREF_EN] = &tcsr_pcie_0_clkref_en.clkr,
> +	[TCSR_PCIE_1_CLKREF_EN] = &tcsr_pcie_1_clkref_en.clkr,
> +	[TCSR_UFS_CLKREF_EN] = &tcsr_ufs_clkref_en.clkr,
> +	[TCSR_UFS_PAD_CLKREF_EN] = &tcsr_ufs_pad_clkref_en.clkr,
> +	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
> +	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
> +};
> +
> +static const struct regmap_config tcsr_cc_sm8550_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x2f000,
> +	.fast_io = true,
> +};
> +
> +static const struct qcom_cc_desc tcsr_cc_sm8550_desc = {
> +	.config = &tcsr_cc_sm8550_regmap_config,
> +	.clks = tcsr_cc_sm8550_clocks,
> +	.num_clks = ARRAY_SIZE(tcsr_cc_sm8550_clocks),
> +};
> +
> +static const struct of_device_id tcsr_cc_sm8550_match_table[] = {
> +	{ .compatible = "qcom,sm8550-tcsrcc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tcsr_cc_sm8550_match_table);
> +
> +static int tcsr_cc_sm8550_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &tcsr_cc_sm8550_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return qcom_cc_really_probe(pdev, &tcsr_cc_sm8550_desc, regmap);
> +}
> +
> +static struct platform_driver tcsr_cc_sm8550_driver = {
> +	.probe = tcsr_cc_sm8550_probe,
> +	.driver = {
> +		.name = "tcsr_cc-sm8550",
> +		.of_match_table = tcsr_cc_sm8550_match_table,
> +	},
> +};
> +
> +static int __init tcsr_cc_sm8550_init(void)
> +{
> +	return platform_driver_register(&tcsr_cc_sm8550_driver);
> +}
> +subsys_initcall(tcsr_cc_sm8550_init);
> +
> +static void __exit tcsr_cc_sm8550_exit(void)
> +{
> +	platform_driver_unregister(&tcsr_cc_sm8550_driver);
> +}
> +module_exit(tcsr_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI TCSRCC SM8550 Driver");
> +MODULE_LICENSE("GPL");
