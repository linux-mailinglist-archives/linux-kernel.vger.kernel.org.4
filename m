Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C6740FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjF1LIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjF1LIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:08:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B04E2102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:08:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so2840031e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950492; x=1690542492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3YaZvbpJE8KoJXh11DvcBsWD9TPOvwIkWVnCG4LCf0=;
        b=ch7fQbLermAchx7Mi8EyjaqLGBoKnbc7EL5EXpbysoCxwRsN0w9bX8xKUkRY1C+i3i
         97UhHB3jjLd+/oSv0pRiqXo+iWiyUZhshDFYFdnoGXuUMowtnt0yQoqoTeiQh2jh0dB1
         ybx6IrqGG5q15bVjHlffYUFiGYwpfmD3YCXtm+SaofSTyckDJ3foj52IuoysjKIifHKt
         aqMQLLLAKS2cxRLIKtkE9Amn9RCaA5KcfgRu/oxzku8US1fNfEe3ibjxjmI5ubC2hgec
         CdTTwL/auaovmcKtGIkffybMaMi4g8ctsXDMQj6cfZTAabbfrk2BONmsTbVkAoe0l+cM
         tsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950492; x=1690542492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3YaZvbpJE8KoJXh11DvcBsWD9TPOvwIkWVnCG4LCf0=;
        b=HGQIJxaoRTrHFsaTohQyCWs2+YEAsKPGpQnaaZrxJaftnrx6PQfcaqF/6QoQ9i0g+o
         DaTfVZN+1ZQ2Xs2PjLDHcbY+9YN2gKr467YW0m13Fd059oUrQnxK2DFstcz16yOpJJYw
         uIoF39NfFKF3N072ze5wl8iBFfYlRxKd272jXvXyiYA7RAYuSY3QpCCgBy5qHdhDYJrY
         fA7fp2NacJm3nsJ3xDGfOlNoMxZ5glHpL9GD0+iyhZNuydKE4OS9Bwwm5ySidzpnyhdB
         GJpthkQkBX38EW47nNFl1P5UoGfFQlkGvfQv8l8+EX9r31Ms+tJUo14Lzw3IrtIHwkFW
         NWnQ==
X-Gm-Message-State: AC+VfDw3CXOpz1qAxq8gT6ZYqYHPRNxdVaJKXVlhQZ/gxJacCKk6T3Uh
        homztwvsTJjD0bMMV7FDsL4wxg==
X-Google-Smtp-Source: ACHHUZ4Ilxa5z63KMu1RIRHU6/OOp4kqAz1DkwDgWU487TutTN22a2ZOf5gbU7ZHmIylRj5pOe9J/g==
X-Received: by 2002:a19:6713:0:b0:4f9:5933:8eea with SMTP id b19-20020a196713000000b004f959338eeamr11411822lfc.3.1687950491725;
        Wed, 28 Jun 2023 04:08:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id t3-20020a19ad03000000b004fa52552c82sm1733406lfc.155.2023.06.28.04.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:08:11 -0700 (PDT)
Message-ID: <82ed84aa-6335-c0fd-9c3e-1a6ef6924336@linaro.org>
Date:   Wed, 28 Jun 2023 13:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 4/5] clk: qcom: gcc-qdu1000: Add support for GDSCs
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
 <20230628092837.3090801-5-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628092837.3090801-5-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2023 11:28, Imran Shaik wrote:
> Add the GDSCs support for QDU1000 and QRU1000 SoCs.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes since v1:
>  - Newly added
> 
>  drivers/clk/qcom/gcc-qdu1000.c | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index 991fb2bc97e9..718c34dca6e8 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -17,6 +17,7 @@
>  #include "clk-regmap-divider.h"
>  #include "clk-regmap-mux.h"
>  #include "clk-regmap-phy-mux.h"
> +#include "gdsc.h"
>  #include "reset.h"
>  
>  enum {
> @@ -2409,6 +2410,39 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
>  	},
>  };
>  
> +static struct gdsc pcie_0_gdsc = {
> +	.gdscr = 0x9d004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gcc_pcie_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc pcie_0_phy_gdsc = {
> +	.gdscr = 0x7c004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0x2,
> +	.pd = {
> +		.name = "gcc_pcie_0_phy_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc usb30_prim_gdsc = {
> +	.gdscr = 0x49004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gcc_usb30_prim_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
>  static struct clk_regmap *gcc_qdu1000_clocks[] = {
>  	[GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
>  	[GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
> @@ -2545,6 +2579,12 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>  	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
>  };
>  
> +static struct gdsc *gcc_qdu1000_gdscs[] = {
> +	[PCIE_0_GDSC] = &pcie_0_gdsc,
> +	[PCIE_0_PHY_GDSC] = &pcie_0_phy_gdsc,
> +	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
> +};
> +
>  static const struct qcom_reset_map gcc_qdu1000_resets[] = {
>  	[GCC_ECPRI_CC_BCR] = { 0x3e000 },
>  	[GCC_ECPRI_SS_BCR] = { 0x3a000 },
> @@ -2606,6 +2646,8 @@ static const struct qcom_cc_desc gcc_qdu1000_desc = {
>  	.num_clks = ARRAY_SIZE(gcc_qdu1000_clocks),
>  	.resets = gcc_qdu1000_resets,
>  	.num_resets = ARRAY_SIZE(gcc_qdu1000_resets),
> +	.gdscs = gcc_qdu1000_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gcc_qdu1000_gdscs),
>  };
>  
>  static const struct of_device_id gcc_qdu1000_match_table[] = {
