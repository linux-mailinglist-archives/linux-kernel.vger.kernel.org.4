Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4020D68BFA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjBFOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjBFOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:10:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1725977
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:09:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so2862564edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MV6XLW6L8RW/R5+2kFS4UxYTCoNjk3wANf/VdVgvmZQ=;
        b=obrZxPMx4cCoF2qc7FG3fKEj4DDxkgrHCWDr7RlB6Oaxp5rEo5zKuXAPU1AmaKEeEh
         EmZGBYes6wS0kfe4Qwsz2msSfFGjyQh7/YeC5skCU72siY0GFnjXK4U9DI5212hKSl5g
         zyW7X80NdKh+zrtsBiRdrMLHP7HEUZAY9MFgMxGsbBBS+2rueZmRdbZt2qfl0r0irexz
         gkZp4xZP3p2fHiHzSjvJlKg9Q+nGIv/5BZOjkgsFLubn2DQfhOOip5qyfv64Umai11YO
         vkpd3VhbRkUMiQqik8FyLEBUjYLtfkEeSE6IJ7iOktAbzRaQKPtDENwTbxQwViA6dFTQ
         AOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MV6XLW6L8RW/R5+2kFS4UxYTCoNjk3wANf/VdVgvmZQ=;
        b=yPTyVbFdaGMMYEfntS0Sj9SlDMANkH2BgSLblNNj++Elrc7lEAMQtA43UhT6/3yPDn
         KG90AvyPQnOfWtHt+kZ6cTYJx0wPAwKTV9LhJYCEPdyYRwbXsTEq8wOwYkJmaKImpgeS
         BmKO0u7uhCQ15YXDq4tYLizFODin2bzWbceW5MrV9LXlQ56yoGAHp0peDnUJhsavs8Ld
         amL1ZzaZyohB2EmHDcDctLFlMUegyPD1viyQ4HMJt4bzoXT1ufdK4BaSmBAOCvXkjD6X
         KNU7NDFRu8F8rNzXbWgxJWoRgh3UQAScaxZDX/L9aNOC92x4B+16TdWnwkOWdyuV9ch/
         UyFQ==
X-Gm-Message-State: AO0yUKX8WR7iF1KQucQtrAtbvEvrz5vs6HkHOManKR7Y65qIYxh9xobr
        55aBq9CNbkgdkgYZlWFQKpYr5A==
X-Google-Smtp-Source: AK7set93k49Ql3FZZglKm5wgbtW71CXolFsNzmsS9eVK2BZe0KhoIkey+fpXQLvYvnx4gjmaF3Bu3A==
X-Received: by 2002:a05:6402:500c:b0:49e:4254:60a9 with SMTP id p12-20020a056402500c00b0049e425460a9mr24946255eda.29.1675692479239;
        Mon, 06 Feb 2023 06:07:59 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709064ec500b00877e1bb54b0sm5536958ejv.53.2023.02.06.06.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:07:58 -0800 (PST)
Message-ID: <94fc3698-3568-87d8-7263-68de9ca53eab@linaro.org>
Date:   Mon, 6 Feb 2023 16:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 2/7] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230206103337.21000-1-quic_devipriy@quicinc.com>
 <20230206103337.21000-3-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206103337.21000-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 12:33, Devi Priya wrote:
> Add Global Clock Controller (GCC) driver for ipq9574 based devices
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   Changes in V7:
> 	- Used qcom_cc_probe instead of qcom_cc_really_probe in
> 	  gcc_ipq9574_probe
> 
>   drivers/clk/qcom/Kconfig       |    8 +
>   drivers/clk/qcom/Makefile      |    1 +
>   drivers/clk/qcom/gcc-ipq9574.c | 4295 ++++++++++++++++++++++++++++++++
>   3 files changed, 4304 insertions(+)
>   create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 5ab4b7dfe3c2..a9f01d67a500 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -173,6 +173,14 @@ config IPQ_GCC_8074
>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>   	  of ipq8074.
>   
> +config IPQ_GCC_9574
> +	tristate "IPQ9574 Global Clock Controller"
> +	help
> +	  Support for global clock controller on ipq9574 devices.
> +	  Say Y if you want to use peripheral devices such as UART, SPI,
> +	  i2c, USB, SD/eMMC, etc. Select this for the root clock
> +	  of ipq9574.
> +
>   config MSM_GCC_8660
>   	tristate "MSM8660 Global Clock Controller"
>   	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 3194465dd02c..51e6e5eb187b 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>   obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> +obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> new file mode 100644
> index 000000000000..718106a9ac7b
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq9574.c

[skipped]

> +static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
> +	.halt_reg = 0x2e054,
> +	.clkr = {
> +		.enable_reg = 0x2e054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "gcc_snoc_pcie3_2lane_s_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&pcie3_axi_s_clk_src.clkr.hw
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap_mux pcie0_pipe_clk_src = {
> +	.reg = 0x28064,
> +	.shift = 8,
> +	.width = 2,
> +	.parent_map = gcc_pcie30_phy0_pipe_clk_xo_map,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "pcie0_pipe_clk_src",
> +			.parent_data = gcc_pcie30_phy0_pipe_clk_xo,
> +			.num_parents = ARRAY_SIZE(gcc_pcie30_phy0_pipe_clk_xo),
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_regmap_mux_closest_ops,


clk_regmap_phy_mux_ops ?

> +		},
> +	},
> +};
> +
> +static struct clk_regmap_mux pcie1_pipe_clk_src = {
> +	.reg = 0x29064,
> +	.shift = 8,
> +	.width = 2,
> +	.parent_map = gcc_pcie30_phy1_pipe_clk_xo_map,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "pcie1_pipe_clk_src",
> +			.parent_data = gcc_pcie30_phy1_pipe_clk_xo,
> +			.num_parents = ARRAY_SIZE(gcc_pcie30_phy1_pipe_clk_xo),
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_regmap_mux_closest_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap_mux pcie2_pipe_clk_src = {
> +	.reg = 0x2a064,
> +	.shift = 8,
> +	.width = 2,
> +	.parent_map = gcc_pcie30_phy2_pipe_clk_xo_map,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "pcie2_pipe_clk_src",
> +			.parent_data = gcc_pcie30_phy2_pipe_clk_xo,
> +			.num_parents = ARRAY_SIZE(gcc_pcie30_phy2_pipe_clk_xo),
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_regmap_mux_closest_ops,

clk_regmap_phy_mux_ops ?


> +		},
> +	},
> +};
> +
> +static struct clk_regmap_mux pcie3_pipe_clk_src = {
> +	.reg = 0x2b064,
> +	.shift = 8,
> +	.width = 2,
> +	.parent_map = gcc_pcie30_phy3_pipe_clk_xo_map,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "pcie3_pipe_clk_src",
> +			.parent_data = gcc_pcie30_phy3_pipe_clk_xo,
> +			.num_parents = ARRAY_SIZE(gcc_pcie30_phy3_pipe_clk_xo),
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_regmap_mux_closest_ops,

clk_regmap_phy_mux_ops ?

> +		},
> +	},
> +};

-- 
With best wishes
Dmitry

