Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF56BB8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjCOQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjCOQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:02:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966119270C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:01:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j11so24880542lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AV6slw0BlCofNDOL7OtplUvQsJbc6koKav7PXxWHhFQ=;
        b=OcQm6Rm4xud1BP9QMbDcixJz2WgnENC5P/DfJhAe20tUrLih4nHymbLH6dTCtkb7V6
         kg4qXBuIqu2l1ubJya3vzPClYSqkzjLsjp0yQuEIrToJJTZ/TQZqZK4ic83JA9rCKuEh
         jrSytU4cpLxxqxtcSqSILUvGfWL3Bp9B3SVGfZv7gVghBWxO8L8xPndOTPVZEXpmOzm0
         PhlpV+9cyqumdmTkYPvD+yoYGMqlER1ndsREwsPX98EI/jaj+z1pZ/TNVsucl6OujggC
         kuWZ72e0NSX+Fl9kISMRSnliRE8saXFcbROWofw6mTzUcU8zFrXqzpJ3W5N2tYdycCXq
         5VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV6slw0BlCofNDOL7OtplUvQsJbc6koKav7PXxWHhFQ=;
        b=oaoyHxeovCXcWlTkd3hjP9otprDMJ+HZ4PiZw506ev8m6KNwqbcJUzJixHDW0TazN4
         TaRXu0Aq0NSzkm/GO2Tic0VJkCvjM8/AfA+ATMbp5pUdsrXfWTYq6zDfW1VwzCOq7wwC
         o+eXjm+aZfpi8L6Bp4n6gpWUl9YNVSKrFRGX1Dg/Maf8PwwjJrF9Hqrq4WDTCehPdZVd
         7hU3K+inV3J06hX2Iy18rieHbxaK3s2UeDiGP/B0dVsHTkpL3nIgJeYueuXtxkVl6hc4
         uBvT8MnGSg9FhaTSA27wNoOeCvSB0ciVJz4Fb4ZJ7bTHPtgJTgJw2XP5GveeoKd3DzVq
         TwnA==
X-Gm-Message-State: AO0yUKVS9N4IA8X2H9jPHFf87+UvJil9jHyS1aNK5pCgiD23eZqXIrjL
        tvITnaCycQ8ADHvoPqWfMs7iFA==
X-Google-Smtp-Source: AK7set9/RT7uN+0SqUFI+uXFVP9GYW5EZG8HpQWu7JYe/XDNT3IV69sXe7aP5+/1FRlrYuMBI90FIA==
X-Received: by 2002:ac2:42cd:0:b0:4e8:5e39:6233 with SMTP id n13-20020ac242cd000000b004e85e396233mr881747lfl.64.1678896100838;
        Wed, 15 Mar 2023 09:01:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id c17-20020ac244b1000000b004cee11feda1sm866517lfm.9.2023.03.15.09.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:01:40 -0700 (PDT)
Message-ID: <caf0530a-aff3-1d36-1559-7a3320d0b036@linaro.org>
Date:   Wed, 15 Mar 2023 17:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] clk: qcom: remove unused variables
 gpucc_parent_data,map_2
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, andersson@kernel.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315155630.1740065-1-trix@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315155630.1740065-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.2023 16:56, Tom Rix wrote:
> gcc with W=1 reports these errors
> drivers/clk/qcom/gpucc-sm6375.c:145:37: error:
>   ‘gpucc_parent_data_2’ defined but not used [-Werror=unused-const-variable=]
>   145 | static const struct clk_parent_data gpucc_parent_data_2[] = {
>       |                                     ^~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm6375.c:139:32: error:
>   ‘gpucc_parent_map_2’ defined but not used [-Werror=unused-const-variable=]
>   139 | static const struct parent_map gpucc_parent_map_2[] = {
>       |                                ^~~~~~~~~~~~~~~~~~
> 
> These variables are not used, so remove them.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/gpucc-sm6375.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
> index eb9ffa956950..d8f4c4b59f1b 100644
> --- a/drivers/clk/qcom/gpucc-sm6375.c
> +++ b/drivers/clk/qcom/gpucc-sm6375.c
> @@ -136,18 +136,6 @@ static const struct clk_parent_data gpucc_parent_data_1[] = {
>  	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
>  };
>  
> -static const struct parent_map gpucc_parent_map_2[] = {
> -	{ P_BI_TCXO, 0 },
> -	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
> -	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
> -};
> -
> -static const struct clk_parent_data gpucc_parent_data_2[] = {
> -	{ .index = P_BI_TCXO },
> -	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
> -	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
> -};
> -
>  static const struct freq_tbl ftbl_gpucc_gmu_clk_src[] = {
>  	F(200000000, P_GCC_GPU_GPLL0_DIV_CLK_SRC, 1.5, 0, 0),
>  	{ }
