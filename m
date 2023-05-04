Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA966F6602
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjEDHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDHov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:44:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035D9D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:44:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f139de8cefso7507504e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683186288; x=1685778288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfamGK95L+shtKWfvXNNPR9RRxOgFB5QM2YbhoEVVqE=;
        b=hOLEbElJK9OzG8WkSCfjbVqPnwn5RdI3RWFtetVBN9XwSmMh3prbEmmw9yM0cg7O0f
         sunVqwCpEoPRUqLrOq83GXoTSezM3eV91r1GDUq5jfNBOawtQBYgYYUkXJj1t9d674rU
         J3J8HNoV0fTmlvap2nFYhdCraYJBl01VjNm2nQK5B0glW5rYO6rzG8AaUzfcFsnFEcom
         Lf0NeVZXGnQVHLEHXhKRhyKtzDbFeWdA5jl+UO+vUFP1HRi1FAsCnM/GADp4PxUO1Vf7
         ur017G3Mn520usYlTlz0T9S3udcstZyFoQJQt9wI2C1I79Ub97V5xxcuVs3fsQi0OJzF
         hnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683186288; x=1685778288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfamGK95L+shtKWfvXNNPR9RRxOgFB5QM2YbhoEVVqE=;
        b=bOTLFrYrXK9vo+cGfuRJovEdQ8RSe86VxNBthNff6H2T+F5/HPUP00g1yJxe5S52CZ
         l8T4QvMWU2+KzdEef2yuK0hSLualhDLW+s8fg3HGYQPJmQ5jNvwu+JlXipbiZzKYLrdI
         zfDT8FiSb/UiFK+2AchizdDh62kgrJwLd5Ud5U8MzspfzQT0jhZzruuMOduqmHX25IJ/
         6Ke7HMk3CiXeX9+jr0itsLwtMarbjAO/UHU6JSmuhEMd15DvHCQwtQ3o4ElYdVjNoDs6
         6MLs04kdnfqai9pql961Kh+dlmCjeHaTV5F8FKq4FGbKsg+BHcn8bnU7JMyVYE2eIS8P
         OpvQ==
X-Gm-Message-State: AC+VfDxF/tY4T/ZhzaIBli+zezo/jxEZel1SUQH7JarjcAXteRaJcbto
        K2F/xa+0gqx9b90pMDjH7yMYaA==
X-Google-Smtp-Source: ACHHUZ6OyuDrnuI6B2dXfAvUFDvrQvW82yL68F6vo71nrIvDxoYl8ED8ckvgYzcT6aimdn+S9ZiMwg==
X-Received: by 2002:a05:6512:31c8:b0:4ec:83fd:1599 with SMTP id j8-20020a05651231c800b004ec83fd1599mr1377305lfe.33.1683186288063;
        Thu, 04 May 2023 00:44:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y15-20020ac255af000000b004f00333804esm4300355lfg.176.2023.05.04.00.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:44:47 -0700 (PDT)
Message-ID: <4c09119e-2a18-d98f-d3ee-9b88e1b87d8e@linaro.org>
Date:   Thu, 4 May 2023 09:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V3 2/3] clk: qcom: videocc-sm8450: Add video clock
 controller driver for SM8450
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_jkona@quicinc.com
References: <20230503105937.24911-1-quic_tdas@quicinc.com>
 <20230503105937.24911-3-quic_tdas@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230503105937.24911-3-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.05.2023 12:59, Taniya Das wrote:
> Add support for the video clock controller driver for peripheral clock
> clients to be able to request for video cc clocks.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
> Changes since V2:
>  - Update the header file name to match the latest upstream header
>    files.
> 
> Changes since V1:
>  - Use DT indices instead of fw_name.
>  - Replace pm_runtime_enable with devm_pm_runtime_enable.
>  - Change license to GPL from GPL V2.
> 
>  drivers/clk/qcom/Kconfig          |   9 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-sm8450.c | 459 ++++++++++++++++++++++++++++++
>  3 files changed, 469 insertions(+)
>  create mode 100644 drivers/clk/qcom/videocc-sm8450.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 12be3e2371b3..927aa5983464 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -962,4 +962,13 @@ config CLK_GFM_LPASS_SM8250
>  	  Support for the Glitch Free Mux (GFM) Low power audio
>            subsystem (LPASS) clocks found on SM8250 SoCs.
>  
> +config SM_VIDEOCC_8450
> +	tristate "SM8450 Video Clock Controller"
> +	select SM_GCC_8450
> +	select QCOM_GDSC
> +	help
> +	  Support for the video clock controller on Qualcomm Technologies, Inc.
> +	  SM8450 devices.
> +	  Say Y if you want to support video devices and functionality such as
> +	  video encode/decode.
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 9ff4c373ad95..1960ad8e8713 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -127,6 +127,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
> +obj-$(CONFIG_SM_VIDEOCC_8450) += videocc-sm8450.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>  obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
>  obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> new file mode 100644
> index 000000000000..ce0ab764eb35
> --- /dev/null
> +++ b/drivers/clk/qcom/videocc-sm8450.c
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_VIDEO_CC_PLL0_OUT_MAIN,
> +	P_VIDEO_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct pll_vco lucid_evo_vco[] = {
> +	{ 249600000, 2020000000, 0 },
> +};
> +
> +static const struct alpha_pll_config video_cc_pll0_config = {
> +	.l = 0x1E,
lowercase hex, please, everywhere

> +	.alpha = 0x0,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x32AA299C,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +};
[...]

> +static int video_cc_sm8450_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	devm_pm_runtime_enable(&pdev->dev);
Please check the return value here and bail out early on failure.

> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
> +	if (IS_ERR(regmap)) {
> +		pm_runtime_put(&pdev->dev);
> +		return PTR_ERR(regmap);
> +	}
> +
> +	clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> +	clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	video_cc_ahb_clk
> +	 *	video_cc_sleep_clk
> +	 *	video_cc_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
> +
> +	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver video_cc_sm8450_driver = {
> +	.probe = video_cc_sm8450_probe,
> +	.driver = {
> +		.name = "video_cc-sm8450",
> +		.of_match_table = video_cc_sm8450_match_table,
> +	},
> +};
> +
> +static int __init video_cc_sm8450_init(void)
> +{
> +	return platform_driver_register(&video_cc_sm8450_driver);
> +}
> +subsys_initcall(video_cc_sm8450_init);
module_platform_driver?

Venus won't probe earlier

Konrad
> +
> +static void __exit video_cc_sm8450_exit(void)
> +{
> +	platform_driver_unregister(&video_cc_sm8450_driver);
> +}
> +module_exit(video_cc_sm8450_exit);
> +
> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8450 Driver");
> +MODULE_LICENSE("GPL");
