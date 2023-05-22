Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE870B83B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjEVI7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjEVI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:59:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5CE78
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:58:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae4e49727eso56791135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684745916; x=1687337916;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVVEKPnXkSILTss/P2zaQmuQ5vs6PfUPsMsOFGsk8/M=;
        b=Ql0qKVg8nKHPlO3LwnQK70xhH1YY18RDJ/jp8+QbdPUKQj/xMBIjs8YdP+RbTdGy8o
         un7B0gd92OPgrULN/uskxekvP2KHntPf5K3teVTAow68P6BKUw7JOGc36akTxJXxTaTO
         1Oz/EGCd2/FIJeE0UVTRnPqM4pllTdRzyzRDaK8DYLvT0UDQ53v2KPHA9bPS3umni37i
         ojXwupNlP2JzASRvNu8BJHpk9LaqJwgVXFcjMU5/9gTxXAvZpQClz72/h730jFisC480
         cRUwPmZQnoSEw4wQ0ATbD6NC33eu53YxhJM59qKi060tlSs5e0GhfD80QlJEZ/bRSXSJ
         TsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745916; x=1687337916;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WVVEKPnXkSILTss/P2zaQmuQ5vs6PfUPsMsOFGsk8/M=;
        b=Z2GUo8FUFCa6Ffkjl0yPM2he0xCO/Dss638WMXxi3337tup+ye5xEEzEv1Aatw5NXz
         ZfcaMhawpJyzFebZbdHltO32GKUcUpqdM48cI7lm+sHHkR7C2lYOWKqwr7T6xqUZFXX+
         7o6LItbaZ3GAXWvAu7CqGu+qQ/5nRodGIiVpAfuDpTxNAERDpC3XbFU9d7Y0BQtamCUB
         bXfos/B1kkhKBiEfhbddxPlZGiI+1maemf2R1xC69yIJdo4kYWPUh76UofF19nXexLBu
         xjScAmydgK3qOfwzfXfVlhPiUOVHF5YkJNlYyXIw8zkYeSq5cpTATVS4D7Md5U1ap0FY
         MmrA==
X-Gm-Message-State: AC+VfDzPyRCEQIsNB87QmiDjg6V8LjRZ5fJ8q/FnxyTjt9nRHBBAWP0N
        Uq4KssI6ACYDJmv3biF/I2SL8xq3ri5IKEeLbu8=
X-Google-Smtp-Source: ACHHUZ4uhzrBezRPGNp3O4yAik4A3kP5KYKhP29A86ySFHnLnzIEoz/7dLeytbx4+onNWQEISTP78w==
X-Received: by 2002:a17:902:f2cc:b0:1aa:fbaa:ee09 with SMTP id h12-20020a170902f2cc00b001aafbaaee09mr7905892plc.49.1684745916446;
        Mon, 22 May 2023 01:58:36 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001a1d553de0fsm4308539plg.271.2023.05.22.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:58:36 -0700 (PDT)
Message-ID: <c451dc43-b5a2-df42-c4a5-0db4c6641b1c@linaro.org>
Date:   Mon, 22 May 2023 14:28:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.sharma@linaro.org
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V3 2/4] clk: qcom: gcc-ipq9574: Enable crypto clocks
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-3-quic_anusha@quicinc.com>
In-Reply-To: <20230518141105.24741-3-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
> Enable the clocks required for crypto operation.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   Changes in V3:
> 	- Added GCC prefix to CRYPTO_CLK_SRC.
> 
>   drivers/clk/qcom/gcc-ipq9574.c | 72 ++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 7b0505f5c255..73663168d72a 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -728,6 +728,41 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
>   	},
>   };
>   
> +static const struct freq_tbl ftbl_gcc_crypto_clk_src[] = {
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_crypto_clk_src = {
> +	.cmd_rcgr = 0x16004,
> +	.freq_tbl = ftbl_gcc_crypto_clk_src,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_crypto_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch gcc_crypto_clk = {
> +	.halt_reg = 0x1600c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x0b004,
> +		.enable_mask = BIT(14),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_crypto_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&gcc_crypto_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_apss_ahb_clk = {
>   	.halt_reg = 0x24018,
>   	.halt_check = BRANCH_HALT_VOTED,
> @@ -2071,6 +2106,38 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
>   	},
>   };
>   
> +static struct clk_branch gcc_crypto_axi_clk = {
> +	.halt_reg = 0x16010,
> +	.clkr = {
> +		.enable_reg = 0x16010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_crypto_axi_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&pcnoc_bfdcd_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_crypto_ahb_clk = {
> +	.halt_reg = 0x16014,
> +	.clkr = {
> +		.enable_reg = 0x16014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_crypto_ahb_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&pcnoc_bfdcd_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_branch gcc_nsscfg_clk = {
>   	.halt_reg = 0x1702c,
>   	.clkr = {
> @@ -4036,6 +4103,10 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
>   	[GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
>   	[GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
>   	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
> +	[GCC_CRYPTO_CLK_SRC] = &gcc_crypto_clk_src.clkr,
> +	[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
> +	[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
> +	[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
>   };

Can we please add these in alphabetical order. For e.g. here these entries would follow those for '[GCC_CMN_BLK_APU_ARES] = { 0x3a010, 2 },'

>   static const struct qcom_reset_map gcc_ipq9574_resets[] = {
> @@ -4193,6 +4264,7 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
>   	[GCC_WCSS_ECAHB_ARES] = { 0x25070, 0 },
>   	[GCC_WCSS_Q6_BCR] = { 0x18000, 0 },
>   	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
> +	[GCC_CRYPTO_BCR] = { 0x16000, 0 },

Same as above.

With the above addressed:
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.

>   };
>   
>   static const struct of_device_id gcc_ipq9574_match_table[] = {
> 
