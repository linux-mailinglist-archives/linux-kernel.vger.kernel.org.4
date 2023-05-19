Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35C2709CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjESQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjESQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:52:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1159D2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:52:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso3995559e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515135; x=1687107135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DjgA1oSFnHQ4T6jrg+cwQvWM2kbJwi4Mht8bmer9w4=;
        b=bD5SZuxbEmenh+bIZ9h7qXdIyWVefZ/663ljisl0IiiYIlre6Eo5AcRKIL5SfF8UFt
         Y5cp/rZkyH0wtkvf+Ec/mop9IBVz8dNg9tATgCuNQZCG0k+bWamEtt3zd50+7pCZU3xL
         wDBsIy0q/eUcbMMBK5oj9cODU16IoYnOFgYEpKqjrcac6TgQEZUO9ZaRUXmGY01o/eTh
         VJZvvhGiT2sq6JW4vxM2nlZKCOnoR4hfLrcx74dzK/OZF1hrHO2FKUtuF5vxEOmvSgVZ
         6LqioT2CnphXAe9kg+6bqSVnQnATy5kx/1ZcRS0r6uOWRcZtNoWnrMfnKM3jyxJuiujb
         J9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515135; x=1687107135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DjgA1oSFnHQ4T6jrg+cwQvWM2kbJwi4Mht8bmer9w4=;
        b=EyLdhtcKb/rrAc9Bmz6KmG4WGS/t9Pd942TDMn7obJ1Qasb+xEZqEjLUY/m7c030tX
         uojxW4NS4Sb8+4MwytcARbOWyeLmvMtw1KcpH5WjE+v/RcLU1hp7BxR97nMSjjYUG73o
         YTDK/YkIdIEgcEhC9/Ax7xqhaDEah7uShoFNfDNkySqr1WZ+VKiZRW5iSajqFwokhv8d
         OMAhROZmAQJ7v20t6sZf9TtPc4GTpfmLQm7A5lNQYCKDB/kqbrw8ddEykDnHeT/nM32R
         Q2flJK2koanxcl9MFadLmHw2D+zCKPUGsvXG0BDz4GK2ivFK9cJX0/23SjRbqrfBiQQP
         ZN1w==
X-Gm-Message-State: AC+VfDy4Ze2iMamoNE1plbureC8TZkpWPnz+wm37NyvWcjiTp9gFeNHw
        3oUSUc4i0a65Q1LxWtepZ+rMIg==
X-Google-Smtp-Source: ACHHUZ6YOnVvDEC7VEmTfNh32G3NHcYUKKtzhFaBOKXNc9qp7TPU42iCrIiTIu5+W5aG+vTZHFl5/A==
X-Received: by 2002:a19:f00b:0:b0:4ed:bf01:3ff3 with SMTP id p11-20020a19f00b000000b004edbf013ff3mr801227lfc.43.1684515134862;
        Fri, 19 May 2023 09:52:14 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id s18-20020ac25fb2000000b004edb8fac1cesm648518lfe.215.2023.05.19.09.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:52:14 -0700 (PDT)
