Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CE740F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjF1LEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjF1LEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:04:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BE1FED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:04:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so5382061e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950239; x=1690542239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUPPFuBKO9vOMiVIKyk5q3cgcsex7PRLitfEapTCn3s=;
        b=qRfuMhHC8fRCoxwPNp2sg/o0Sazzv2owsgL38PlJwbt8aLKgJ/l1yx0fyKUoDaZEbs
         B1IdL+VADzIqoPb1Ru6ius1faeg/kf20+tvk9Vw+wIfelhcUSylY55BiXCWpUtQe5xqG
         yo9EY4L/eeZ2EjL1JdkiWhW38pFuC2XpSmQppHcjvLu80eFcVy9CXKV6sPnyWTmBqckS
         ZlF1ptQ96ZkLPXmrfNQY1nHmcidQyYVER/l5lJYXqgsi9M0oR3kA9rnMfeSGsuBXakxA
         1eKVqjQHIxV4QDR0WKQ1swDXAgHKchIuoaOfB3FnIS/CZrsR8Ufi/8Jlr+D16zm8wB/l
         8FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950239; x=1690542239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUPPFuBKO9vOMiVIKyk5q3cgcsex7PRLitfEapTCn3s=;
        b=SeDqZNn3ezNhD45o8MZxs84hATwSGekJeW4W86sqQhG28w+cfug9f8v7QKmlpsrP7P
         xzoZTD8SWcfwECcetPv5C7CUwAjFwZ3PCAFhjiq/8bpmrretuj/M0FhAgd0CPydynmWs
         AQzAoGZbqu0A12BxOlHcdbcUSOaV3TN5PKNU8m+iCs7PFoU3gR6elf57i3fw3MAbzY4C
         RLI++Ua69aVsSg4hBUhEjjqXALnookPduH96IuLs90Y39FwxY5SAlf1yPrqO/cDHjI7Q
         2xwUwxObkFGGAOT/qvtsORX1IRuwyUbdAgFoH1tSiPoAvCEIVrfJOQYUnhf1U8madZeN
         zJVQ==
X-Gm-Message-State: AC+VfDwh6LiZx1TcqHx/U71EWHsw1iUGZjbzS9Dsse8KXRzzgU+/aAIz
        EkYLVFRmmh3BtRcDxsFts8RVeg==
X-Google-Smtp-Source: ACHHUZ64p6k1SQQCvQdz7hoW0BKm17SZqA5+P6NHHMQi/RxZCb5JCn9fnfZNSubNiaDqY0x4f0xurQ==
X-Received: by 2002:a05:6512:2315:b0:4f9:6a74:d149 with SMTP id o21-20020a056512231500b004f96a74d149mr12309413lfu.15.1687950238618;
        Wed, 28 Jun 2023 04:03:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id l5-20020a19c205000000b004f871c71827sm212702lfc.139.2023.06.28.04.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:03:58 -0700 (PDT)
Message-ID: <26be53d7-bcbd-618a-0d8a-f1c826dfd426@linaro.org>
Date:   Wed, 28 Jun 2023 13:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 2/5] clk: qcom: gcc-qdu1000: Fix
 gcc_pcie_0_pipe_clk_src clock handling
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
 <20230628092837.3090801-3-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628092837.3090801-3-quic_imrashai@quicinc.com>
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
> Fix the gcc_pcie_0_pipe_clk_src clock handling for QDU1000 and
> QRU1000 SoCs.
> 
> Fixes: 1c9efb0bc040 ("clk: qcom: Add QDU1000 and QRU1000 GCC support")
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---You could have explained that clk_regmap_phy_mux_ops doesn't implement
any parent-related ops and switches parents implicitly in .enable/disable

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes since v1:
>  - Newly added
> 
>  drivers/clk/qcom/gcc-qdu1000.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index 5051769ad90c..c00d26a3e6df 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -370,16 +370,6 @@ static const struct clk_parent_data gcc_parent_data_6[] = {
>  	{ .index = DT_TCXO_IDX },
>  };
>  
> -static const struct parent_map gcc_parent_map_7[] = {
> -	{ P_PCIE_0_PIPE_CLK, 0 },
> -	{ P_BI_TCXO, 2 },
> -};
> -
> -static const struct clk_parent_data gcc_parent_data_7[] = {
> -	{ .index = DT_PCIE_0_PIPE_CLK_IDX },
> -	{ .index = DT_TCXO_IDX },
> -};
> -
>  static const struct parent_map gcc_parent_map_8[] = {
>  	{ P_BI_TCXO, 0 },
>  	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> @@ -439,16 +429,15 @@ static struct clk_regmap_mux gcc_pcie_0_phy_aux_clk_src = {
>  	},
>  };
>  
> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
>  	.reg = 0x9d064,
> -	.shift = 0,
> -	.width = 2,
> -	.parent_map = gcc_parent_map_7,
>  	.clkr = {
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_pcie_0_pipe_clk_src",
> -			.parent_data = gcc_parent_data_7,
> -			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_PCIE_0_PIPE_CLK_IDX,
> +			},
> +			.num_parents = 1,
>  			.ops = &clk_regmap_phy_mux_ops,
>  		},
>  	},
