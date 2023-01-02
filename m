Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFF65B49C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjABQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjABQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:04:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D2E77
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:04:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bf43so42101842lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEF2FgWcD6lMSK4vj9U4bFMyfM1FOZj/hk7aIZXWWdA=;
        b=Rja8l9wOuNOelHVwForjNs4KmIX9lOz5Yn6lhVkFjbgYyznvWlnTIlZ1Qyjex0Qe7e
         bkhaYDfTxzoBOrvsGnVcuz2Bx/2sowHP1xMzlVZa6qZwk1F9kJrXG5J4YKdsG8v2q850
         NIURboQ/r1CWcqAUFGw7FSaQLmVE3hUC59lkgnAJJ2F11n2dmLIHrJD4AjgrvgXgDBFg
         ZpGZaDCMBTbLQEo5gGrigAEgoznLCy0JQYAru9KrS7PRP9ERuIE3yCQEZgMzVRobI7i/
         rcwTGMhD1wjLTs8Zut+oDP5uo9VXeWhDSPu+baaslKLnmO6mC1nsvbGT1gz6Qleq4Fjx
         W4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEF2FgWcD6lMSK4vj9U4bFMyfM1FOZj/hk7aIZXWWdA=;
        b=XOp7aLrjbRk3YGGpnffMTd6QjaU+OQzTieNIZz6PO7QdaTFoSnIKpGSULY18vNSCOq
         kwGI/MEc4TqFOL4TENq3Y2+iJH+fQUneviJ3ivR0magxT/Wy343XOvvIQyyzaRc+syJD
         xWzIQgiPuH4IrIGgrXWB2k9fVTKM5DOdcgZSwjpFeVCdu7XHwAGuO7HewFDrjs+Ex4bw
         kqxFF3XzDAqictHIOPh7DBDMRkQxanqauQh0x0ttYgpTDT1TOcuHGCS2IJ9rr24SwKXo
         xV8J6FG5HWBh8MdwfNyzwchuq93aV5wedkbdWoHQvHpz1hoTJ5mmkWgje8G2JeZG3dUo
         yG/A==
X-Gm-Message-State: AFqh2koeq54L6L20APGOLZD31ZACRaUjqBprbS9oB2C6VkjZpKUjqZpt
        yo5brUa9+mrRo2iQsrN4Z/03Xg==
X-Google-Smtp-Source: AMrXdXsJFt23TRg1ASw9Ysr4Z1DGvumrwQqBO2iwAAURtYtMIzjKiCfitlJfN/EnA0prqfsiFn0sWA==
X-Received: by 2002:a05:6512:4013:b0:4a4:8044:9b8 with SMTP id br19-20020a056512401300b004a4804409b8mr12541658lfb.9.1672675492948;
        Mon, 02 Jan 2023 08:04:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j4-20020a056512344400b004cb0dfe4993sm2685455lfr.65.2023.01.02.08.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:04:52 -0800 (PST)
Message-ID: <71704270-5342-ab54-79f5-cdc817ddb255@linaro.org>
Date:   Mon, 2 Jan 2023 17:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock
 control
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
 <1672407799-13768-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672407799-13768-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 14:43, Srinivasa Rao Mandadapu wrote:
> The qdsp6ss memory region is being shared by ADSP remoteproc device and
> lpasscc clock device, hence causing memory conflict.
> As the qdsp6ss clocks are being enabled in remoteproc driver,
> remove clock controlling in the clock driver.
> 
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  drivers/clk/qcom/lpasscc-sc7280.c | 63 +--------------------------------------
>  1 file changed, 1 insertion(+), 62 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> index 5c1e17b..87e1c21 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -30,48 +30,6 @@ static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>  	},
>  };
>  
> -static struct clk_branch lpass_qdsp6ss_core_clk = {
> -	.halt_reg = 0x20,
> -	/* CLK_OFF would not toggle until LPASS is out of reset */
> -	.halt_check = BRANCH_HALT_SKIP,
> -	.clkr = {
> -		.enable_reg = 0x20,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "lpass_qdsp6ss_core_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
> -static struct clk_branch lpass_qdsp6ss_xo_clk = {
> -	.halt_reg = 0x38,
> -	/* CLK_OFF would not toggle until LPASS is out of reset */
> -	.halt_check = BRANCH_HALT_SKIP,
> -	.clkr = {
> -		.enable_reg = 0x38,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "lpass_qdsp6ss_xo_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
> -static struct clk_branch lpass_qdsp6ss_sleep_clk = {
> -	.halt_reg = 0x3c,
> -	/* CLK_OFF would not toggle until LPASS is out of reset */
> -	.halt_check = BRANCH_HALT_SKIP,
> -	.clkr = {
> -		.enable_reg = 0x3c,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "lpass_qdsp6ss_sleep_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>  static struct regmap_config lpass_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
> @@ -90,18 +48,6 @@ static const struct qcom_cc_desc lpass_cc_top_sc7280_desc = {
>  	.num_clks = ARRAY_SIZE(lpass_cc_top_sc7280_clocks),
>  };
>  
> -static struct clk_regmap *lpass_qdsp6ss_sc7280_clocks[] = {
> -	[LPASS_QDSP6SS_XO_CLK] = &lpass_qdsp6ss_xo_clk.clkr,
> -	[LPASS_QDSP6SS_SLEEP_CLK] = &lpass_qdsp6ss_sleep_clk.clkr,
> -	[LPASS_QDSP6SS_CORE_CLK] = &lpass_qdsp6ss_core_clk.clkr,
> -};
> -
> -static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
> -	.config = &lpass_regmap_config,
> -	.clks = lpass_qdsp6ss_sc7280_clocks,
> -	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
> -};
> -
>  static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_cc_desc *desc;
> @@ -118,17 +64,10 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>  		goto destroy_pm_clk;
>  	}
>  
> -	lpass_regmap_config.name = "qdsp6ss";
> -	desc = &lpass_qdsp6ss_sc7280_desc;
> -
> -	ret = qcom_cc_probe_by_index(pdev, 0, desc);
> -	if (ret)
> -		goto destroy_pm_clk;
> -
>  	lpass_regmap_config.name = "top_cc";
>  	desc = &lpass_cc_top_sc7280_desc;
>  
> -	ret = qcom_cc_probe_by_index(pdev, 1, desc);
> +	ret = qcom_cc_probe_by_index(pdev, 0, desc);

ABI break but actually does not work with upstream either. DTS at this
point has here on index "0" different address and you probe now top_cc
on it.

Best regards,
Krzysztof

