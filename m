Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81574EBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGKKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGKKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:50:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5510E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:50:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so8541574e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072643; x=1691664643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsGi/AQ335IJGc0/2vjFnmujn9OC9GFlHTvDDV21i/A=;
        b=f7135Ulf7UCPzIlDgN8JSjgnk07yDLhUb2aPUrU1eDBE0N0EcRLNRFMZBBXLp5Ccip
         bL67M06ldcD1RLf7M2jrS8WszIOqJbnXpGz9xpPY+T+pyTi1rCmL4yQS4ps36Xn6zfJu
         sWOugdafZ4eqTVEn9FuMecWADk0o2FA/Qh0+DTtDiDGVEaCkTKMj3NFWa3q9kIwDYsfa
         mFSh1RfVgY/dYGdZ7uvgwxolsNzcCAqgboq4vY0KyC/SxF5iCCo7ZDSN3A4LF4b7laHA
         KT4xXDjYyGp7wJHtGqGE1W+SQOlvY8+kT1NGRpolGFZCrg1o3qN6IFvfb8EmzStLHZ7x
         rIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072643; x=1691664643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsGi/AQ335IJGc0/2vjFnmujn9OC9GFlHTvDDV21i/A=;
        b=d3LXJnQdNu6wUT8uDAzt8vFBean7YW9mt1AiW4VIosWD43G/b4oQuores6sNUyCAxt
         I6aXEl3WQOlfjGuwMSVBrGz0cHPi0BAKdNF+p00rCH55cjLNe4FPPaAh7FjvWpR0Yzia
         uVAmNBRVjy9cW+/Dz/cPfh2R+9i0WVHP/tpvZCqg/7qjLtrMsATUcLHyVViJHon1OVlE
         CuRERMe2fNG1qSvsxksrXI7+5AIxOunnKdQu569WCw2uOY2ctEBAD1b5kUdA3pnsMpFb
         aRohK1OBLjlonMFihGIj1bNYu+VLqYjcNmo8kbyWZPAdNcuPoMxR2FTPOvc7kqHx3Ivw
         92tg==
X-Gm-Message-State: ABy/qLbTY1slKSEpeBz0rLhd4Llva3AoYstXgTpqZfrCiD5ZxhgBSR8w
        K6i4gK1N03SUEXswtkkgqsraqw==
X-Google-Smtp-Source: APBJJlEptb+2D+nj3iuROjTRLvM3l5qghg6uMyWCLwNxDusZhnMczLeb8VnyZfZojAIEfAgXqwB6Yg==
X-Received: by 2002:a05:6512:534:b0:4fb:242:6e05 with SMTP id o20-20020a056512053400b004fb02426e05mr12578120lfc.3.1689072643173;
        Tue, 11 Jul 2023 03:50:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r6-20020ac25a46000000b004fbae25fcc4sm268584lfn.61.2023.07.11.03.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:50:42 -0700 (PDT)
