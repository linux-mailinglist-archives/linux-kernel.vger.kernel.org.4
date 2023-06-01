Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E77198BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjFAKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjFAKNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:13:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210010DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:11:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so741382e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614294; x=1688206294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhoCA2QH36QfcbROSHzKcbe/jXpRfD6WBXnyxhagi1E=;
        b=CCMbzbS5b+dydseaXKkcp50fuol2wgEDqsgwXJOGl0Co4REzxZhTqtl5/zV7vRQR7E
         FRRUF/pO904u3TTfEDuaW3eI4e3pVMd3/Zh/HJ2qOjG0PnGeSoLexByFjpJVimLwzxg3
         0KtrtZ2c9CrNJgfBI86IEmUT3JkEaMPufPRibexbdxKywRErb+9smvA4w1qC1mJbVN3n
         7nJ3bA7uh27TJT+DSr/ymZ9U8aB5PEHFO8AKt/oOyBg2BaQduV0S1M6/nBGgL/ORten2
         Y7W6V6ZA6z2J1MRvGhMXjIDBMaV/Xbr8Nt3HaS2HGx/Q1yyOqnClmVY3vzv+oyu1BFq1
         RG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614294; x=1688206294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhoCA2QH36QfcbROSHzKcbe/jXpRfD6WBXnyxhagi1E=;
        b=OC+px0yVVZPPSMpzKfsdIJj7d143MWH81INDP3Yq9IAZLyyCnxLB7CWSmA/8rFBkcq
         z5GUNaSyM8KrUa2V5UGNz/knciJ2t+R+xOKoOE06ua/Gw5HydNCs21wfkVrLEj8Q5NGy
         rOoxmATnwASCEvEv5PD3Q5ioI8TtI+rocY0UTKBUsv2PBggKKTGyf+yM21kAKs3PTdGg
         VWPEGoOfttVFHbO6dAIZU7sJ9PUQi1Ab5k+y0RI3k8HwU0psCaO/e6CuaijRGHKHIPM0
         4CxZ9vMQBEzzwmUxDeISK/vvItnD9/Z0CRfp6MBnIRQzTCxk9aTFS2ITbwTpDSBV93mp
         sWXg==
X-Gm-Message-State: AC+VfDzc4oTspSqL93aBH/7addbOIojNrDjCMva0KppSAaYi8O4zbuej
        /NjYeIrJljNy7zJhtU4wg/0/rg==
X-Google-Smtp-Source: ACHHUZ6DstT5A89g1x2UBpqfrgPbEFOThpcTPNihppqvdqilfsIK5o2ku3Ae+zriTliT5YIHSJz05w==
X-Received: by 2002:a19:5208:0:b0:4f3:a3e0:8502 with SMTP id m8-20020a195208000000b004f3a3e08502mr972806lfb.33.1685614294192;
        Thu, 01 Jun 2023 03:11:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25a09000000b004db51387ad6sm1039964lfn.129.2023.06.01.03.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:11:33 -0700 (PDT)
Message-ID: <1e846ba0-c8dc-5a93-538e-42457c557580@linaro.org>
Date:   Thu, 1 Jun 2023 13:11:33 +0300
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
 <62eaf77a-94c4-0a48-e335-83664fe343db@linaro.org>
 <8cb8b647-8efb-e140-5575-52785b4e93d3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8cb8b647-8efb-e140-5575-52785b4e93d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 13:10, Konrad Dybcio wrote:
> 
> 
> On 1.06.2023 12:08, Dmitry Baryshkov wrote:
>> On 30/05/2023 13:20, Konrad Dybcio wrote:
>>> Assign the necessary definitions to migrate to the new bus clock
>>> handling mechanism.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/interconnect/qcom/msm8996.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>>> index 1f7e88a37acd..a596f4035d2e 100644
>>> --- a/drivers/interconnect/qcom/msm8996.c
>>> +++ b/drivers/interconnect/qcom/msm8996.c
>>> @@ -1840,6 +1840,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = a1noc_nodes,
>>>        .num_nodes = ARRAY_SIZE(a1noc_nodes),
>>> +    .bus_clk_desc = &aggre1_branch_clk,
>>>        .regmap_cfg = &msm8996_a1noc_regmap_config
>>>    };
>>>    @@ -1861,6 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = a2noc_nodes,
>>>        .num_nodes = ARRAY_SIZE(a2noc_nodes),
>>> +    .bus_clk_desc = &aggre2_branch_clk,
>>>        .intf_clocks = a2noc_intf_clocks,
>>>        .num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>>>        .regmap_cfg = &msm8996_a2noc_regmap_config
>>> @@ -1889,6 +1891,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
>>>        .type = QCOM_ICC_BIMC,
>>>        .nodes = bimc_nodes,
>>>        .num_nodes = ARRAY_SIZE(bimc_nodes),
>>> +    .bus_clk_desc = &bimc_clk,
>>>        .regmap_cfg = &msm8996_bimc_regmap_config
>>>    };
>>>    @@ -1947,6 +1950,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = cnoc_nodes,
>>>        .num_nodes = ARRAY_SIZE(cnoc_nodes),
>>> +    .bus_clk_desc = &bus_2_clk,
>>>        .regmap_cfg = &msm8996_cnoc_regmap_config
>>>    };
>>>    @@ -2000,6 +2004,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = mnoc_nodes,
>>>        .num_nodes = ARRAY_SIZE(mnoc_nodes),
>>> +    .bus_clk_desc = &mmaxi_0_clk,
>>
>> What about an ahb_clk_src here?
> This should be remodeled to MNoC (MMAXI clk) + MNoC_AHB (ahb_clk_src).
> 
> I can fix this after this series.

As long as it doesn't result in a regression.

> Konrad
>>
>>>        .intf_clocks = mm_intf_clocks,
>>>        .num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>>>        .regmap_cfg = &msm8996_mnoc_regmap_config
>>> @@ -2038,6 +2043,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = pnoc_nodes,
>>>        .num_nodes = ARRAY_SIZE(pnoc_nodes),
>>> +    .bus_clk_desc = &bus_0_clk,
>>>        .regmap_cfg = &msm8996_pnoc_regmap_config
>>>    };
>>>    @@ -2082,6 +2088,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
>>>        .type = QCOM_ICC_NOC,
>>>        .nodes = snoc_nodes,
>>>        .num_nodes = ARRAY_SIZE(snoc_nodes),
>>> +    .bus_clk_desc = &bus_1_clk,
>>>        .regmap_cfg = &msm8996_snoc_regmap_config
>>>    };
>>>   
>>

-- 
With best wishes
Dmitry

