Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FE719886
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjFAKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjFAKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923C61715
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:08:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so705181e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614118; x=1688206118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LId+xDs8gP3XAdJnMwsTdg3eMFNvv8hWyJliU34ljxU=;
        b=hpCdrezfqk5s+aWf2dZz/Bwfa67Sj3DPRzE4/ot5Z3FX6HZSPfsyeNWBXBFRB/WJlD
         ZS4R5HNfKw9R6gxwZCsGe7Uq8/+8UcCSIN8zjbYizNoO2TLaY30NYZKL4/eKRQ6TOn5z
         U3ne+idykm1rIyWxfOgT81mCDsYbS+yCmniq4MJYBrusDt4ha6E7qoVkuJX1m5RCBIfh
         zKvOZV4BBaqf0yKk4RnP/o+u1GE+v3VLdo5ZL4qOxZqDIrlt1eKyxZyvr/2SBjmjpXOP
         Z0uIGtvqTlm2TSIEOz64PAucSEef9U7WSTXkuH4znHVmDHIG/XpljRR6phZQubp7Ghfx
         KKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614118; x=1688206118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LId+xDs8gP3XAdJnMwsTdg3eMFNvv8hWyJliU34ljxU=;
        b=gTYdQgcqOimZ0hPKf8Z3T3E6ZEIseF+iwYN0sDHKMdBmxgi2jf1cp7YYhddEyJAYvS
         NVBw1LhCRd/L+KeEK8t563yY0iVkFadTNXtLX+LgjXc4DlBF9KdIWcpaJ4o14KR83twS
         9L079wsZF0iIlJz+vLfu9yy214kabVVOsDlxOxRHYukG0MNftxz0l4oT7UgQg1VV8nuT
         dqQ7JCK6ecri+8uLpj+aDTM4kpT9ngeLIAOA5uiAA9abu+iO3I/7NSiYAbGtEijce9fZ
         V90zx3PjyyW56diM2/kIoXAqJae6n45tAywEF2vnN5OuCCf9dtg7VEjKbj69LJQFrT9d
         9h4A==
X-Gm-Message-State: AC+VfDwH9LcU8K2CpaeFETLGic1GL0ot3rQ59L6NZgedAFQDgXGIQs16
        /qLROkHjkyDdAXwM6RTk1vU8gA==
X-Google-Smtp-Source: ACHHUZ5e8k80mJSMgWGc7MYP9JQ1Kv0aw/gHHXJ0neEqFsMcnHIU4bYKqC0lHp386LiXqqMi3+DvlQ==
X-Received: by 2002:a19:f718:0:b0:4f3:dd96:bf55 with SMTP id z24-20020a19f718000000b004f3dd96bf55mr984726lfe.11.1685614117820;
        Thu, 01 Jun 2023 03:08:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a056512040200b004f4c3feb9f1sm1039655lfk.62.2023.06.01.03.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:08:37 -0700 (PDT)
Message-ID: <62eaf77a-94c4-0a48-e335-83664fe343db@linaro.org>
Date:   Thu, 1 Jun 2023 13:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/20] interconnect: qcom: msm8996: Hook up RPM bus clk
 definitions
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-12-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-12-1bf8e6663c4e@linaro.org>
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

On 30/05/2023 13:20, Konrad Dybcio wrote:
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8996.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 1f7e88a37acd..a596f4035d2e 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -1840,6 +1840,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = a1noc_nodes,
>   	.num_nodes = ARRAY_SIZE(a1noc_nodes),
> +	.bus_clk_desc = &aggre1_branch_clk,
>   	.regmap_cfg = &msm8996_a1noc_regmap_config
>   };
>   
> @@ -1861,6 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = a2noc_nodes,
>   	.num_nodes = ARRAY_SIZE(a2noc_nodes),
> +	.bus_clk_desc = &aggre2_branch_clk,
>   	.intf_clocks = a2noc_intf_clocks,
>   	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>   	.regmap_cfg = &msm8996_a2noc_regmap_config
> @@ -1889,6 +1891,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
>   	.type = QCOM_ICC_BIMC,
>   	.nodes = bimc_nodes,
>   	.num_nodes = ARRAY_SIZE(bimc_nodes),
> +	.bus_clk_desc = &bimc_clk,
>   	.regmap_cfg = &msm8996_bimc_regmap_config
>   };
>   
> @@ -1947,6 +1950,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = cnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(cnoc_nodes),
> +	.bus_clk_desc = &bus_2_clk,
>   	.regmap_cfg = &msm8996_cnoc_regmap_config
>   };
>   
> @@ -2000,6 +2004,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = mnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(mnoc_nodes),
> +	.bus_clk_desc = &mmaxi_0_clk,

What about an ahb_clk_src here?

>   	.intf_clocks = mm_intf_clocks,
>   	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>   	.regmap_cfg = &msm8996_mnoc_regmap_config
> @@ -2038,6 +2043,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = pnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(pnoc_nodes),
> +	.bus_clk_desc = &bus_0_clk,
>   	.regmap_cfg = &msm8996_pnoc_regmap_config
>   };
>   
> @@ -2082,6 +2088,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
>   	.type = QCOM_ICC_NOC,
>   	.nodes = snoc_nodes,
>   	.num_nodes = ARRAY_SIZE(snoc_nodes),
> +	.bus_clk_desc = &bus_1_clk,
>   	.regmap_cfg = &msm8996_snoc_regmap_config
>   };
>   
> 

-- 
With best wishes
Dmitry

