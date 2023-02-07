Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8E68CD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBGDjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGDi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:38:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2323C57;
        Mon,  6 Feb 2023 19:38:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0306EB815FB;
        Tue,  7 Feb 2023 03:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8842C433D2;
        Tue,  7 Feb 2023 03:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675741135;
        bh=R8a0vravU3c65KQLuU/vTGT6AoF58hfs3+rHNo3Q9NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSdYP+zHlVSasdMOXsFH4C48jxqxf2QyOeklqErXVleHaj8VrgVGd8Q4bXdUC2cMN
         r8ik8/vJ03h8TXd3IEm/bKXSfMOZj9xR4APatoz/L/nQED+MKf/XQJNLl6hGe7+YGC
         wVXfMKzlP9Jgu9isTyV3YlMQTOz0ojX9b8o377jDauBg/gMNT+m53W3lqmSYyPehQt
         HVUBvW35eOMjizIDDCViGQofoLN3BW6KrHHxIaNpC2nG7zZUGV9hcJUBA92KGXzCLQ
         E8ccBwVfC471CGIePoxxo9ETALqwOXnTLfFRJcY3Y8Z/KmdVjNKI8PPFv4knhoY4Wh
         YIANxzavD/duQ==
Date:   Mon, 6 Feb 2023 19:41:08 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH V3 5/9] clk: qcom: add Global Clock controller (GCC)
 driver for IPQ5332 SoC
Message-ID: <20230207034108.bypitlfxicpz6wqb@ripper>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-6-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206071217.29313-6-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:42:13PM +0530, Kathiravan T wrote:
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
[..]
> +
> +enum {
> +	DT_SLEEP_CLK,
> +	DT_XO,
> +	DT_PCIE_2LANE_PHY_PIPE_CLK,
> +	DT_PCIE_2LANE_PHY_PIPE_X1_CLK,
> +	DT_USB_PCIE_WRAPPER_PIPE_CLK,

This list does not match the clocks as defined in the binding.

> +};
> +
> +enum {
> +	P_PCIE3X2_PIPE,
> +	P_PCIE3X1_0_PIPE,
> +	P_PCIE3X1_1_PIPE,
> +	P_USB3PHY_0_PIPE,
> +	P_CORE_BI_PLL_TEST_SE,
> +	P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC,
> +	P_GPLL0_OUT_AUX,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL2_OUT_AUX,
> +	P_GPLL2_OUT_MAIN,
> +	P_GPLL4_OUT_AUX,
> +	P_GPLL4_OUT_MAIN,
> +	P_SLEEP_CLK,
> +	P_XO,
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_xo = { .index = DT_XO };
> +
> +static struct clk_alpha_pll gpll0_main = {
> +	.offset = 0x20000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +	.clkr = {
> +		.enable_reg = 0xb000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data){

Please add a space between ')' and '{ on all these.

> +			.name = "gpll0_main",
> +			.parent_data = &gcc_parent_data_xo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_stromer_ops,
> +		},
> +	},
> +};
[..]
> +static const struct qcom_cc_desc gcc_ipq5332_desc = {
> +	.config = &gcc_ipq5332_regmap_config,
> +	.clks = gcc_ipq5332_clocks,
> +	.num_clks = ARRAY_SIZE(gcc_ipq5332_clocks),
> +	.resets = gcc_ipq5332_resets,
> +	.num_resets = ARRAY_SIZE(gcc_ipq5332_resets),
> +	.clk_hws = gcc_ipq5332_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_ipq5332_hws),

No GDSCs?

Regards,
Bjorn
