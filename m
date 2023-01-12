Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD0667955
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjALPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjALPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:31:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC0713DE2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so28905961lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtWGEx2XwnoDW6PQDY/ot+B1VrWS9wU0ZiX/llUoAaA=;
        b=ue9VmefVO6jfaf70+1DqmhVYQTk8bnzJyMmxnbf+cee2hcxUOR47s3Zw6pW+m3DrDk
         bkMnoRp75PzD9brcfG5e9I62cblT8YfewaJqUTcCVZ9CwUM8bKBmAc0FJZAJow00lH46
         UKKS6k5VX8wmWlyTHXE9E6GbY07SJc6ArY6Vv16BLdOFqGKqvDWhMw/SDmHvvF2Wmxwi
         Q0JypFkF1CZoB8PolMuR94KPJe0izLXTAaZoDuG2NKPyL9z3TjxSaHZJp+iRtf17mjlA
         S7Cwe9SHghELDsG+uR23ulYil1uIrgkqxMwZQU1HCi015gN79rQeRddDZc34hBYIgiHX
         lkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtWGEx2XwnoDW6PQDY/ot+B1VrWS9wU0ZiX/llUoAaA=;
        b=nnPcqNo+XHlcxcwfy0IGDEq6RG9hmaSeIxrabCtBbpdWvnIhBe8r2O6T1+lrhURe6t
         dytnk3YfWE/iApAijR6ld7zFDprNT22NLLR0IWVodTMVYNjQGeQNLnPHp6UKxBs9Q8yd
         LedP8E2K7nkLjIO7p08uc3FZQumdinrLvj0Ztrfq5BuCW34bybSsvU+RMPIyrePNzEyN
         KuUeHG3Cn5ny0noFVvM/ub08ysPhInQjgKKJNy2sM9nvQxMLXFEfhRfstKzhIB7MdiL7
         mqLiO8EYB7+DV9RX8f5jLHL02nNOqxq0kC+a3bs09ffqOPw0cHqbX37gzhjovKn98pHz
         EdoA==
X-Gm-Message-State: AFqh2kpoRKckXNy2KYGoBy1hrPPasMCGIZipcDWTVd+YlTuGUlXQSeQe
        1x0eoSYuadNkrkv9U0WfikMPqg==
X-Google-Smtp-Source: AMrXdXuop/JByMaI5zq/a2w1JusRq+v/9YHgm9Cyg29ZBByaOJKx6IRRlUdxGdYFAWzOiD6UMqwPMg==
X-Received: by 2002:a05:6512:1049:b0:4b6:edce:a192 with SMTP id c9-20020a056512104900b004b6edcea192mr24967979lfb.4.1673537016172;
        Thu, 12 Jan 2023 07:23:36 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b004ce4e945b73sm63548lfo.86.2023.01.12.07.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:23:34 -0800 (PST)
Message-ID: <fbec2272-e9b8-207d-e2ce-2f2011640d33@linaro.org>
Date:   Thu, 12 Jan 2023 16:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] clk: qcom: add the driver for the MSM8996 APCS clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
 <20230111191453.2509468-5-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111191453.2509468-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 20:14, Dmitry Baryshkov wrote:
> Add a simple driver handling the APCS clocks on MSM8996. For now it
> supports just a single aux clock, linking GPLL0 to CPU and CBF clocks.
> 
> Note, there is little sense in registering sys_apcs_aux as a child of
> gpll0. The PLL is always-on. And listing the gpll0 as a property of the
> apcs would delay its probing until the GCC has been probed (while we
> would like for the apcs to be probed as early as possible).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Makefile       |  2 +-
>  drivers/clk/qcom/apcs-msm8996.c | 77 +++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/qcom/apcs-msm8996.c
> 
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f18c446a97ea..ca2f586edb3e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_MSM_MMCC_8998) += mmcc-msm8998.o
>  obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
>  obj-$(CONFIG_QCOM_A7PLL) += a7-pll.o
>  obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
> -obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += clk-cpu-8996.o
> +obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += apcs-msm8996.o clk-cpu-8996.o
>  obj-$(CONFIG_QCOM_CLK_APCS_SDX55) += apcs-sdx55.o
>  obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
>  obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8996.c
> new file mode 100644
> index 000000000000..2e9959974ed9
> --- /dev/null
> +++ b/drivers/clk/qcom/apcs-msm8996.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm APCS clock controller driver
> + *
> + * Copyright (c) 2022, Linaro Limited
> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define APCS_AUX_OFFSET	0x50
> +
> +#define APCS_AUX_DIV_MASK GENMASK(17, 16)
> +#define APCS_AUX_DIV_2 0x1
> +
> +static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *parent = dev->parent;
> +	struct regmap *regmap;
> +	struct clk_hw *hw;
> +	unsigned int val;
> +	int ret = -ENODEV;
> +
> +	regmap = dev_get_regmap(parent, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "failed to get regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_read(regmap, APCS_AUX_OFFSET, &val);
> +	regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
> +			   FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_2));
> +
> +	/* Hardware mandated delay */
> +	udelay(5);
> +
> +	/*
> +	 * Register the clock as fixed rate instead of being a child of gpll0
> +	 * to let the driver register probe as early as possible.
> +	 */
Not sure.. you should keep a vote in GPLL0_ao supplied by XO_A
and perhaps it would be a better idea to move RPMCC (+deps) and
GCC to very early initcalls since there's a need for that..

Maybe it would even allow us to shave some miliseconds from
boot times, at less things would defer!

Konrad
> +	hw = devm_clk_hw_register_fixed_rate(dev, "sys_apcs_aux", NULL, 0, 300000000);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
> +}
> +
> +static struct platform_driver qcom_apcs_msm8996_clk_driver = {
> +	.probe = qcom_apcs_msm8996_clk_probe,
> +	.driver = {
> +		.name = "qcom-apcs-msm8996-clk",
> +	},
> +};
> +
> +/* Register early enough to fix the clock to be used for other cores */
> +static int __init qcom_apcs_msm8996_clk_init(void)
> +{
> +	return platform_driver_register(&qcom_apcs_msm8996_clk_driver);
> +}
> +postcore_initcall(qcom_apcs_msm8996_clk_init);
> +
> +static void __exit qcom_apcs_msm8996_clk_exit(void)
> +{
> +	platform_driver_unregister(&qcom_apcs_msm8996_clk_driver);
> +}
> +module_exit(qcom_apcs_msm8996_clk_exit);
> +
> +MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
> +MODULE_LICENSE("GPL v2");
"GPL"

> +MODULE_DESCRIPTION("Qualcomm MSM8996 APCS clock driver");