Message-ID: <31075ecb-7e3c-302f-a668-b872017e19b3@linaro.org>
Date:   Tue, 11 Jul 2023 13:50:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-5-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711093529.18355-5-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 12:35, Devi Priya wrote:
> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/Kconfig         |    6 +
>   drivers/clk/qcom/Makefile        |    1 +
>   drivers/clk/qcom/nsscc-ipq9574.c | 3080 ++++++++++++++++++++++++++++++
>   3 files changed, 3087 insertions(+)
>   create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 263e55d75e3f..5556063d204f 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -195,6 +195,12 @@ config IPQ_GCC_9574
>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>   	  of ipq9574.
>   
> +config IPQ_NSSCC_9574
> +	tristate "IPQ9574 NSS Clock Controller"
> +	depends on IPQ_GCC_9574
> +	help
> +	  Support for NSS clock controller on ipq9574 devices.
> +
>   config MSM_GCC_8660
>   	tristate "MSM8660 Global Clock Controller"
>   	depends on ARM || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e6e294274c35..8ba882186bff 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>   obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
> +obj-$(CONFIG_IPQ_NSSCC_9574)	+= nsscc-ipq9574.o
>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c b/drivers/clk/qcom/nsscc-ipq9574.c
> new file mode 100644
> index 000000000000..b6bed0d24059
> --- /dev/null
> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
> @@ -0,0 +1,3080 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
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
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_BIAS_PLL_CC_CLK,
> +	DT_BIAS_PLL_NSS_NOC_CLK,
> +	DT_BIAS_PLL_UBI_NC_CLK,
> +	DT_GCC_GPLL0_OUT_AUX,
> +	DT_UNIPHY0_GCC_RX_CLK,
> +	DT_UNIPHY0_GCC_TX_CLK,
> +	DT_UNIPHY1_GCC_RX_CLK,
> +	DT_UNIPHY1_GCC_TX_CLK,
> +	DT_UNIPHY2_GCC_RX_CLK,
> +	DT_UNIPHY2_GCC_TX_CLK,
> +	DT_XO,
> +};
> +
> +enum {
> +	P_BIAS_PLL_CC_CLK,
> +	P_BIAS_PLL_NSS_NOC_CLK,
> +	P_BIAS_PLL_UBI_NC_CLK,
> +	P_GCC_GPLL0_OUT_AUX,
> +	P_UBI32_PLL_OUT_MAIN,
> +	P_UNIPHY0_GCC_RX_CLK,
> +	P_UNIPHY0_GCC_TX_CLK,
> +	P_UNIPHY1_GCC_RX_CLK,
> +	P_UNIPHY1_GCC_TX_CLK,
> +	P_UNIPHY2_GCC_RX_CLK,
> +	P_UNIPHY2_GCC_TX_CLK,
> +	P_XO,
> +};
> +
> +static const struct alpha_pll_config ubi32_pll_config = {
> +	.l = 0x3e,
> +	.alpha = 0x6666,
> +	.config_ctl_val = 0x200d4aa8,
> +	.config_ctl_hi_val = 0x3c,
> +	.main_output_mask = BIT(0),
> +	.aux_output_mask = BIT(1),
> +	.pre_div_val = 0x0,
> +	.pre_div_mask = BIT(12),
> +	.post_div_val = 0x0,
> +	.post_div_mask = GENMASK(9, 8),
> +	.alpha_en_mask = BIT(24),
> +	.test_ctl_val = 0x1c0000c0,
> +	.test_ctl_hi_val = 0x4000,
> +};
> +
> +static struct clk_alpha_pll ubi32_pll_main = {
> +	.offset = 0x28000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "ubi32_pll_main",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_XO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll_postdiv ubi32_pll = {
> +	.offset = 0x28000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> +	.width = 2,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "ubi32_pll",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&ubi32_pll_main.clkr.hw
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_ro_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +

[skipped the rest, LGTM]

  +
> +static int nss_cc_ipq9574_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct qcom_cc_desc nsscc_ipq9574_desc = nss_cc_ipq9574_desc;
> +
> +	regmap = qcom_cc_map(pdev, &nsscc_ipq9574_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* SW Workaround for UBI Huayra PLL */
> +	regmap_update_bits(regmap, 0x2800C, BIT(26), BIT(26));

Can we directly set the correct value via ubi32_pll_config.test_ctl_val ?

> +
> +	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
> +
> +	return qcom_cc_really_probe(pdev, &nsscc_ipq9574_desc, regmap);
> +}
> +
> +static struct platform_driver nss_cc_ipq9574_driver = {
> +	.probe = nss_cc_ipq9574_probe,
> +	.driver = {
> +		.name = "qcom,nsscc-ipq9574",
> +		.of_match_table = nss_cc_ipq9574_match_table,
> +	},
> +};
> +
> +static int __init nss_cc_ipq9574_init(void)
> +{
> +	return platform_driver_register(&nss_cc_ipq9574_driver);
> +}
> +subsys_initcall(nss_cc_ipq9574_init);
> +
> +static void __exit nss_cc_ipq9574_exit(void)
> +{
> +	platform_driver_unregister(&nss_cc_ipq9574_driver);
> +}
> +module_exit(nss_cc_ipq9574_exit);

module_platform_driver ?

> +
> +MODULE_DESCRIPTION("QTI NSS_CC IPQ9574 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