Message-ID: <f78d73b3-5cec-ca0e-fceb-b70f52fee29b@linaro.org>
Date:   Fri, 19 May 2023 18:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] clk: qcom: camcc-sm8550: Add camera clock controller
 driver for SM8550
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-4-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519155602.6642-4-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 17:56, Jagadeesh Kona wrote:
> Add support for the camera clock controller for camera clients to be
> able to request for camcc clocks on SM8550 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |    7 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-sm8550.c | 3572 +++++++++++++++++++++++++++++++
>  3 files changed, 3580 insertions(+)
>  create mode 100644 drivers/clk/qcom/camcc-sm8550.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 6bb9b4aff047..c8eccd428736 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -700,6 +700,13 @@ config SM_CAMCC_8450
>  	  Support for the camera clock controller on SM8450 devices.
>  	  Say Y if you want to support camera devices and camera functionality.
>  
> +config SM_CAMCC_8550
> +	tristate "SM8550 Camera Clock Controller"
> +	select SM_GCC_8550
> +	help
> +	  Support for the camera clock controller on SM8550 devices.
> +	  Say Y if you want to support camera devices and camera functionality.
> +
>  config SM_DISPCC_6115
>  	tristate "SM6115 Display Clock Controller"
>  	depends on SM_GCC_6115
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f0b95fc217aa..2b1fcd5c920a 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
>  obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>  obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
> +obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
>  obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>  obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>  obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
> diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
> new file mode 100644
> index 000000000000..2c3d2436da0f
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sm8550.c
> @@ -0,0 +1,3572 @@
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
> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_BI_TCXO_AO,
> +	DT_SLEEP_CLK,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_CAM_CC_PLL0_OUT_EVEN,
> +	P_CAM_CC_PLL0_OUT_MAIN,
> +	P_CAM_CC_PLL0_OUT_ODD,
> +	P_CAM_CC_PLL10_OUT_EVEN,
> +	P_CAM_CC_PLL11_OUT_EVEN,
> +	P_CAM_CC_PLL12_OUT_EVEN,
While it makes sense for a computer, I think it would make more
sense to keep the >=10 entries after 9

> +	P_CAM_CC_PLL1_OUT_EVEN,
> +	P_CAM_CC_PLL2_OUT_EVEN,
> +	P_CAM_CC_PLL2_OUT_MAIN,
> +	P_CAM_CC_PLL3_OUT_EVEN,
> +	P_CAM_CC_PLL4_OUT_EVEN,
> +	P_CAM_CC_PLL5_OUT_EVEN,
> +	P_CAM_CC_PLL6_OUT_EVEN,
> +	P_CAM_CC_PLL7_OUT_EVEN,
> +	P_CAM_CC_PLL8_OUT_EVEN,
> +	P_CAM_CC_PLL9_OUT_EVEN,
> +	P_CAM_CC_PLL9_OUT_ODD,
> +	P_SLEEP_CLK,
> +};
> +
> +static const struct pll_vco lucid_ole_vco[] = {
> +	{ 249600000, 2300000000, 0 },
> +};
> +
> +static const struct pll_vco rivian_ole_vco[] = {
> +	{ 777000000, 1285000000, 0 },
> +};
> +
> +static const struct alpha_pll_config cam_cc_pll0_config = {
> +	.l = 0x4400003E,
Lowercase hex, everywhere, please.

> +	.alpha = 0x8000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00182261,
> +	.config_ctl_hi1_val = 0x82AA299C,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000003,
> +	.test_ctl_hi1_val = 0x00009000,
> +	.test_ctl_hi2_val = 0x00000034,
> +	.user_ctl_val = 0x00008400,
> +	.user_ctl_hi_val = 0x00000005,
> +};
> +
[...]

> +
> +	clk_lucid_ole_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll10, regmap, &cam_cc_pll10_config);
Same as the first comment

Konrad
> +	clk_lucid_ole_pll_configure(&cam_cc_pll11, regmap, &cam_cc_pll11_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll12, regmap, &cam_cc_pll12_config);
> +	clk_rivian_ole_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll5, regmap, &cam_cc_pll5_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll7, regmap, &cam_cc_pll7_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
> +	clk_lucid_ole_pll_configure(&cam_cc_pll9, regmap, &cam_cc_pll9_config);
> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	cam_cc_gdsc_clk
> +	 *	cam_cc_sleep_clk
> +	 */
> +	regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
> +
> +	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver cam_cc_sm8550_driver = {
> +	.probe = cam_cc_sm8550_probe,
> +	.driver = {
> +		.name = "cam_cc-sm8550",
> +		.of_match_table = cam_cc_sm8550_match_table,
> +	},
> +};
> +
> +static int __init cam_cc_sm8550_init(void)
> +{
> +	return platform_driver_register(&cam_cc_sm8550_driver);
> +}
> +subsys_initcall(cam_cc_sm8550_init);
> +
> +static void __exit cam_cc_sm8550_exit(void)
> +{
> +	platform_driver_unregister(&cam_cc_sm8550_driver);
> +}
> +module_exit(cam_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI CAM_CC SM8550 Driver");
> +MODULE_LICENSE("GPL");
