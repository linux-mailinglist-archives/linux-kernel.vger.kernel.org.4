Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D4740FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjF1LHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjF1LG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:06:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E01FEF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:06:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso29048711fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950416; x=1690542416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pti5+/UiKKIkjpsc8nBBZ1hC5Rz69P50qJGiGrwk1D4=;
        b=UFYxy6vt6J5FyQjb1zmLrl9FWyD7/h33tWO5gw1jZzE1YZix5icgroqMuKkdPlwdym
         DxBQbUeEgcGESqBzoc2/xcPTmEEwRvTkpH6oWbNY+PhSXH76mnpfbLIwFnBa2H3NrBuk
         jwAuYPJ0M7yZ8kQpRpX4yYO42VO4CPS9+7G+IxAdNCDZRWUeHAsXcRzwwof9u8bEEQ5S
         4mYmWJHVE5697W9/bjn81TXyz6Za+I/5RVJgxyTx9wbk/i1Y8bcTxXSFr/ajUSUsB8iB
         PXf7Zy+QxdJs6yLtQ68xKWpP94mLqMD5IKm7r09v2gwHFYUkrTTC1EAkVMnxe3QSslNs
         2m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950416; x=1690542416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pti5+/UiKKIkjpsc8nBBZ1hC5Rz69P50qJGiGrwk1D4=;
        b=D5CtEyInYudqBchM/yrzavTgprLS8pvDmxYVhmpovdtuEa/lo7O5pRnhVbOPPyaraN
         Om7XJc8fkNkyR6tOwCIvybN+Ms1+thAGbf5fnyLuUzFbyADY5t+e/OmJrGPrInEiJYWu
         40hEgvJ6js87VyzixwOcCra8PyOzKMcBwnYY35Z5p67pubsiG+8nmL18WPKh1q6zGizy
         RDJtcFBLNKxodwnPrzIKvmykZafOc2lTk+Hd102fpGI0vybslZb2sFNP5tSpPlOP2yZW
         f1iV6CggZsYt1oBqfP4bVE0Bb7wk2MeCKdUYZzDwJffb+Oc3oROSnTef/IZVgX/bBp66
         4H8Q==
X-Gm-Message-State: AC+VfDxzzKYno5mRi/Gsm5BttyoV2tknYxN1lbdJMb8tXkBTlMEWfi0E
        QTPqXN7F/Zo/2Ub6fDi+n9FJuQ==
X-Google-Smtp-Source: ACHHUZ5z0re/JfX571y3N7quQuWY1p0nz38T+cwCxRo3ZHyPvsNivdpqwrdIwDVW0TRnwssJnXMqpg==
X-Received: by 2002:a2e:9083:0:b0:2b5:a500:5597 with SMTP id l3-20020a2e9083000000b002b5a5005597mr7486694ljg.14.1687950416034;
        Wed, 28 Jun 2023 04:06:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id u6-20020a2e2e06000000b002ad988efd73sm2174580lju.14.2023.06.28.04.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:06:55 -0700 (PDT)
Message-ID: <afde2981-3801-a93e-3cf2-2ab5d24ee3e1@linaro.org>
Date:   Wed, 28 Jun 2023 13:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 3/5] clk: qcom: gcc-qdu1000: Update GCC clocks as per
 the latest hw version
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-4-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628092837.3090801-4-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 28.06.2023 11:28, Imran Shaik wrote:
> Add support for gcc_ddrss_ecpri_gsi_clk and update the GCC clkref clocks
> as per the latest hardware version of QDU1000 and QRU100 SoCs.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
> Changes since v1:
>  - Newly added
> 
>  drivers/clk/qcom/gcc-qdu1000.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index c00d26a3e6df..991fb2bc97e9 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -1131,6 +1131,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
>  	},
>  };
>  
> +static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
> +	.halt_reg = 0x54298,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x54298,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x54298,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_ddrss_ecpri_gsi_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch gcc_ecpri_ahb_clk = {
>  	.halt_reg = 0x3a008,
>  	.halt_check = BRANCH_HALT_VOTED,
> @@ -1447,14 +1467,13 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
>  
>  static struct clk_branch gcc_pcie_0_clkref_en = {
>  	.halt_reg = 0x9c004,
> -	.halt_bit = 31,
> -	.halt_check = BRANCH_HALT_ENABLE,
> +	.halt_check = BRANCH_HALT,
>  	.clkr = {
>  		.enable_reg = 0x9c004,
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_pcie_0_clkref_en",
> -			.ops = &clk_branch_ops,
> +			.ops = &clk_branch2_ops,
This sounds like a separate fix, clk_branch_ops seems to only concern
10+yo chips.

Konrad
>  		},
>  	},
>  };
> @@ -2274,14 +2293,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
>  
>  static struct clk_branch gcc_usb2_clkref_en = {
>  	.halt_reg = 0x9c008,
> -	.halt_bit = 31,
> -	.halt_check = BRANCH_HALT_ENABLE,
> +	.halt_check = BRANCH_HALT,
>  	.clkr = {
>  		.enable_reg = 0x9c008,
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_usb2_clkref_en",
> -			.ops = &clk_branch_ops,
> +			.ops = &clk_branch2_ops,
>  		},
>  	},
>  };
> @@ -2523,6 +2541,8 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>  	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>  	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>  	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
> +	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
> +	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
>  };
>  
>  static const struct qcom_reset_map gcc_qdu1000_resets[] = {
